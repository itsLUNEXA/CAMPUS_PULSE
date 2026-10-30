import 'package:campus_pulse_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Phase 2: Event Lifecycle and Registration Tests',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      const organizerId = 'b0000000-0000-4000-8000-000000000001';
      const studentId = 'b0000000-0000-4000-8000-000000000002';
      const otherStudentId = 'b0000000-0000-4000-8000-000000000003';
      const adminId = 'b0000000-0000-4000-8000-000000000099';

      final authedOrganizer = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(organizerId, {}),
      );
      final authedStudent = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(studentId, {}),
      );
      final authedOther = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(otherStudentId, {}),
      );
      final authedAdmin = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(adminId, {Scope.admin}),
      );

      setUp(() async {
        final session = sessionBuilder.build();
        final now = DateTime.now().toUtc();

        final existingOrg = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(organizerId)),
        );
        if (existingOrg == null) {
          await StudentProfile.db.insertRow(
            session,
            StudentProfile(
              authUserId: UuidValue.fromString(organizerId),
              fullName: 'Vikas Sharma (Organizer)',
              email: 'vikas@campus.edu',
              branch: 'CSE',
              academicYear: 3,
              hostelOrArea: 'Block A',
              subjectInterests: ['Tech', 'Hackathons'],
              createdAt: now,
              updatedAt: now,
            ),
          );
        }

        final existingStud = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(studentId)),
        );
        if (existingStud == null) {
          await StudentProfile.db.insertRow(
            session,
            StudentProfile(
              authUserId: UuidValue.fromString(studentId),
              fullName: 'Pooja Reddy',
              email: 'pooja@campus.edu',
              branch: 'IT',
              academicYear: 2,
              hostelOrArea: 'Block B',
              subjectInterests: ['AI'],
              createdAt: now,
              updatedAt: now,
            ),
          );
        }

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

      test('Submit -> Pending -> Deny -> Correct -> Approve lifecycle', () async {
        final now = DateTime.now().toUtc();
        final startTime = now.add(const Duration(days: 7));

        // 1. Organizer submits event -> 'pending'
        final created = await endpoints.event.createEvent(
          authedOrganizer,
          title: 'Campus HackSprint 2026',
          description: 'Intensive 24hr software building sprint.',
          category: 'Hackathon',
          startTime: startTime,
          venue: 'Auditorium Hall',
          approvalStatus: 'pending',
          isTeamEvent: false,
          minTeamSize: 1,
          maxTeamSize: 1,
        );
        expect(created.approvalStatus, equals('pending'));
        expect(created.submissionVersion, equals(1));

        // 2. Regular students only see approved events
        final publicEvents = await endpoints.event.listEvents(
          authedStudent,
          approvalStatus: 'approved',
          limit: 50,
          offset: 0,
        );
        expect(publicEvents.any((e) => e.id == created.id), isFalse);

        // 3. Admin denies event with rejection reason
        final denied = await endpoints.event.reviewEvent(
          authedAdmin,
          eventId: created.id!,
          decision: 'rejected',
          rejectionReason: 'Please specify the exact lab room and power backup availability.',
        );
        expect(denied.approvalStatus, equals('rejected'));
        expect(denied.rejectionReason, contains('lab room'));

        // 4. Organizer corrects event and resubmits
        final corrected = await endpoints.event.editEvent(
          authedOrganizer,
          eventId: created.id!,
          title: 'Campus HackSprint 2026',
          description: 'Intensive 24hr sprint with dedicated lab room CS-104 and UPS backup.',
          category: 'Hackathon',
          startTime: startTime,
          venue: 'Lab CS-104 (UPS Powered)',
          isTeamEvent: false,
          minTeamSize: 1,
          maxTeamSize: 1,
        );
        expect(corrected.approvalStatus, equals('pending'));
        expect(corrected.submissionVersion, equals(2));
        expect(corrected.rejectionReason, isNull);

        // 5. Admin approves corrected event
        final approved = await endpoints.event.reviewEvent(
          authedAdmin,
          eventId: created.id!,
          decision: 'approved',
        );
        expect(approved.approvalStatus, equals('approved'));

        // 6. Now visible in public approved feed
        final approvedEvents = await endpoints.event.listEvents(
          authedStudent,
          approvalStatus: 'approved',
          limit: 50,
          offset: 0,
        );
        expect(approvedEvents.any((e) => e.id == created.id), isTrue);
      });

      test('Enforces registration deadlines, team validation and duplicate prevention', () async {
        final now = DateTime.now().toUtc();

        // Create an approved team event with deadline
        final teamEvent = await endpoints.event.createEvent(
          authedOrganizer,
          title: 'Robotics Battle Arena',
          description: 'Team robotics contest.',
          category: 'Tech',
          startTime: now.add(const Duration(days: 5)),
          venue: 'Gymnasium',
          registrationDeadline: now.add(const Duration(days: 2)),
          approvalStatus: 'pending',
          isTeamEvent: true,
          minTeamSize: 2,
          maxTeamSize: 3,
        );

        // Approve it
        await endpoints.event.reviewEvent(
          authedAdmin,
          eventId: teamEvent.id!,
          decision: 'approved',
        );

        // A. Invalid team size (solo registration fails for team event)
        expect(
          endpoints.event.registerForEvent(
            authedStudent,
            teamEvent.id!,
          ),
          throwsA(isA<ArgumentError>()),
        );

        // B. Valid team registration
        final registered = await endpoints.event.registerForEvent(
          authedStudent,
          teamEvent.id!,
          teamName: 'CyberKnights',
          teamMemberNames: ['Pooja Reddy (Lead)', 'Kiran Kumar'],
          teamMemberEmails: ['pooja@campus.edu', 'kiran@campus.edu'],
        );
        expect(registered, isTrue);

        // C. Concurrent duplicate registration returns idempotently
        final duplicateResult = await endpoints.event.registerForEvent(
          authedStudent,
          teamEvent.id!,
          teamName: 'CyberKnights',
          teamMemberNames: ['Pooja Reddy (Lead)', 'Kiran Kumar'],
        );
        expect(duplicateResult, isTrue);

        // Verify count is exactly 1
        final session = sessionBuilder.build();
        final count = await EventRsvp.db.count(
          session,
          where: (t) => t.eventId.equals(teamEvent.id!) & t.authUserId.equals(UuidValue.fromString(studentId)),
        );
        expect(count, equals(1));

        // D. Organizer can retrieve registration roster with team details
        final roster = await endpoints.event.getMyOrganizerRegistrations(
          authedOrganizer,
          teamEvent.id!,
        );
        expect(roster.length, equals(1));
        expect(roster.first.teamName, equals('CyberKnights'));
        expect(roster.first.teamMemberNames?.length, equals(2));

        // Unauthorized student cannot access organizer registration details
        expect(
          endpoints.event.getMyOrganizerRegistrations(authedOther, teamEvent.id!),
          throwsA(isA<StateError>()),
        );
      });

      test('Enforces expired registration deadline blocking registration', () async {
        final now = DateTime.now().toUtc();

        final pastDeadlineEvent = await endpoints.event.createEvent(
          authedOrganizer,
          title: 'Yesterday Workshop',
          description: 'Workshop with expired deadline.',
          category: 'Workshop',
          startTime: now.add(const Duration(days: 2)),
          venue: 'Room 201',
          registrationDeadline: now.subtract(const Duration(hours: 2)),
          approvalStatus: 'pending',
          isTeamEvent: false,
          minTeamSize: 1,
          maxTeamSize: 1,
        );

        await endpoints.event.reviewEvent(
          authedAdmin,
          eventId: pastDeadlineEvent.id!,
          decision: 'approved',
        );

        expect(
          endpoints.event.registerForEvent(
            authedStudent,
            pastDeadlineEvent.id!,
          ),
          throwsA(isA<StateError>()),
        );
      });
    },
  );
}
