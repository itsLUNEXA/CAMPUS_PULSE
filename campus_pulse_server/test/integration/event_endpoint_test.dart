import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Event Endpoint', (sessionBuilder, endpoints) {
    const student1Id = '550e8400-e29b-41d4-a716-446655440002';
    final authedStudent1 = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(student1Id, {}),
    );

    test(
      'when creating an event and listing then event is present with correct category',
      () async {
        final now = DateTime.now().toUtc();
        final event = await endpoints.event.createEvent(
          authedStudent1,
          title: 'Flutter & Dart Workshop',
          description:
              'Hands-on session building fullstack apps with Serverpod.',
          category: 'Tech',
          startTime: now.add(const Duration(days: 2)),
          venue: 'Lab 3, CS Department',
          approvalStatus: 'approved',
          isTeamEvent: false,
          minTeamSize: 1,
          maxTeamSize: 1,
        );

        expect(event.id, isNotNull);
        expect(event.title, 'Flutter & Dart Workshop');
        expect(event.rsvpCount, 0);

        final list = await endpoints.event.listEvents(
          sessionBuilder,
          category: 'Tech',
          approvalStatus: 'approved',
          limit: 20,
          offset: 0,
        );
        expect(list.any((e) => e.title == 'Flutter & Dart Workshop'), isTrue);

        // Test with category: 'All'
        final listAll = await endpoints.event.listEvents(
          sessionBuilder,
          category: 'All',
          approvalStatus: 'approved',
          limit: 20,
          offset: 0,
        );
        expect(listAll.isNotEmpty, isTrue);

        // Test with category: null
        final listNull = await endpoints.event.listEvents(
          sessionBuilder,
          category: null,
          approvalStatus: 'approved',
          limit: 20,
          offset: 0,
        );
        expect(listNull.isNotEmpty, isTrue);
      },
    );

    test(
      'when student RSVPs then count increments and duplicate tap does not double count',
      () async {
        final now = DateTime.now().toUtc();
        final event = await endpoints.event.createEvent(
          authedStudent1,
          title: 'Inter-College Football Cup',
          description: 'Final match cheer!',
          category: 'Sports',
          startTime: now.add(const Duration(days: 4)),
          venue: 'Main Stadium',
          approvalStatus: 'approved',
          isTeamEvent: false,
          minTeamSize: 1,
          maxTeamSize: 1,
        );

        // First RSVP
        final rsvpSuccess = await endpoints.event.rsvpEvent(
          authedStudent1,
          event.id!,
        );
        expect(rsvpSuccess, isTrue);

        var fetched = await endpoints.event.getEvent(sessionBuilder, event.id!);
        expect(fetched!.rsvpCount, 1);

        // Duplicate RSVP attempt
        await endpoints.event.rsvpEvent(authedStudent1, event.id!);
        fetched = await endpoints.event.getEvent(sessionBuilder, event.id!);
        expect(fetched!.rsvpCount, 1); // Should still be 1!

        final hasRsvpd = await endpoints.event.hasUserRsvpd(
          authedStudent1,
          event.id!,
        );
        expect(hasRsvpd, isTrue);

        // Cancel RSVP
        await endpoints.event.cancelRsvp(authedStudent1, event.id!);
        fetched = await endpoints.event.getEvent(sessionBuilder, event.id!);
        expect(fetched!.rsvpCount, 0);

        final hasRsvpdAfterCancel = await endpoints.event.hasUserRsvpd(
          authedStudent1,
          event.id!,
        );
        expect(hasRsvpdAfterCancel, isFalse);
      },
    );
  });
}
