import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import 'leaderboard_endpoint.dart';

class QuizEndpoint extends Endpoint {
  /// Returns questions for a subject WITHOUT answer keys (authoritative, cheat-proof).
  Future<List<QuizQuestionView>> getQuestionsForSubject(
    Session session,
    String subject, {
    int limit = 10,
  }) async {
    final questions = await QuizQuestion.db.find(
      session,
      where: (t) => t.subject.equals(subject),
      limit: limit.clamp(1, 20),
    );

    return questions
        .map(
          (q) => QuizQuestionView(
            id: q.id!,
            subject: q.subject,
            question: q.question,
            options: q.options,
          ),
        )
        .toList();
  }

  /// Evaluates quiz answers securely on the server and persists the attempt.
  /// Idempotent: resubmitting with the same attemptId returns existing results
  /// without re-scoring or double-posting to the leaderboard.
  /// Legitimate retakes with new attemptIds are cleanly tracked with isRetake=true.
  Future<QuizResultSummary> submitQuiz(
    Session session,
    QuizSubmission submission,
  ) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated to submit quizzes.');
    }

    if (submission.answers.isEmpty) {
      throw ArgumentError('Submission cannot be empty.');
    }

    final studentProfile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final studentName = studentProfile?.fullName ?? 'Student';
    final studentBranch = studentProfile?.branch ?? 'CSE';

    final attemptKey = submission.attemptId?.trim();

    // 1. Idempotency check: If this attemptId was already recorded, return cached summary
    if (attemptKey != null && attemptKey.isNotEmpty) {
      final existingAttempt = await QuizAttempt.db.findFirstRow(
        session,
        where:
            (t) =>
                t.authUserId.equals(authUserId) &
                t.attemptId.equals(attemptKey),
      );

      if (existingAttempt != null) {
        // Rebuild items for identical response without mutating state or leaderboard
        final resultItems = <QuizResultItem>[];
        for (final ans in submission.answers) {
          final q = await QuizQuestion.db.findById(session, ans.questionId);
          if (q != null) {
            final isCorrect = q.correctOptionIndex == ans.selectedOptionIndex;
            resultItems.add(
              QuizResultItem(
                questionId: q.id!,
                question: q.question,
                options: q.options,
                selectedOptionIndex: ans.selectedOptionIndex,
                correctOptionIndex: q.correctOptionIndex,
                isCorrect: isCorrect,
                explanation: q.explanation,
              ),
            );
          }
        }

        return QuizResultSummary(
          attemptId: existingAttempt.id!,
          subject: existingAttempt.subject,
          score: existingAttempt.score,
          totalQuestions: existingAttempt.totalQuestions,
          percentage: existingAttempt.percentage,
          durationSeconds: existingAttempt.durationSeconds,
          completedAt: existingAttempt.completedAt,
          items: resultItems,
        );
      }
    }

    // 2. Authoritative server-side grading
    int score = 0;
    final totalQuestions = submission.answers.length;
    final resultItems = <QuizResultItem>[];

    for (final ans in submission.answers) {
      final q = await QuizQuestion.db.findById(session, ans.questionId);
      if (q != null) {
        final isCorrect = q.correctOptionIndex == ans.selectedOptionIndex;
        if (isCorrect) {
          score++;
        }
        resultItems.add(
          QuizResultItem(
            questionId: q.id!,
            question: q.question,
            options: q.options,
            selectedOptionIndex: ans.selectedOptionIndex,
            correctOptionIndex: q.correctOptionIndex,
            isCorrect: isCorrect,
            explanation: q.explanation,
          ),
        );
      }
    }

    final percentage =
        totalQuestions > 0 ? (score / totalQuestions) * 100.0 : 0.0;
    final now = DateTime.now().toUtc();

    // 3. Legitimate retake tracking: count prior attempts on this subject
    final priorAttemptsCount = await QuizAttempt.db.count(
      session,
      where:
          (t) =>
              t.authUserId.equals(authUserId) &
              t.subject.equals(submission.subject),
    );
    final attemptNumber = priorAttemptsCount + 1;
    final isRetake = priorAttemptsCount > 0;

    final effectiveAttemptId =
        (attemptKey != null && attemptKey.isNotEmpty)
            ? attemptKey
            : '${DateTime.now().microsecondsSinceEpoch}-${authUserId.toString().substring(0, 8)}';

    // 4. Persist new attempt
    final attempt = await QuizAttempt.db.insertRow(
      session,
      QuizAttempt(
        attemptId: effectiveAttemptId,
        authUserId: authUserId,
        studentName: studentName,
        studentBranch: studentBranch,
        subject: submission.subject,
        quizId: submission.quizId ?? submission.subject,
        score: score,
        totalQuestions: totalQuestions,
        percentage: percentage,
        durationSeconds: submission.durationSeconds.clamp(1, 3600),
        attemptNumber: attemptNumber,
        isRetake: isRetake,
        completedAt: now,
      ),
    );

    // 5. Broadcast real-time leaderboard update
    await session.messages.postMessage(
      LeaderboardEndpoint.leaderboardChannel,
      LeaderboardUpdate(
        subject: submission.subject,
        studentName: studentName,
        score: score,
        updatedAt: now,
      ),
    );

    return QuizResultSummary(
      attemptId: attempt.id!,
      subject: submission.subject,
      score: score,
      totalQuestions: totalQuestions,
      percentage: percentage,
      durationSeconds: submission.durationSeconds,
      completedAt: now,
      items: resultItems,
    );
  }

  /// Retrieves past attempts for the current user.
  Future<List<QuizAttempt>> getMyAttempts(
    Session session, {
    String? subject,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return [];

    return await QuizAttempt.db.find(
      session,
      where: (t) {
        Expression expr = t.authUserId.equals(authUserId);
        if (subject != null && subject.isNotEmpty && subject != 'All') {
          expr = expr & t.subject.equals(subject);
        }
        return expr;
      },
      orderBy: (t) => t.completedAt.desc(),
      limit: 50,
    );
  }
}
