import 'package:campus_pulse_server/src/generated/protocol.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Quiz Endpoint', (sessionBuilder, endpoints) {
    const studentId = '550e8400-e29b-41d4-a716-446655440003';
    final authedStudent = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(studentId, {}),
    );

    test(
      'when fetching questions then returns questions for subject',
      () async {
        final session = sessionBuilder.build();
        // Ensure test question exists
        final existing = await QuizQuestion.db.findFirstRow(
          session,
          where: (t) => t.subject.equals('DBMS'),
        );
        if (existing == null) {
          await QuizQuestion.db.insertRow(
            session,
            QuizQuestion(
              subject: 'DBMS',
              question: 'What does SQL stand for?',
              options: [
                'Structured Question Language',
                'Structured Query Language',
                'Simple Query Logic',
              ],
              correctOptionIndex: 1,
              explanation: 'SQL stands for Structured Query Language.',
              difficulty: 'Easy',
            ),
          );
        }

        final questions = await endpoints.quiz.getQuestionsForSubject(
          sessionBuilder,
          'DBMS',
          limit: 10,
        );

        expect(questions, isNotEmpty);
        expect(questions.first.question, isNotEmpty);
        expect(questions.first.options, isNotEmpty);
      },
    );

    test(
      'when submitting answers then score is calculated securely on server',
      () async {
        final session = sessionBuilder.build();
        final q = await QuizQuestion.db.insertRow(
          session,
          QuizQuestion(
            subject: 'Operating Systems',
            question: 'What is a Semaphore in OS?',
            options: [
              'A hardware bus',
              'A synchronization tool',
              'A network socket',
              'A compiler',
            ],
            correctOptionIndex: 1,
            explanation:
                'A semaphore is an integer variable used for process synchronization.',
            difficulty: 'Medium',
          ),
        );

        final submission = QuizSubmission(
          subject: 'Operating Systems',
          answers: [
            QuizAnswerSubmission(
              questionId: q.id!,
              selectedOptionIndex: 1,
            ), // Correct
          ],
          durationSeconds: 15,
        );

        final result = await endpoints.quiz.submitQuiz(
          authedStudent,
          submission,
        );

        expect(result.score, 1);
        expect(result.totalQuestions, 1);
        expect(result.percentage, 100.0);
        expect(result.items.first.isCorrect, isTrue);

        final myAttempts = await endpoints.quiz.getMyAttempts(
          authedStudent,
          subject: 'Operating Systems',
        );
        expect(myAttempts, isNotEmpty);
        expect(myAttempts.first.score, 1);
      },
    );
  });
}
