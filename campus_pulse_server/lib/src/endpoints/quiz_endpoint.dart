import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class QuizEndpoint extends Endpoint {
  static const String leaderboardChannel = 'leaderboard_channel';

  Future<List<QuizQuestion>> getQuestions(
    Session session, {
    required String subject,
  }) async {
    return await QuizQuestion.db.find(
      session,
      where: (t) => t.subject.equals(subject),
      limit: 5,
    );
  }

  Future<QuizScore> submitScore(
    Session session, {
    required int studentId,
    required String subject,
    required int score,
  }) async {
    final record = QuizScore(
      studentId: studentId,
      subject: subject,
      score: score,
      createdAt: DateTime.now(),
    );

    final saved = await QuizScore.db.insertRow(session, record);

    final student = await Student.db.findById(session, studentId);
    final entry = LeaderboardEntry(
      studentName: student?.name ?? 'Anonymous Student',
      branch: student?.branch ?? 'General',
      year: student?.year ?? 1,
      subject: subject,
      score: score,
      createdAt: record.createdAt,
    );

    session.messages.postMessage(leaderboardChannel, entry);

    return saved;
  }

  Future<List<LeaderboardEntry>> getLeaderboard(
    Session session, {
    String? subject,
  }) async {
    final allScores = (subject != null && subject.isNotEmpty && subject.toLowerCase() != 'all')
        ? await QuizScore.db.find(session, where: (t) => t.subject.equals(subject))
        : await QuizScore.db.find(session);

    final students = await Student.db.find(session);
    final studentMap = {for (final s in students) s.id: s};

    final entries = allScores.map((score) {
      final student = studentMap[score.studentId];
      return LeaderboardEntry(
        studentName: student?.name ?? 'Student #${score.studentId}',
        branch: student?.branch ?? 'Engineering',
        year: student?.year ?? 1,
        subject: score.subject,
        score: score.score,
        createdAt: score.createdAt,
      );
    }).toList();

    entries.sort((a, b) {
      final cmp = b.score.compareTo(a.score);
      if (cmp != 0) return cmp;
      return b.createdAt.compareTo(a.createdAt);
    });

    return entries;
  }
}
