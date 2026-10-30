import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Live Backend: listEvents returns all 5 seeded campus events', () async {
    final client = Client('http://localhost:8080/');
    try {
      final events = await client.event.listEvents(limit: 50, offset: 0);
      expect(events.isNotEmpty, isTrue);
      expect(events.length, equals(5));

      final titles = events.map((e) => e.title).toList();
      expect(
        titles,
        contains('HackPulse 2026: Campus 36-Hour Hackathon'),
      );
      expect(
        titles,
        contains('Deep Dive into Systems & Linux Internals'),
      );
      expect(
        titles,
        contains('Inter-Department Cricket & Football Tournament'),
      );
      expect(
        titles,
        contains('PulseFest: Annual Cultural Gala & Battle of Bands'),
      );
      expect(
        titles,
        contains('Resume Review & Tech Interview Mastery Workshop'),
      );

      // Verify category filtering
      final techEvents = await client.event.listEvents(
        category: 'Tech',
        limit: 10,
        offset: 0,
      );
      expect(techEvents.length, equals(1));
      expect(techEvents.first.category, equals('Tech'));

      final sportsEvents = await client.event.listEvents(
        category: 'Sports',
        limit: 10,
        offset: 0,
      );
      expect(sportsEvents.length, equals(1));
      expect(sportsEvents.first.category, equals('Sports'));

      final allEvents = await client.event.listEvents(
        category: 'All',
        limit: 10,
        offset: 0,
      );
      expect(allEvents.length, equals(5));
    } finally {
      client.close();
    }
  });

  test('Live Backend: demo login and public student discovery', () async {
    final client = Client('http://localhost:8080/');
    try {
      final authSuccess = await client.student.loginDemo();
      expect(authSuccess.token.isNotEmpty, isTrue);
      expect(authSuccess.authUserId.toString().isNotEmpty, isTrue);

      final students = await client.student.discoverStudents(limit: 10, offset: 0);
      expect(students.isNotEmpty, isTrue);
    } finally {
      client.close();
    }
  });
}

