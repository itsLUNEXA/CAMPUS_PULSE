import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class EventEndpoint extends Endpoint {
  static const String rsvpChannel = 'events-rsvp-channel';

  /// Lists campus events with category filtering and pagination.
  Future<List<CampusEvent>> listEvents(
    Session session, {
    String? category,
    int limit = 20,
    int offset = 0,
  }) async {
    return await CampusEvent.db.find(
      session,
      where: (category != null && category.isNotEmpty && category != 'All')
          ? (t) => t.category.equals(category)
          : null,
      orderBy: (t) => t.startTime,
      limit: limit.clamp(1, 100),
      offset: offset,
    );
  }

  /// Gets a single event by ID.
  Future<CampusEvent?> getEvent(Session session, int id) async {
    return await CampusEvent.db.findById(session, id);
  }

  /// Creates a new campus event.
  Future<CampusEvent> createEvent(
    Session session, {
    required String title,
    required String description,
    required String category,
    required DateTime startTime,
    DateTime? endTime,
    required String venue,
    String? bannerUrl,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated to create an event.');
    }

    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      throw ArgumentError('Event title cannot be empty.');
    }
    if (venue.trim().isEmpty) {
      throw ArgumentError('Event venue cannot be empty.');
    }

    final student = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final organizerName = student?.fullName ?? 'Campus Student';

    final now = DateTime.now().toUtc();
    final event = CampusEvent(
      title: trimmedTitle,
      description: description.trim(),
      category: category,
      startTime: startTime.toUtc(),
      endTime: endTime?.toUtc(),
      venue: venue.trim(),
      bannerUrl: bannerUrl?.trim(),
      organizerAuthUserId: authUserId,
      organizerName: organizerName,
      rsvpCount: 0,
      createdAt: now,
      updatedAt: now,
    );

    return await CampusEvent.db.insertRow(session, event);
  }

  /// RSVP to an event transactionally with duplicate check and real-time broadcast.
  Future<bool> rsvpEvent(Session session, int eventId) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated to RSVP.');
    }

    final student = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final studentName = student?.fullName ?? 'Student';

    var updatedCount = 0;

    await session.db.transaction((transaction) async {
      // 1. Check if user already RSVP'd
      final existing = await EventRsvp.db.findFirstRow(
        session,
        where: (t) =>
            t.eventId.equals(eventId) & t.authUserId.equals(authUserId),
        transaction: transaction,
      );
      if (existing != null) {
        // Already RSVP'd, idempotent return
        return;
      }

      // 2. Fetch event
      final event = await CampusEvent.db.findById(
        session,
        eventId,
        transaction: transaction,
      );
      if (event == null) {
        throw ArgumentError('Event not found.');
      }

      // 3. Insert RSVP
      await EventRsvp.db.insertRow(
        session,
        EventRsvp(
          eventId: eventId,
          authUserId: authUserId,
          studentName: studentName,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );

      // 4. Update count
      updatedCount = event.rsvpCount + 1;
      final updatedEvent = event.copyWith(
        rsvpCount: updatedCount,
        updatedAt: DateTime.now().toUtc(),
      );
      await CampusEvent.db.updateRow(
        session,
        updatedEvent,
        transaction: transaction,
      );
    });

    if (updatedCount > 0) {
      // Broadcast minimal real-time update
      await session.messages.postMessage(
        rsvpChannel,
        RsvpUpdate(
          eventId: eventId,
          rsvpCount: updatedCount,
          action: 'rsvp',
        ),
      );
    }

    return true;
  }

  /// Cancels an RSVP transactionally.
  Future<bool> cancelRsvp(Session session, int eventId) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated to cancel RSVP.');
    }

    var updatedCount = 0;

    await session.db.transaction((transaction) async {
      final existing = await EventRsvp.db.findFirstRow(
        session,
        where: (t) =>
            t.eventId.equals(eventId) & t.authUserId.equals(authUserId),
        transaction: transaction,
      );
      if (existing == null) {
        return;
      }

      final event = await CampusEvent.db.findById(
        session,
        eventId,
        transaction: transaction,
      );
      if (event == null) return;

      await EventRsvp.db.deleteRow(
        session,
        existing,
        transaction: transaction,
      );

      updatedCount = (event.rsvpCount - 1).clamp(0, 100000);
      final updatedEvent = event.copyWith(
        rsvpCount: updatedCount,
        updatedAt: DateTime.now().toUtc(),
      );
      await CampusEvent.db.updateRow(
        session,
        updatedEvent,
        transaction: transaction,
      );
    });

    // Broadcast minimal real-time update
    await session.messages.postMessage(
      rsvpChannel,
      RsvpUpdate(
        eventId: eventId,
        rsvpCount: updatedCount,
        action: 'cancel',
      ),
    );

    return true;
  }

  /// Checks whether the authenticated user has RSVP'd to this event.
  Future<bool> hasUserRsvpd(Session session, int eventId) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final existing = await EventRsvp.db.findFirstRow(
      session,
      where: (t) => t.eventId.equals(eventId) & t.authUserId.equals(authUserId),
    );
    return existing != null;
  }

  /// Returns all event IDs that the current authenticated student has RSVP'd to.
  Future<List<int>> getMyRsvpdEventIds(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return [];

    final rsvps = await EventRsvp.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    return rsvps.map((r) => r.eventId).toList();
  }

  /// Streams real-time RSVP updates to connected clients.
  Stream<RsvpUpdate> streamRsvpUpdates(Session session) async* {
    final stream = session.messages.createStream<RsvpUpdate>(rsvpChannel);
    await for (final update in stream) {
      yield update;
    }
  }
}
