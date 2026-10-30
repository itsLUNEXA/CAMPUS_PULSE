import 'package:campus_pulse_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Search & Contact Endpoint', (sessionBuilder, endpoints) {
    test('when submitting contact then message is persisted', () async {
      final success = await endpoints.search.submitContact(
        sessionBuilder,
        name: 'Alex Johnson',
        email: 'alex@campus.edu',
        subject: 'Campus Pulse Feedback',
        message: 'The peer matching feature has been super helpful!',
      );

      expect(success, isTrue);

      final session = sessionBuilder.build();
      final msg = await ContactMessage.db.findFirstRow(
        session,
        where: (t) => t.email.equals('alex@campus.edu'),
      );
      expect(msg, isNotNull);
      expect(msg!.subject, 'Campus Pulse Feedback');
    });

    test(
      'when searching query then relevant campus items are returned',
      () async {
        final session = sessionBuilder.build();
        await CampusEvent.db.insertRow(
          session,
          CampusEvent(
            title: 'Robotics Showcase 2026',
            description: 'Autonomous drones and rovers',
            category: 'Tech',
            startTime: DateTime.now().toUtc().add(const Duration(days: 3)),
            venue: 'Robotics Arena',
            organizerAuthUserId: UuidValue.fromString(
              '550e8400-e29b-41d4-a716-446655440099',
            ),
            organizerName: 'Robotics Society',
            rsvpCount: 15,
          ),
        );

        final searchRes = await endpoints.search.search(
          sessionBuilder,
          'Robotics',
          limit: 20,
        );

        expect(searchRes.items, isNotEmpty);
        expect(
          searchRes.items.any((i) => i.title.contains('Robotics')),
          isTrue,
        );
      },
    );
  });
}
