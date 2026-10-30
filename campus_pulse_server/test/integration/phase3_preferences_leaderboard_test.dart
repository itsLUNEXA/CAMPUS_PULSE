import 'package:campus_pulse_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Phase 3: Preferences and Leaderboards Tests',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      const studentAId = 'c0000000-0000-4000-8000-000000000001';
      const studentBId = 'c0000000-0000-4000-8000-000000000002';
      const studentCId = 'c0000000-0000-4000-8000-000000000003';

      final authedStudentA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(studentAId, {}),
      );

      setUp(() async {
        final session = sessionBuilder.build();
        final now = DateTime.now().toUtc();

        // Seed Student A: CSE Year 2, interested in Hackathons and Tech
        final existingA = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(studentAId)),
        );
        if (existingA == null) {
          await StudentProfile.db.insertRow(
            session,
            StudentProfile(
              authUserId: UuidValue.fromString(studentAId),
              fullName: 'Aarav Patel',
              email: 'aarav.patel@campus.edu',
              branch: 'CSE',
              academicYear: 2,
              hostelOrArea: 'Hostel A',
              subjectInterests: ['DSA', 'DBMS'],
              eventInterests: ['Hackathon', 'Tech'],
              preferredQuizSubjects: ['Data Structures and Algorithms'],
              preferredQuizTypes: ['Code Analysis'],
              createdAt: now,
              updatedAt: now,
            ),
          );
        }

        // Seed Student B: ECE Year 3
        final existingB = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(studentBId)),
        );
        if (existingB == null) {
          await StudentProfile.db.insertRow(
            session,
            StudentProfile(
              authUserId: UuidValue.fromString(studentBId),
              fullName: 'Bhavna Sen',
              email: 'bhavna.sen@campus.edu',
              branch: 'ECE',
              academicYear: 3,
              hostelOrArea: 'Hostel B',
              subjectInterests: ['Networks', 'OS'],
              eventInterests: ['Sports'],
              preferredQuizSubjects: ['Operating Systems'],
              preferredQuizTypes: ['Multiple Choice'],
              createdAt: now,
              updatedAt: now,
            ),
          );
        }

        // Seed Student C: CSE Year 2
        final existingC = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(studentCId)),
        );
        if (existingC == null) {
          await StudentProfile.db.insertRow(
            session,
            StudentProfile(
              authUserId: UuidValue.fromString(studentCId),
              fullName: 'Chirag Rao',
              email: 'chirag.rao@campus.edu',
              branch: 'CSE',
              academicYear: 2,
              hostelOrArea: 'Hostel C',
              subjectInterests: ['AI'],
              eventInterests: ['Cultural'],
              preferredQuizSubjects: ['DBMS'],
              preferredQuizTypes: ['Conceptual'],
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      });

      test('1. Preferences Persistence: updateProfile and updatePreferences persist all fields', () async {
        // Update preferences for Student A
        final updated = await endpoints.student.updatePreferences(
          authedStudentA,
          eventInterests: ['Hackathon', 'Workshop'],
          preferredQuizSubjects: ['Operating Systems', 'DBMS'],
          preferredQuizTypes: ['Scenario Based'],
        );

        expect(updated.eventInterests, containsAll(['Hackathon', 'Workshop']));
        expect(updated.preferredQuizSubjects, containsAll(['Operating Systems', 'DBMS']));
        expect(updated.preferredQuizTypes, contains('Scenario Based'));

        // Retrieve through getProfile
        final fetched = await endpoints.student.getProfile(authedStudentA);
        expect(fetched, isNotNull);
        expect(fetched!.eventInterests, containsAll(['Hackathon', 'Workshop']));
        expect(fetched.preferredQuizSubjects, containsAll(['Operating Systems', 'DBMS']));
        expect(fetched.preferredQuizTypes, contains('Scenario Based'));
      });

      test('2. Event Recommendations: getRecommendedEvents prioritizes student eventInterests while listEvents retains Browse All', () async {
        final session = sessionBuilder.build();
        final now = DateTime.now().toUtc();

        // Insert events of various categories
        final sportsEvent = await CampusEvent.db.insertRow(
          session,
          CampusEvent(
            title: 'Inter-Hostel Badminton Cup',
            description: 'Annual sports tournament.',
            category: 'Sports',
            startTime: now.add(const Duration(days: 3)),
            venue: 'Sports Complex',
            organizerAuthUserId: UuidValue.fromString(studentBId),
            organizerName: 'Bhavna',
            rsvpCount: 0,
            approvalStatus: 'approved',
            createdAt: now,
            updatedAt: now,
          ),
        );

        final hackathonEvent = await CampusEvent.db.insertRow(
          session,
          CampusEvent(
            title: 'Campus Hack Sprint 2026',
            description: '36-hour hackathon for building student solutions.',
            category: 'Hackathon',
            startTime: now.add(const Duration(days: 4)),
            venue: 'Tech Auditorium',
            organizerAuthUserId: UuidValue.fromString(studentAId),
            organizerName: 'Aarav',
            rsvpCount: 0,
            approvalStatus: 'approved',
            createdAt: now,
            updatedAt: now,
          ),
        );

        // Student A has 'Hackathon' interest
        final recommendedForA = await endpoints.event.getRecommendedEvents(
          authedStudentA,
          limit: 10,
        );

        expect(recommendedForA.isNotEmpty, isTrue);
        // The hackathon event should be recommended ahead of sports for Student A
        final hackathonIdx = recommendedForA.indexWhere((e) => e.id == hackathonEvent.id);
        final sportsIdx = recommendedForA.indexWhere((e) => e.id == sportsEvent.id);
        expect(hackathonIdx, isNot(-1));
        if (sportsIdx != -1) {
          expect(hackathonIdx, lessThan(sportsIdx));
        }

        // Browse All (listEvents) retains all approved events without preference bias
        final browseAll = await endpoints.event.listEvents(
          authedStudentA,
          limit: 20,
          offset: 0,
        );
        expect(browseAll.any((e) => e.id == sportsEvent.id), isTrue);
        expect(browseAll.any((e) => e.id == hackathonEvent.id), isTrue);
      });

      test('3. Quiz Recommendations: getRecommendedQuizSubjects orders subjects by preferences without weak-area logic', () async {
        final recommendedForA = await endpoints.quiz.getRecommendedQuizSubjects(authedStudentA);
        expect(recommendedForA, isNotEmpty);
        // Student A has preferredQuizSubjects: ['Operating Systems', 'DBMS'] from test 1
        expect(recommendedForA, contains('Operating Systems'));
        expect(recommendedForA, contains('DBMS'));
      });

      test('4. Repeated-Attempt Scoring & Distinct Quiz Separation: best score per quiz, not collapsed', () async {
        final session = sessionBuilder.build();
        final now = DateTime.now().toUtc();
        final userUuid = UuidValue.fromString(studentAId);

        // Clear existing attempts for clean assertions
        await session.db.unsafeQuery("DELETE FROM quiz_attempt WHERE \"authUserId\" = '$studentAId'");

        // Attempt 1 on Quiz 'dsa_trees' (Score 3)
        await QuizAttempt.db.insertRow(
          session,
          QuizAttempt(
            attemptId: 'att-1-dsa-trees',
            authUserId: userUuid,
            studentName: 'Aarav Patel',
            studentBranch: 'CSE',
            academicYear: 2,
            subject: 'DSA',
            quizId: 'dsa_trees',
            score: 3,
            totalQuestions: 5,
            percentage: 60.0,
            durationSeconds: 120,
            attemptNumber: 1,
            isRetake: false,
            completedAt: now.subtract(const Duration(minutes: 30)),
          ),
        );

        // Attempt 2 (retake) on same Quiz 'dsa_trees' with higher score (Score 5)
        await QuizAttempt.db.insertRow(
          session,
          QuizAttempt(
            attemptId: 'att-2-dsa-trees',
            authUserId: userUuid,
            studentName: 'Aarav Patel',
            studentBranch: 'CSE',
            academicYear: 2,
            subject: 'DSA',
            quizId: 'dsa_trees',
            score: 5,
            totalQuestions: 5,
            percentage: 100.0,
            durationSeconds: 100,
            attemptNumber: 2,
            isRetake: true,
            completedAt: now.subtract(const Duration(minutes: 20)),
          ),
        );

        // Attempt 3 (retake) on same Quiz 'dsa_trees' with lower score (Score 2)
        await QuizAttempt.db.insertRow(
          session,
          QuizAttempt(
            attemptId: 'att-3-dsa-trees',
            authUserId: userUuid,
            studentName: 'Aarav Patel',
            studentBranch: 'CSE',
            academicYear: 2,
            subject: 'DSA',
            quizId: 'dsa_trees',
            score: 2,
            totalQuestions: 5,
            percentage: 40.0,
            durationSeconds: 90,
            attemptNumber: 3,
            isRetake: true,
            completedAt: now.subtract(const Duration(minutes: 10)),
          ),
        );

        // Check leaderboard: score must be 5 (best score on dsa_trees), NOT 3+5+2 = 10!
        var leaderboard = await endpoints.leaderboard.getLeaderboard(
          authedStudentA,
          subject: 'DSA',
          limit: 50,
          offset: 0,
        );
        expect(leaderboard.length, equals(1));
        expect(leaderboard.first.score, equals(5));
        expect(leaderboard.first.quizzesTaken, equals(1));

        // Now student takes a DIFFERENT quiz in the same subject: 'dsa_sorting' (Score 4)
        await QuizAttempt.db.insertRow(
          session,
          QuizAttempt(
            attemptId: 'att-1-dsa-sorting',
            authUserId: userUuid,
            studentName: 'Aarav Patel',
            studentBranch: 'CSE',
            academicYear: 2,
            subject: 'DSA',
            quizId: 'dsa_sorting',
            score: 4,
            totalQuestions: 5,
            percentage: 80.0,
            durationSeconds: 110,
            attemptNumber: 1,
            isRetake: false,
            completedAt: now.subtract(const Duration(minutes: 5)),
          ),
        );

        // Leaderboard must NOT collapse dsa_trees and dsa_sorting into one single score:
        // Total score should be 5 (best trees) + 4 (best sorting) = 9!
        leaderboard = await endpoints.leaderboard.getLeaderboard(
          authedStudentA,
          subject: 'DSA',
          limit: 50,
          offset: 0,
        );
        expect(leaderboard.length, equals(1));
        expect(leaderboard.first.score, equals(9));
        expect(leaderboard.first.quizzesTaken, equals(2));
      });

      test('5. Deterministic Tie-Breaking and Course/Year Separation', () async {
        final session = sessionBuilder.build();
        final now = DateTime.now().toUtc();

        await session.db.unsafeQuery("DELETE FROM quiz_attempt");

        // Student A: CSE Year 2, score 10, total 10 questions (100% acc), duration 200s
        await QuizAttempt.db.insertRow(
          session,
          QuizAttempt(
            attemptId: 'att-tie-a',
            authUserId: UuidValue.fromString(studentAId),
            studentName: 'Aarav Patel',
            studentBranch: 'CSE',
            academicYear: 2,
            subject: 'DBMS',
            quizId: 'dbms_acid',
            score: 10,
            totalQuestions: 10,
            percentage: 100.0,
            durationSeconds: 200,
            completedAt: now.subtract(const Duration(minutes: 40)),
          ),
        );

        // Student B: ECE Year 3, score 10, total 12 questions (83.3% acc), duration 180s
        await QuizAttempt.db.insertRow(
          session,
          QuizAttempt(
            attemptId: 'att-tie-b',
            authUserId: UuidValue.fromString(studentBId),
            studentName: 'Bhavna Sen',
            studentBranch: 'ECE',
            academicYear: 3,
            subject: 'DBMS',
            quizId: 'dbms_acid',
            score: 10,
            totalQuestions: 12,
            percentage: 83.3,
            durationSeconds: 180,
            completedAt: now.subtract(const Duration(minutes: 30)),
          ),
        );

        // Student C: CSE Year 2, score 10, total 10 questions (100% acc), duration 250s (slower than A)
        await QuizAttempt.db.insertRow(
          session,
          QuizAttempt(
            attemptId: 'att-tie-c',
            authUserId: UuidValue.fromString(studentCId),
            studentName: 'Chirag Rao',
            studentBranch: 'CSE',
            academicYear: 2,
            subject: 'DBMS',
            quizId: 'dbms_acid',
            score: 10,
            totalQuestions: 10,
            percentage: 100.0,
            durationSeconds: 250,
            completedAt: now.subtract(const Duration(minutes: 20)),
          ),
        );

        // Overall leaderboard:
        // Rank 1: Aarav (10 pts, 100% acc, 200s)
        // Rank 2: Chirag (10 pts, 100% acc, 250s - slower than Aarav)
        // Rank 3: Bhavna (10 pts, 83.3% acc - lower accuracy)
        final overall = await endpoints.leaderboard.getLeaderboard(
          authedStudentA,
          subject: 'DBMS',
          limit: 50,
          offset: 0,
        );

        expect(overall.length, equals(3));
        expect(overall[0].studentName, equals('Aarav Patel'));
        expect(overall[0].rank, equals(1));
        expect(overall[1].studentName, equals('Chirag Rao'));
        expect(overall[1].rank, equals(2));
        expect(overall[2].studentName, equals('Bhavna Sen'));
        expect(overall[2].rank, equals(3));

        // Filter by Branch & Academic Year:
        // 1. CSE Year 2 separation
        final cseYear2 = await endpoints.leaderboard.getLeaderboard(
          authedStudentA,
          branch: 'CSE',
          academicYear: 2,
          limit: 50,
          offset: 0,
        );
        expect(cseYear2.length, equals(2));
        expect(cseYear2.map((e) => e.studentName), containsAll(['Aarav Patel', 'Chirag Rao']));
        expect(cseYear2.any((e) => e.studentName == 'Bhavna Sen'), isFalse);

        // 2. ECE Year 3 separation
        final eceYear3 = await endpoints.leaderboard.getLeaderboard(
          authedStudentA,
          branch: 'ECE',
          academicYear: 3,
          limit: 50,
          offset: 0,
        );
        expect(eceYear3.length, equals(1));
        expect(eceYear3.first.studentName, equals('Bhavna Sen'));
        expect(eceYear3.first.academicYear, equals(3));

        // 3. Pagination verification: global ranking maintained across pages
        final page1 = await endpoints.leaderboard.getLeaderboard(
          authedStudentA,
          subject: 'DBMS',
          limit: 1,
          offset: 0,
        );
        expect(page1.length, equals(1));
        expect(page1.first.studentName, equals('Aarav Patel'));
        expect(page1.first.rank, equals(1));

        final page2 = await endpoints.leaderboard.getLeaderboard(
          authedStudentA,
          subject: 'DBMS',
          limit: 1,
          offset: 1,
        );
        expect(page2.length, equals(1));
        expect(page2.first.studentName, equals('Chirag Rao'));
        expect(page2.first.rank, equals(2));
      });
    },
  );
}
