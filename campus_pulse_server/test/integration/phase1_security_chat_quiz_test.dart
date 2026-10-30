import 'package:campus_pulse_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Phase 1: Security, Chat & Quiz Integrity Tests',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      const studentAId = 'a0000000-0000-4000-8000-000000000001';
      const studentBId = 'a0000000-0000-4000-8000-000000000002';
      const studentCId = 'a0000000-0000-4000-8000-000000000003';
      const adminId = 'a0000000-0000-4000-8000-000000000099';

      final authedStudentA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(studentAId, {}),
      );
      final authedStudentB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(studentBId, {}),
      );
      final authedStudentC = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(studentCId, {}),
      );
      final authedAdmin = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(adminId, {Scope.admin}),
      );

      setUp(() async {
        final session = sessionBuilder.build();
        final now = DateTime.now().toUtc();

        // Seed Student A: CSE Year 3
        final existingA = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(studentAId)),
        );
        if (existingA == null) {
          await StudentProfile.db.insertRow(
            session,
            StudentProfile(
              authUserId: UuidValue.fromString(studentAId),
              fullName: 'Aarav Sharma',
              email: 'aarav@campus.edu',
              branch: 'CSE',
              academicYear: 3,
              hostelOrArea: 'Hostel A',
              subjectInterests: ['OS', 'DBMS'],
              createdAt: now,
              updatedAt: now,
            ),
          );
        }

        // Seed Student B: CSE Year 3
        final existingB = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(studentBId)),
        );
        if (existingB == null) {
          await StudentProfile.db.insertRow(
            session,
            StudentProfile(
              authUserId: UuidValue.fromString(studentBId),
              fullName: 'Neha Patel',
              email: 'neha@campus.edu',
              branch: 'CSE',
              academicYear: 3,
              hostelOrArea: 'Hostel B',
              subjectInterests: ['OS', 'DSA'],
              createdAt: now,
              updatedAt: now,
            ),
          );
        }

        // Seed Student C: ECE Year 1
        final existingC = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(studentCId)),
        );
        if (existingC == null) {
          await StudentProfile.db.insertRow(
            session,
            StudentProfile(
              authUserId: UuidValue.fromString(studentCId),
              fullName: 'Rohan Gupta',
              email: 'rohan@campus.edu',
              branch: 'ECE',
              academicYear: 1,
              hostelOrArea: 'Hostel C',
              subjectInterests: ['Circuits'],
              createdAt: now,
              updatedAt: now,
            ),
          );
        }

        // Seed Admin Role
        final existingAdmin = await UserRole.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(adminId)),
        );
        if (existingAdmin == null) {
          await UserRole.db.insertRow(
            session,
            UserRole(
              authUserId: UuidValue.fromString(adminId),
              role: 'admin',
              grantedAt: now,
            ),
          );
        }
      });

      group('Chat Membership & Security', () {
        test('unauthorized non-member student cannot read or send to a direct chat', () async {
          // Create direct chat between Student A and Student B
          final directRoom = await endpoints.chat.getOrCreateRoom(
            authedStudentA,
            roomType: 'direct',
            name: 'Aarav & Neha Direct',
            participantIds: [
              UuidValue.fromString(studentAId),
              UuidValue.fromString(studentBId),
            ],
          );

          // Student A can send message
          final msgA = await endpoints.chat.sendMessage(
            authedStudentA,
            roomId: directRoom.id!,
            content: 'Hey Neha, let us study OS processes.',
          );
          expect(msgA.senderName, equals('Aarav Sharma'));
          expect(msgA.senderUserId, equals(UuidValue.fromString(studentAId)));

          // Student B can read messages
          final msgsB = await endpoints.chat.getRoomMessages(
            authedStudentB,
            directRoom.id!,
            limit: 50,
          );
          expect(msgsB.length, greaterThanOrEqualTo(1));
          expect(msgsB.any((m) => m.content == 'Hey Neha, let us study OS processes.'), isTrue);

          // Student C (unauthorized) cannot read messages
          expect(
            endpoints.chat.getRoomMessages(authedStudentC, directRoom.id!, limit: 50),
            throwsA(isA<StateError>()),
          );

          // Student C (unauthorized) cannot send messages
          expect(
            endpoints.chat.sendMessage(
              authedStudentC,
              roomId: directRoom.id!,
              content: 'I want to eavesdrop!',
            ),
            throwsA(isA<StateError>()),
          );
        });

        test('verifies branch and year restrictions for academic community groups', () async {
          // Create CSE Year 3 academic group
          final cseRoom = await endpoints.chat.getOrCreateRoom(
            authedStudentA,
            roomType: 'academic_community',
            name: 'CSE Year 3 Official Community',
            participantIds: [UuidValue.fromString(studentAId)],
            allowedBranch: 'CSE',
            allowedAcademicYear: 3,
          );

          // Student B (CSE Year 3) has access
          final msgB = await endpoints.chat.sendMessage(
            authedStudentB,
            roomId: cseRoom.id!,
            content: 'Hello CSE Year 3 peers!',
          );
          expect(msgB.senderName, equals('Neha Patel'));

          // Student C (ECE Year 1) is blocked due to branch/year restriction
          expect(
            endpoints.chat.sendMessage(
              authedStudentC,
              roomId: cseRoom.id!,
              content: 'Can I join CSE Year 3?',
            ),
            throwsA(isA<StateError>()),
          );
        });

        test('message reporting and admin moderation workflow', () async {
          final directRoom = await endpoints.chat.getOrCreateRoom(
            authedStudentA,
            roomType: 'direct',
            name: 'Aarav & Neha Report Test',
            participantIds: [
              UuidValue.fromString(studentAId),
              UuidValue.fromString(studentBId),
            ],
          );

          final msg = await endpoints.chat.sendMessage(
            authedStudentA,
            roomId: directRoom.id!,
            content: 'Inappropriate spam text here',
          );

          // Student B reports Student A's message
          final report = await endpoints.chat.reportMessage(
            authedStudentB,
            messageId: msg.id!,
            reason: 'Spam / Advertising',
          );
          expect(report.status, equals('pending'));
          expect(report.reporterName, equals('Neha Patel'));

          // Admin lists reports
          final reports = await endpoints.chat.listChatReports(authedAdmin, status: 'pending');
          expect(reports.any((r) => r.id == report.id), isTrue);

          // Admin resolves report by deleting the message
          final resolved = await endpoints.chat.resolveChatReport(
            authedAdmin,
            reportId: report.id!,
            action: 'delete_message',
          );
          expect(resolved, isTrue);

          // Verify message is no longer returned in room messages
          final activeMsgs = await endpoints.chat.getRoomMessages(
            authedStudentB,
            directRoom.id!,
            limit: 50,
          );
          expect(activeMsgs.any((m) => m.id == msg.id), isFalse);
        });
      });

      group('Quiz Integrity & Idempotency', () {
        test('submitting identical attemptId returns idempotent result without duplicate rows', () async {
          final session = sessionBuilder.build();
          final q = await QuizQuestion.db.insertRow(
            session,
            QuizQuestion(
              subject: 'Computer Networks',
              question: 'Which layer is HTTP on?',
              options: ['Transport', 'Application', 'Network'],
              correctOptionIndex: 1,
              explanation: 'HTTP is an Application Layer protocol.',
              difficulty: 'Easy',
            ),
          );

          final attemptId = 'unique-attempt-token-${DateTime.now().microsecondsSinceEpoch}';
          final submission = QuizSubmission(
            attemptId: attemptId,
            subject: 'Computer Networks',
            durationSeconds: 45,
            answers: [
              QuizAnswerSubmission(questionId: q.id!, selectedOptionIndex: 1),
            ],
          );

          // First submission
          final result1 = await endpoints.quiz.submitQuiz(authedStudentA, submission);
          expect(result1.score, equals(1));
          expect(result1.percentage, equals(100.0));

          final countAfterFirst = await QuizAttempt.db.count(
            session,
            where: (t) => t.authUserId.equals(UuidValue.fromString(studentAId)) & t.attemptId.equals(attemptId),
          );
          expect(countAfterFirst, equals(1));

          // Duplicate submission (network retry / double-tap with same attemptId)
          final result2 = await endpoints.quiz.submitQuiz(authedStudentA, submission);
          expect(result2.score, equals(result1.score));
          expect(result2.attemptId, equals(result1.attemptId));

          final countAfterSecond = await QuizAttempt.db.count(
            session,
            where: (t) => t.authUserId.equals(UuidValue.fromString(studentAId)) & t.attemptId.equals(attemptId),
          );
          // Guaranteed exactly 1 row; idempotent!
          expect(countAfterSecond, equals(1));
        });

        test('legitimate retake with distinct attemptId records isRetake=true and incremented attemptNumber', () async {
          final session = sessionBuilder.build();
          var q = await QuizQuestion.db.findFirstRow(
            session,
            where: (t) => t.subject.equals('Operating Systems'),
          );
          q ??= await QuizQuestion.db.insertRow(
            session,
            QuizQuestion(
              subject: 'Operating Systems',
              question: 'What is a Semaphore?',
              options: ['Variable', 'Hardware', 'Cable'],
              correctOptionIndex: 0,
              explanation: 'A semaphore is an integer variable used for synchronization.',
              difficulty: 'Easy',
            ),
          );

          final firstAttemptId = 'first-attempt-${DateTime.now().microsecondsSinceEpoch}';
          await endpoints.quiz.submitQuiz(
            authedStudentA,
            QuizSubmission(
              attemptId: firstAttemptId,
              subject: 'Operating Systems',
              durationSeconds: 60,
              answers: [
                QuizAnswerSubmission(questionId: q.id!, selectedOptionIndex: 0),
              ],
            ),
          );

          final retakeAttemptId = 'retake-attempt-${DateTime.now().microsecondsSinceEpoch}';
          final retakeSubmission = QuizSubmission(
            attemptId: retakeAttemptId,
            subject: 'Operating Systems',
            durationSeconds: 30,
            answers: [
              QuizAnswerSubmission(questionId: q.id!, selectedOptionIndex: 0),
            ],
          );

          final retakeResult = await endpoints.quiz.submitQuiz(authedStudentA, retakeSubmission);
          expect(retakeResult.score, equals(1));

          final retakeAttemptRow = await QuizAttempt.db.findFirstRow(
            session,
            where: (t) => t.attemptId.equals(retakeAttemptId),
          );
          expect(retakeAttemptRow, isNotNull);
          expect(retakeAttemptRow!.isRetake, isTrue);
          expect(retakeAttemptRow.attemptNumber, greaterThanOrEqualTo(2));
        });
      });
    },
  );
}
