import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import '../services/notification_service.dart';
import 'admin_endpoint.dart';

class EventEndpoint extends Endpoint {
  static const String rsvpChannel = 'events-rsvp-channel';

  /// Lists campus events with category filtering and approval check.
  /// By default returns only approved events for regular students.
  Future<List<CampusEvent>> listEvents(
    Session session, {
    String? category,
    String? approvalStatus = 'approved',
    int limit = 20,
    int offset = 0,
  }) async {
    return await CampusEvent.db.find(
      session,
      where: (t) {
        Expression expr = Constant.bool(true);
        if (approvalStatus != null &&
            approvalStatus.isNotEmpty &&
            approvalStatus != 'All') {
          expr = expr & t.approvalStatus.equals(approvalStatus);
        }
        if (category != null && category.isNotEmpty && category != 'All') {
          expr = expr & t.category.equals(category);
        }
        return expr;
      },
      orderBy: (t) => t.startTime,
      limit: limit.clamp(1, 100),
      offset: offset,
    );
  }

  /// Gets a single event by ID.
  Future<CampusEvent?> getEvent(Session session, int id) async {
    return await CampusEvent.db.findById(session, id);
  }

  /// Returns personalized recommended events based on the authenticated student's saved eventInterests.
  /// If unauthenticated or no preferences set, returns upcoming approved events ordered by startTime.
  /// Retains the standard listEvents endpoint for 'Browse All'.
  Future<List<CampusEvent>> getRecommendedEvents(
    Session session, {
    int limit = 10,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    List<String> interests = [];

    if (authUserId != null) {
      final profile = await StudentProfile.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(authUserId),
      );
      if (profile != null) {
        if (profile.eventInterests != null &&
            profile.eventInterests!.isNotEmpty) {
          interests = profile.eventInterests!;
        } else {
          interests = profile.subjectInterests;
        }
      }
    }

    final now = DateTime.now().toUtc();
    final candidates = await CampusEvent.db.find(
      session,
      where: (t) =>
          t.approvalStatus.equals('approved') &
          (t.startTime >= now.subtract(const Duration(hours: 6))),
      orderBy: (t) => t.startTime,
      limit: 100,
    );

    if (interests.isEmpty) {
      return candidates.take(limit.clamp(1, 50)).toList();
    }

    final normalizedInterests = interests
        .map((i) => i.trim().toLowerCase())
        .where((i) => i.isNotEmpty)
        .toSet();

    final scored = candidates.map((ev) {
      int score = 0;
      final cat = ev.category.trim().toLowerCase();
      if (normalizedInterests.contains(cat)) {
        score += 100;
      }
      final titleLower = ev.title.toLowerCase();
      final descLower = ev.description.toLowerCase();
      for (final interest in normalizedInterests) {
        if (titleLower.contains(interest)) score += 30;
        if (descLower.contains(interest)) score += 15;
      }
      return MapEntry(ev, score);
    }).toList();

    scored.sort((a, b) {
      final scoreCmp = b.value.compareTo(a.value);
      if (scoreCmp != 0) return scoreCmp;
      return a.key.startTime.compareTo(b.key.startTime);
    });

    return scored.map((e) => e.key).take(limit.clamp(1, 50)).toList();
  }

  /// Creates a new campus event in 'pending' status awaiting review.
  Future<CampusEvent> createEvent(
    Session session, {
    required String title,
    required String description,
    required String category,
    required DateTime startTime,
    DateTime? endTime,
    required String venue,
    String? bannerUrl,
    DateTime? registrationDeadline,
    bool isTeamEvent = false,
    int minTeamSize = 1,
    int maxTeamSize = 1,
    String? approvalStatus,
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
    if (isTeamEvent && minTeamSize > maxTeamSize) {
      throw ArgumentError('Minimum team size cannot exceed maximum team size.');
    }

    final student = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final organizerName = student?.fullName ?? 'Campus Student';

    // Verify if creator is master admin. Regular students' events are strictly 'pending'.
    final isAdminUser = await AdminEndpoint.isAdmin(session);
    final finalStatus = isAdminUser
        ? (approvalStatus ?? 'approved')
        : 'pending';

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
      approvalStatus: finalStatus,
      registrationDeadline: registrationDeadline?.toUtc(),
      isTeamEvent: isTeamEvent,
      minTeamSize: minTeamSize.clamp(1, 20),
      maxTeamSize: maxTeamSize.clamp(1, 20),
      submissionVersion: 1,
      createdAt: now,
      updatedAt: now,
    );

    final created = await CampusEvent.db.insertRow(session, event);

    if (finalStatus == 'pending') {
      try {
        await NotificationService.notifyAdmins(
          session,
          title: 'New Campus Event Submission',
          message:
              '$organizerName submitted event "$trimmedTitle" for administrative review.',
          type: 'event_review',
          targetRoute: 'master_admin',
          targetId: created.id.toString(),
          eventIdTag: 'event_submit_${created.id}',
        );
      } catch (_) {}
    }

    return created;
  }

