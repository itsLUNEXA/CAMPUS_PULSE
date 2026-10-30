import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class LeaderboardEndpoint extends Endpoint {
  static const String leaderboardChannel = 'campus-leaderboard-channel';

  /// Computes authoritative leaderboard rankings from persisted quiz attempts.
  Future<List<LeaderboardEntry>> getLeaderboard(
    Session session, {
    String? subject,
    String? branch,
    int limit = 20,
    int offset = 0,
  }) async {
    // Query bounded attempts to calculate ranking
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
        return expr;
      },
      limit: 200,
    );

    // Aggregate by student
    final studentStats = <UuidValue, _AggregatedStudentStats>{};
    for (final att in attempts) {
      final stats = studentStats.putIfAbsent(
        att.authUserId,
        () => _AggregatedStudentStats(
          authUserId: att.authUserId,
          studentName: att.studentName,
          branch: att.studentBranch,
        ),
      );
      stats.totalScore += att.score;
      stats.totalQuestions += att.totalQuestions;
      stats.quizzesTaken += 1;
      stats.bestDuration += att.durationSeconds;
    }

    final statsList = studentStats.values.toList();

    // Deterministic tie-breaking:
    // 1. Highest total score
    // 2. Highest quizzes taken
    // 3. Lowest total duration
    // 4. Alphabetical student name
    statsList.sort((a, b) {
      final scoreCmp = b.totalScore.compareTo(a.totalScore);
      if (scoreCmp != 0) return scoreCmp;

      final quizzesCmp = b.quizzesTaken.compareTo(a.quizzesTaken);
      if (quizzesCmp != 0) return quizzesCmp;

      final durCmp = a.bestDuration.compareTo(b.bestDuration);
      if (durCmp != 0) return durCmp;

      return a.studentName.compareTo(b.studentName);
    });

    final paged = statsList.skip(offset).take(limit.clamp(1, 50)).toList();

    final result = <LeaderboardEntry>[];
    for (int i = 0; i < paged.length; i++) {
      final st = paged[i];
      final accuracy = st.totalQuestions > 0
          ? (st.totalScore / st.totalQuestions) * 100.0
          : 0.0;

      result.add(
        LeaderboardEntry(
          rank: offset + i + 1,
          authUserId: st.authUserId,
          studentName: st.studentName,
          branch: st.branch,
          score: st.totalScore,
          quizzesTaken: st.quizzesTaken,
          accuracy: double.parse(accuracy.toStringAsFixed(1)),
        ),
      );
    }

    return result;
  }

  /// Retrieves the current student's leaderboard rank and statistics.
  Future<LeaderboardEntry?> getMyRank(
    Session session, {
    String? subject,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return null;

    final leaderboard = await getLeaderboard(
      session,
      subject: subject,
      limit: 100,
    );

    for (final entry in leaderboard) {
      if (entry.authUserId == authUserId) {
        return entry;
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
}

class _AggregatedStudentStats {
  final UuidValue authUserId;
  final String studentName;
  final String branch;
  int totalScore = 0;
  int totalQuestions = 0;
  int quizzesTaken = 0;
  int bestDuration = 0;

  _AggregatedStudentStats({
    required this.authUserId,
    required this.studentName,
    required this.branch,
  });
}
