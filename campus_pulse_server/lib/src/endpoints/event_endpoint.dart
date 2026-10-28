import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class EventEndpoint extends Endpoint {
  static const String eventChannel = 'event_channel';

  Future<List<CampusEvent>> getFeed(
    Session session, {
    String? categoryFilter,
  }) async {
    if (categoryFilter != null &&
        categoryFilter.isNotEmpty &&
        categoryFilter.toLowerCase() != 'all') {
      return await CampusEvent.db.find(
        session,
        where: (t) => t.category.equals(categoryFilter),
        orderBy: (t) => t.startTime,
      );
    }
    return await CampusEvent.db.find(
      session,
      orderBy: (t) => t.startTime,
    );
  }

  Future<CampusEvent> createEvent(
    Session session,
    CampusEvent event,
  ) async {
    final saved = await CampusEvent.db.insertRow(session, event);

    session.messages.postMessage(
      eventChannel,
      RsvpUpdate(eventId: saved.id ?? 0, rsvpCount: saved.rsvpCount),
    );

    return saved;
  }

  Future<RsvpUpdate> rsvp(
    Session session, {
    required int eventId,
    required int studentId,
  }) async {
    final event = await CampusEvent.db.findById(session, eventId);
    if (event == null) {
      throw FormatException('Event not found with ID $eventId');
    }

    final existingRsvp = await Rsvp.db.findFirstRow(
      session,
      where: (t) => t.eventId.equals(eventId) & t.studentId.equals(studentId),
    );

    if (existingRsvp == null) {
      await Rsvp.db.insertRow(session, Rsvp(studentId: studentId, eventId: eventId));
      event.rsvpCount += 1;
      await CampusEvent.db.updateRow(session, event);
    }

    final update = RsvpUpdate(eventId: event.id ?? eventId, rsvpCount: event.rsvpCount);
    session.messages.postMessage(eventChannel, update);

    return update;
  }
}