  /// Edits an existing event.
  /// Material edits (title, venue, timing, deadline, category, team rules) to approved events
  /// reset approvalStatus to 'pending' and require reapproval.
  Future<CampusEvent> editEvent(
    Session session, {
    required int eventId,
    required String title,
    required String description,
    required String category,
    required DateTime startTime,
    DateTime? endTime,
    required String venue,
    String? bannerUrl,
    DateTime? registrationDeadline,
    bool isTeamEvent = false,
    int minTeamSize = 1,
    int maxTeamSize = 1,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('Authentication required to edit events.');
    }

    final event = await CampusEvent.db.findById(session, eventId);
    if (event == null) {
      throw ArgumentError('Event not found.');
    }

    final adminRole = await UserRole.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.role.equals('admin'),
    );
    final isOwner = event.organizerAuthUserId == authUserId;

    if (!isOwner && adminRole == null) {
      throw StateError(
        'Unauthorized: Only the event organizer or an admin can edit this event.',
      );
    }

    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) throw ArgumentError('Title cannot be empty.');
    if (venue.trim().isEmpty) throw ArgumentError('Venue cannot be empty.');

    final now = DateTime.now().toUtc();

    // Check if material fields changed
    final bool isMaterialChange =
        event.title != trimmedTitle ||
        event.category != category ||
        event.venue != venue.trim() ||
        event.startTime.isAtSameMomentAs(startTime.toUtc()) == false ||
        event.isTeamEvent != isTeamEvent ||
        event.minTeamSize != minTeamSize ||
        event.maxTeamSize != maxTeamSize ||
        event.registrationDeadline?.isAtSameMomentAs(
              registrationDeadline?.toUtc() ?? DateTime(0),
            ) ==
            false;

    final String nextStatus = (isMaterialChange && adminRole == null)
        ? 'pending'
        : event.approvalStatus;
    final int nextVersion = isMaterialChange
        ? event.submissionVersion + 1
        : event.submissionVersion;

    final updated = event.copyWith(
      title: trimmedTitle,
      description: description.trim(),
      category: category,
      startTime: startTime.toUtc(),
      endTime: endTime?.toUtc(),
      venue: venue.trim(),
      bannerUrl: bannerUrl?.trim(),
      registrationDeadline: registrationDeadline?.toUtc(),
      isTeamEvent: isTeamEvent,
      minTeamSize: minTeamSize.clamp(1, 20),
      maxTeamSize: maxTeamSize.clamp(1, 20),
      approvalStatus: nextStatus,
      rejectionReason: isMaterialChange ? null : event.rejectionReason,
      submissionVersion: nextVersion,
      updatedAt: now,
    );

    return await CampusEvent.db.updateRow(session, updated);
  }

  /// Review event (Admin only: approve or reject with reason)
  Future<CampusEvent> reviewEvent(
    Session session, {
    required int eventId,
    required String decision, // 'approved', 'rejected'
    String? rejectionReason,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('Admin authentication required.');
    }

    final isAuthorized = await AdminEndpoint.isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Access denied: Admin role required.');
    }

    if (decision != 'approved' && decision != 'rejected') {
      throw ArgumentError('Invalid decision: must be approved or rejected.');
    }

    final cleanReason = rejectionReason?.trim();
    if (decision == 'rejected') {
      if (cleanReason == null || cleanReason.isEmpty) {
        throw ArgumentError(
          'A rejection reason is required when rejecting an event.',
        );
      }
    }

    final adminProfile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final adminName = adminProfile?.fullName ?? 'Master Admin';

    final now = DateTime.now().toUtc();
    late CampusEvent updated;

    await session.db.transaction((transaction) async {
      final event = await CampusEvent.db.findById(
        session,
        eventId,
        transaction: transaction,
      );
      if (event == null) throw ArgumentError('Event not found.');

      if (event.approvalStatus != 'pending') {
        throw StateError(
          'Conflict: Event has already been reviewed (current status: ${event.approvalStatus}).',
        );
      }

      updated = event.copyWith(
        approvalStatus: decision,
        rejectionReason: decision == 'rejected' ? cleanReason : null,
        updatedAt: now,
      );

      await CampusEvent.db.updateRow(
        session,
        updated,
        transaction: transaction,
      );

      await AdminAuditLog.db.insertRow(
        session,
        AdminAuditLog(
          actorUserId: authUserId,
          actorName: adminName,
          actionType: decision == 'approved' ? 'EVENT_APPROVE' : 'EVENT_REJECT',
          targetEntity: 'campus_event',
          targetId: '$eventId',
          details: decision == 'approved'
              ? 'Approved campus event "${event.title}"'
              : 'Rejected campus event "${event.title}". Reason: $cleanReason',
          timestamp: now,
        ),
        transaction: transaction,
      );
    });

    try {
      if (decision == 'approved') {
        await NotificationService.sendNotification(
          session,
          authUserId: updated.organizerAuthUserId,
          title: 'Event Approved! 🎉',
          message: 'Your event "${updated.title}" has been approved.',
          type: 'event_approved',
          targetRoute: 'event_detail',
          targetId: updated.id.toString(),
          eventIdTag:
              'event_approved_${updated.id}_${updated.submissionVersion}',
        );
      } else {
        await NotificationService.sendNotification(
          session,
          authUserId: updated.organizerAuthUserId,
          title: 'Event Rejected',
          message:
              'Your event "${updated.title}" was rejected. Reason: $cleanReason',
          type: 'event_rejected',
          targetRoute: 'event_detail',
          targetId: updated.id.toString(),
          eventIdTag:
              'event_rejected_${updated.id}_${updated.submissionVersion}',
        );
      }
    } catch (_) {}

    return updated;
  }

  /// Registers a student or team for an event transactionally.
  /// Enforces approval status, registration deadlines, team size validation,
  /// and concurrent duplicate prevention.
  Future<bool> registerForEvent(
    Session session,
    int eventId, {
    String? teamName,
    List<String>? teamMemberNames,
    List<String>? teamMemberEmails,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated to register for an event.');
    }

    final student = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final studentName = student?.fullName ?? 'Student';

    var updatedCount = 0;

    String? eventTitle;
    String? eventVenue;

    await session.db.transaction((transaction) async {
      // 1. Fetch event
      final event = await CampusEvent.db.findById(
        session,
        eventId,
        transaction: transaction,
      );
      if (event == null) {
        throw ArgumentError('Event not found.');
      }

      eventTitle = event.title;
      eventVenue = event.venue;

      // 2. Enforce approval status
      if (event.approvalStatus != 'approved') {
        throw StateError('Registrations are not open for unapproved events.');
      }

      // 3. Enforce registration deadline
      final now = DateTime.now().toUtc();
      if (event.registrationDeadline != null &&
          now.isAfter(event.registrationDeadline!)) {
        throw StateError('Registration deadline for this event has passed.');
      }

      // 4. Enforce team validation
      if (event.isTeamEvent) {
        final totalMembers = 1 + (teamMemberNames?.length ?? 0);
        if (totalMembers < event.minTeamSize ||
            totalMembers > event.maxTeamSize) {
          throw ArgumentError(
            'Invalid team size: $totalMembers members provided. Allowed range: ${event.minTeamSize} to ${event.maxTeamSize}.',
          );
        }
        if (teamName == null || teamName.trim().isEmpty) {
          throw ArgumentError('Team name is required for team events.');
        }
      }

      // 5. Concurrent duplicate registration prevention
      final existing = await EventRsvp.db.findFirstRow(
        session,
        where: (t) =>
            t.eventId.equals(eventId) & t.authUserId.equals(authUserId),
        transaction: transaction,
      );
      if (existing != null) {
        // Idempotent return: already registered
        return;
      }

      // 6. Insert Registration record
      await EventRsvp.db.insertRow(
        session,
        EventRsvp(
          eventId: eventId,
          authUserId: authUserId,
          studentName: studentName,
          teamName: teamName?.trim(),
          teamMemberNames: teamMemberNames,
          teamMemberEmails: teamMemberEmails,
          createdAt: now,
        ),
        transaction: transaction,
      );

      // 7. Update count
      updatedCount = event.rsvpCount + 1;
      final updatedEvent = event.copyWith(
        rsvpCount: updatedCount,
        updatedAt: now,
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
          action: 'register',
        ),
      );

      try {
        await NotificationService.sendNotification(
          session,
          authUserId: authUserId,
          title: 'Event RSVP Confirmed! 🎟️',
          message:
              'You have successfully registered for "${eventTitle ?? 'Campus Event'}". See you at ${eventVenue ?? 'the venue'}!',
          type: 'event_rsvp',
          targetRoute: 'events',
          targetId: eventId.toString(),
          eventIdTag: 'rsvp_${eventId}_$authUserId',
        );
      } catch (_) {}
    }

    return true;
  }

  /// Backward-compatible alias for registerForEvent
  Future<bool> rsvpEvent(Session session, int eventId) async {
    return await registerForEvent(session, eventId);
  }

  /// Cancels a registration transactionally.
  Future<bool> cancelRegistration(Session session, int eventId) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated to cancel registration.');
    }

    var updatedCount = 0;
    String? eventTitle;

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

      eventTitle = event.title;

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

    if (updatedCount >= 0 && eventTitle != null) {
      await session.messages.postMessage(
        rsvpChannel,
        RsvpUpdate(
          eventId: eventId,
          rsvpCount: updatedCount,
          action: 'cancel',
        ),
      );

      try {
        await NotificationService.sendNotification(
          session,
          authUserId: authUserId,
          title: 'Event RSVP Cancelled',
          message:
              'You have cancelled your registration for "${eventTitle ?? 'Campus Event'}".',
          type: 'event_rsvp',
          targetRoute: 'events',
          targetId: eventId.toString(),
          eventIdTag: 'cancel_rsvp_${eventId}_$authUserId',
        );
      } catch (_) {}
    }

    return true;
  }

  /// Backward-compatible alias for cancelRegistration
  Future<bool> cancelRsvp(Session session, int eventId) async {
    return await cancelRegistration(session, eventId);
  }

  /// Checks whether the authenticated user has registered for this event.
  Future<bool> hasUserRegistered(Session session, int eventId) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final existing = await EventRsvp.db.findFirstRow(
      session,
      where: (t) => t.eventId.equals(eventId) & t.authUserId.equals(authUserId),
    );
    return existing != null;
  }

  /// Backward-compatible alias
  Future<bool> hasUserRsvpd(Session session, int eventId) async {
    return await hasUserRegistered(session, eventId);
  }

  /// Returns all event IDs that the current student has registered for.
  Future<List<int>> getMyRegisteredEventIds(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return [];

    final rsvps = await EventRsvp.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    return rsvps.map((r) => r.eventId).toList();
  }

  /// Backward-compatible alias
  Future<List<int>> getMyRsvpdEventIds(Session session) async {
    return await getMyRegisteredEventIds(session);
  }

  /// Retrieves participant registration details for the owning organizer or an admin.
  Future<List<EventRsvp>> getMyOrganizerRegistrations(
    Session session,
    int eventId,
  ) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('Authentication required.');
    }

    final event = await CampusEvent.db.findById(session, eventId);
    if (event == null) throw ArgumentError('Event not found.');

    final adminRole = await UserRole.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.role.equals('admin'),
    );

    if (event.organizerAuthUserId != authUserId && adminRole == null) {
      throw StateError(
        'Unauthorized: Only the event organizer or an admin can access registration rosters.',
      );
    }

    return await EventRsvp.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
      orderBy: (t) => t.createdAt.desc(),
      limit: 500,
    );
  }

  /// Streams real-time registration updates to connected clients.
  Stream<RsvpUpdate> streamRsvpUpdates(Session session) async* {
    final stream = session.messages.createStream<RsvpUpdate>(rsvpChannel);
    await for (final update in stream) {
      yield update;
    }
  }

  /// List pending events for administrative review queue (Admin only)
  Future<List<CampusEvent>> getPendingEvents(
    Session session, {
    int limit = 50,
    int offset = 0,
  }) async {
    final isAuthorized = await AdminEndpoint.isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Access denied: Admin role required.');
    }

    return await CampusEvent.db.find(
      session,
      where: (t) => t.approvalStatus.equals('pending'),
      orderBy: (t) => t.createdAt.desc(),
      limit: limit.clamp(1, 100),
      offset: offset,
    );
  }

  /// Get total count of pending events awaiting admin approval (Admin only)
  Future<int> getPendingEventsCount(Session session) async {
    final isAuthorized = await AdminEndpoint.isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Access denied: Admin role required.');
    }

    return await CampusEvent.db.count(
      session,
      where: (t) => t.approvalStatus.equals('pending'),
    );
  }

  /// Returns events submitted by the current authenticated user with their approval statuses
  Future<List<CampusEvent>> getMyEvents(
    Session session, {
    String? status,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated to view their events.');
    }

    return await CampusEvent.db.find(
      session,
      where: (t) {
        Expression expr = t.organizerAuthUserId.equals(authUserId);
        if (status != null &&
            status.isNotEmpty &&
            status.toLowerCase() != 'all') {
          expr = expr & t.approvalStatus.equals(status.toLowerCase());
        }
        return expr;
      },
      orderBy: (t) => t.createdAt.desc(),
      limit: 100,
    );
  }
}
