import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class LeaderboardEndpoint extends Endpoint {
  static const String leaderboardChannel = 'campus-leaderboard-channel';

  /// Computes authoritative leaderboard rankings from persisted quiz attempts.
  ///
  /// - Repeated attempts on the same quiz only count the student's best score (preventing farming).
  /// - Distinct quizzes (even within the same subject) are each scored independently (not collapsed).
  /// - Aggregates globally across all matching attempts before applying pagination.
  /// - Enforces deterministic tie-breaking:
  ///   1. Total score (descending)
  ///   2. Accuracy percentage (descending)
  ///   3. Cumulative duration (ascending / fastest)
  ///   4. Distinct quizzes taken (descending)
  ///   5. Earliest completion timestamp (ascending)
  ///   6. Student full name (alphabetical)
  /// - Preserves course (branch) and academic year separation.
  Future<List<LeaderboardEntry>> getLeaderboard(
    Session session, {
    String? subject,
    String? branch,
    int? academicYear,
    int limit = 20,
    int offset = 0,
  }) async {
    final statsList = await _computeRankedStats(
      session,
      subject: subject,
      branch: branch,
      academicYear: academicYear,
    );

    final paged = statsList.skip(offset).take(limit.clamp(1, 100)).toList();

    final result = <LeaderboardEntry>[];
    for (int i = 0; i < paged.length; i++) {
      final st = paged[i];
      result.add(
        LeaderboardEntry(
          rank: offset + i + 1,
          authUserId: st.authUserId,
          studentName: st.studentName,
          branch: st.branch,
          academicYear: st.academicYear,
          score: st.totalScore,
          quizzesTaken: st.quizzesTaken,
          accuracy: double.parse(st.accuracy.toStringAsFixed(1)),
        ),
      );
    }

    return result;
  }

  /// Retrieves the current student's leaderboard rank and statistics.
  Future<LeaderboardEntry?> getMyRank(
    Session session, {
    String? subject,
    String? branch,
    int? academicYear,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return null;

    final statsList = await _computeRankedStats(
      session,
      subject: subject,
      branch: branch,
      academicYear: academicYear,
    );

    for (int i = 0; i < statsList.length; i++) {
      final st = statsList[i];
      if (st.authUserId == authUserId) {
        return LeaderboardEntry(
          rank: i + 1,
          authUserId: st.authUserId,
          studentName: st.studentName,
          branch: st.branch,
          academicYear: st.academicYear,
          score: st.totalScore,
          quizzesTaken: st.quizzesTaken,
          accuracy: double.parse(st.accuracy.toStringAsFixed(1)),
        );
      }
    }
    return null;
  }

  /// Streams real-time leaderboard update notifications to connected clients.
  Stream<LeaderboardUpdate> streamLeaderboardUpdates(Session session) async* {
    final stream = session.messages.createStream<LeaderboardUpdate>(
      leaderboardChannel,
    );
    await for (final update in stream) {
      yield update;
    }
  }

  /// Internal helper that queries all attempts without arbitrary row limits,
  /// groups by student and distinct quiz, computes best scores, and sorts deterministically.
  Future<List<_AggregatedStudentStats>> _computeRankedStats(
    Session session, {
    String? subject,
    String? branch,
    int? academicYear,
  }) async {
    final attempts = await QuizAttempt.db.find(
      session,
      where: (t) {
        Expression expr = Constant.bool(true);
        if (subject != null && subject.isNotEmpty && subject != 'All') {
          expr = expr & t.subject.equals(subject);
        }
        if (branch != null && branch.isNotEmpty && branch != 'All') {
          expr = expr & t.studentBranch.equals(branch);
        }
        if (academicYear != null && academicYear > 0) {
          expr = expr & t.academicYear.equals(academicYear);
        }
        return expr;
      },
      orderBy: (t) => t.completedAt.desc(),
    );

    final studentQuizAttempts = <UuidValue, Map<String, QuizAttempt>>{};
    final studentMetadata = <UuidValue, _StudentMeta>{};

    for (final att in attempts) {
      studentMetadata.putIfAbsent(
        att.authUserId,
        () => _StudentMeta(
          authUserId: att.authUserId,
          studentName: att.studentName,
          branch: att.studentBranch,
          academicYear: att.academicYear ?? 1,
        ),
      );

      final quizzes = studentQuizAttempts.putIfAbsent(
        att.authUserId,
        () => <String, QuizAttempt>{},
      );

      final quizKey =
          (att.quizId != null && att.quizId!.trim().isNotEmpty)
              ? att.quizId!.trim()
              : att.subject.trim();

      final existingBest = quizzes[quizKey];
      if (existingBest == null) {
        quizzes[quizKey] = att;
      } else {
        // Repeated attempt policy: select best performance on this distinct quiz
        if (att.score > existingBest.score) {
          quizzes[quizKey] = att;
        } else if (att.score == existingBest.score) {
          if (att.durationSeconds < existingBest.durationSeconds) {
            quizzes[quizKey] = att;
          } else if (att.durationSeconds == existingBest.durationSeconds &&
              att.completedAt.isBefore(existingBest.completedAt)) {
            quizzes[quizKey] = att;
          }
        }
      }
    }

    final statsList = <_AggregatedStudentStats>[];
    for (final entry in studentQuizAttempts.entries) {
      final userId = entry.key;
      final meta = studentMetadata[userId]!;
      final bestAttempts = entry.value.values;

      int totalScore = 0;
      int totalQuestions = 0;
      int totalDuration = 0;
      DateTime? earliestCompletion;

      for (final att in bestAttempts) {
        totalScore += att.score;
        totalQuestions += att.totalQuestions;
        totalDuration += att.durationSeconds;
        if (earliestCompletion == null ||
            att.completedAt.isBefore(earliestCompletion)) {
          earliestCompletion = att.completedAt;
        }
      }

      final double accuracy =
          totalQuestions > 0 ? (totalScore / totalQuestions) * 100.0 : 0.0;

      statsList.add(
        _AggregatedStudentStats(
          authUserId: userId,
          studentName: meta.studentName,
          branch: meta.branch,
          academicYear: meta.academicYear,
          totalScore: totalScore,
          totalQuestions: totalQuestions,
          quizzesTaken: bestAttempts.length,
          bestDuration: totalDuration,
          accuracy: accuracy,
          earliestCompletion: earliestCompletion ?? DateTime.now().toUtc(),
        ),
      );
    }

    // Deterministic tie-breaking:
    // 1. Highest total score
    // 2. Highest accuracy percentage
    // 3. Lowest cumulative duration (speed)
    // 4. Highest distinct quizzes taken
    // 5. Earliest completion timestamp
    // 6. Alphabetical student name
    statsList.sort((a, b) {
      final scoreCmp = b.totalScore.compareTo(a.totalScore);
      if (scoreCmp != 0) return scoreCmp;

      final accCmp = b.accuracy.compareTo(a.accuracy);
      if (accCmp != 0) return accCmp;

      final durCmp = a.bestDuration.compareTo(b.bestDuration);
      if (durCmp != 0) return durCmp;

      final quizzesCmp = b.quizzesTaken.compareTo(a.quizzesTaken);
      if (quizzesCmp != 0) return quizzesCmp;

      final timeCmp = a.earliestCompletion.compareTo(b.earliestCompletion);
      if (timeCmp != 0) return timeCmp;

      return a.studentName.toLowerCase().compareTo(b.studentName.toLowerCase());
    });

    return statsList;
  }
}

class _StudentMeta {
  final UuidValue authUserId;
  final String studentName;
  final String branch;
  final int academicYear;

  _StudentMeta({
    required this.authUserId,
    required this.studentName,
    required this.branch,
    required this.academicYear,
  });
}

class _AggregatedStudentStats {
  final UuidValue authUserId;
  final String studentName;
  final String branch;
  final int academicYear;
  final int totalScore;
  final int totalQuestions;
  final int quizzesTaken;
  final int bestDuration;
  final double accuracy;
  final DateTime earliestCompletion;

  _AggregatedStudentStats({
    required this.authUserId,
    required this.studentName,
    required this.branch,
    required this.academicYear,
    required this.totalScore,
    required this.totalQuestions,
    required this.quizzesTaken,
    required this.bestDuration,
    required this.accuracy,
    required this.earliestCompletion,
  });
}
