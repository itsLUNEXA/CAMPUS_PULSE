import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class ChatEndpoint extends Endpoint {
  /// Internal helper to verify authorization and membership for a room
  Future<void> _assertRoomAccess(
    Session session,
    ChatRoom room,
    UuidValue callerId,
  ) async {
    // 1. Admin bypass check
    final adminRole = await UserRole.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId) & t.role.equals('admin'),
    );
    if (adminRole != null) return;

    // 2. Direct chat authorization
    if (room.roomType == 'direct') {
      if (!room.participantIds.contains(callerId)) {
        throw StateError(
          'Unauthorized: You are not a participant in this direct chat.',
        );
      }
      return;
    }

    // 3. Academic Community / Branch / Year restricted group
    if (room.roomType == 'academic_community' ||
        room.allowedBranch != null ||
        room.allowedAcademicYear != null) {
      final profile = await StudentProfile.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(callerId),
      );
      if (profile == null) {
        throw StateError(
          'Unauthorized: Student profile required to join academic groups.',
        );
      }
      if (room.allowedBranch != null &&
          room.allowedBranch!.isNotEmpty &&
          room.allowedBranch != 'All' &&
          room.allowedBranch != profile.branch) {
        throw StateError(
          'Unauthorized: This academic group is restricted to branch ${room.allowedBranch}.',
        );
      }
      if (room.allowedAcademicYear != null &&
          room.allowedAcademicYear! > 0 &&
          room.allowedAcademicYear != profile.academicYear) {
        throw StateError(
          'Unauthorized: This academic group is restricted to academic year ${room.allowedAcademicYear}.',
        );
      }
      return;
    }

    // 4. Event Discussion group (requires event registration or organizer status)
    if (room.roomType == 'event_discussion' && room.referenceId != null) {
      final eventId = int.tryParse(room.referenceId!);
      if (eventId != null) {
        final rsvp = await EventRsvp.db.findFirstRow(
          session,
          where: (t) =>
              t.eventId.equals(eventId) & t.authUserId.equals(callerId),
        );
        final event = await CampusEvent.db.findById(session, eventId);
        if (rsvp == null && event?.organizerAuthUserId != callerId) {
          throw StateError(
            'Unauthorized: Event registration required to join this discussion.',
          );
        }
      }
      return;
    }

    // 5. Standard group membership
    if (!room.participantIds.contains(callerId)) {
      throw StateError(
        'Unauthorized: You are not a member of this chat group.',
      );
    }
  }

  /// Create or fetch an existing chat room with optional branch/year restrictions
  Future<ChatRoom> getOrCreateRoom(
    Session session, {
    required String roomType,
    String? referenceId,
    required String name,
    required List<UuidValue> participantIds,
    String? allowedBranch,
    int? allowedAcademicYear,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to access chat rooms.');
    }

    // Ensure caller is included in participantIds if not already
    final effectiveParticipants = List<UuidValue>.from(participantIds);
    if (!effectiveParticipants.contains(callerId)) {
      effectiveParticipants.add(callerId);
    }

    // For direct chat between 2 users
    if (roomType == 'direct' && effectiveParticipants.length == 2) {
      final rooms = await ChatRoom.db.find(
        session,
        where: (t) => t.roomType.equals('direct'),
      );
      for (final r in rooms) {
        if (r.participantIds.contains(effectiveParticipants[0]) &&
            r.participantIds.contains(effectiveParticipants[1])) {
          await _assertRoomAccess(session, r, callerId);
          return r;
        }
      }
    }

    // For event discussion room
    if (roomType == 'event_discussion' && referenceId != null) {
      final existing = await ChatRoom.db.findFirstRow(
        session,
        where: (t) =>
            t.roomType.equals('event_discussion') &
            t.referenceId.equals(referenceId),
      );
      if (existing != null) {
        await _assertRoomAccess(session, existing, callerId);
        return existing;
      }
    }

    final now = DateTime.now().toUtc();
    final newRoom = await ChatRoom.db.insertRow(
      session,
      ChatRoom(
        roomType: roomType,
        referenceId: referenceId,
        name: name,
        participantIds: effectiveParticipants,
        allowedBranch: allowedBranch,
        allowedAcademicYear: allowedAcademicYear,
        createdAt: now,
      ),
    );

    await _assertRoomAccess(session, newRoom, callerId);
    return newRoom;
  }

  /// Send message in a room with enforced membership & safe authenticated sender identity
  Future<ChatMessage> sendMessage(
    Session session, {
    required int roomId,
    required String content,
    String? attachmentUrl,
    String? attachmentType,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to send messages.');
    }

    final trimmedContent = content.trim();
    if (trimmedContent.isEmpty &&
        (attachmentUrl == null || attachmentUrl.isEmpty)) {
      throw ArgumentError('Message content cannot be empty.');
    }

    final room = await ChatRoom.db.findById(session, roomId);
    if (room == null) {
      throw ArgumentError('Chat room not found.');
    }

    // Enforce authorization
    await _assertRoomAccess(session, room, callerId);

    // Derive verified sender name from StudentProfile
    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId),
    );
    final verifiedSenderName = profile?.fullName ?? 'Student';

    final now = DateTime.now().toUtc();
    final message = await ChatMessage.db.insertRow(
      session,
      ChatMessage(
        roomId: roomId,
        senderUserId: callerId,
        senderName: verifiedSenderName,
        content: trimmedContent,
        attachmentUrl: attachmentUrl,
        attachmentType: attachmentType,
        isRead: false,
        isFlagged: false,
        isDeletedByModerator: false,
        createdAt: now,
        isEdited: false,
      ),
    );

    // Update room lastMessage metadata
    room.lastMessageText = trimmedContent.isNotEmpty
        ? trimmedContent
        : '[Attachment]';
    room.lastMessageAt = now;
    await ChatRoom.db.updateRow(session, room);

    // Broadcast in real-time to channel
    await session.messages.postMessage('chat_$roomId', message);

    return message;
  }

  /// Retrieve messages for room with membership enforcement
  Future<List<ChatMessage>> getRoomMessages(
    Session session,
    int roomId, {
    int limit = 50,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to read room messages.');
    }

    final room = await ChatRoom.db.findById(session, roomId);
    if (room == null) {
      throw ArgumentError('Chat room not found.');
    }

    // Enforce authorization
    await _assertRoomAccess(session, room, callerId);

    return await ChatMessage.db.find(
      session,
      where: (t) =>
          t.roomId.equals(roomId) & t.isDeletedByModerator.equals(false),
      orderBy: (t) => t.createdAt,
      limit: limit.clamp(1, 100),
    );
  }

  /// Real-time stream of messages for a room with membership enforcement
  Stream<ChatMessage> streamChatMessages(Session session, int roomId) async* {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to stream messages.');
    }

    final room = await ChatRoom.db.findById(session, roomId);
    if (room == null) {
      throw ArgumentError('Chat room not found.');
    }

    // Enforce authorization
    await _assertRoomAccess(session, room, callerId);

    final stream = session.messages.createStream<ChatMessage>('chat_$roomId');
    await for (final message in stream) {
      if (!message.isDeletedByModerator) {
        yield message;
      }
    }
  }

  /// Report an inappropriate chat message
  Future<ChatReport> reportMessage(
    Session session, {
    required int messageId,
    required String reason,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to report a message.');
    }

    final message = await ChatMessage.db.findById(session, messageId);
    if (message == null) {
      throw ArgumentError('Message not found.');
    }

    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId),
    );
    final reporterName = profile?.fullName ?? 'Student';

    final now = DateTime.now().toUtc();
    final report = await ChatReport.db.insertRow(
      session,
      ChatReport(
        messageId: messageId,
        roomId: message.roomId,
        reporterUserId: callerId,
        reporterName: reporterName,
        reason: reason.trim(),
        status: 'pending',
        createdAt: now,
      ),
    );

    // Flag the message
    message.isFlagged = true;
    await ChatMessage.db.updateRow(session, message);

    return report;
  }

  /// List chat reports (Admin only)
  Future<List<ChatReport>> listChatReports(
    Session session, {
    String? status,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Admin authentication required.');
    }

    final adminRole = await UserRole.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId) & t.role.equals('admin'),
    );
    if (adminRole == null) {
      throw StateError('Access denied: Admin role required.');
    }

    return await ChatReport.db.find(
      session,
      where: (status != null && status.isNotEmpty && status != 'All')
          ? (t) => t.status.equals(status)
          : null,
      orderBy: (t) => t.createdAt.desc(),
      limit: 100,
    );
  }

  /// Resolve a chat report (Admin only)
  Future<bool> resolveChatReport(
    Session session, {
    required int reportId,
    required String action, // 'dismiss', 'delete_message', 'warn_user'
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Admin authentication required.');
    }

    final adminRole = await UserRole.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId) & t.role.equals('admin'),
    );
    if (adminRole == null) {
      throw StateError('Access denied: Admin role required.');
    }

    final report = await ChatReport.db.findById(session, reportId);
    if (report == null) return false;

    final now = DateTime.now().toUtc();
    report.reviewedByUserId = callerId;
    report.reviewedAt = now;
    report.actionTaken = action;

    if (action == 'delete_message') {
      report.status = 'resolved_actioned';
      final message = await ChatMessage.db.findById(session, report.messageId);
      if (message != null) {
        message.isDeletedByModerator = true;
        await ChatMessage.db.updateRow(session, message);
      }
    } else if (action == 'dismiss') {
      report.status = 'resolved_dismissed';
    } else {
      report.status = 'resolved_actioned';
    }

    await ChatReport.db.updateRow(session, report);

    // Audit log entry
    await AdminAuditLog.db.insertRow(
      session,
      AdminAuditLog(
        actorUserId: callerId,
        actorName: 'Admin',
        actionType: 'CHAT_MODERATION',
        targetEntity: 'chat_report',
        targetId: '$reportId',
        details: 'Report $reportId resolved with action: $action',
        timestamp: now,
      ),
    );

    return true;
  }

  /// List rooms accessible to the authenticated caller
  Future<List<ChatRoom>> listMyRooms(Session session) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) return [];

    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId),
    );

    final allRooms = await ChatRoom.db.find(
      session,
      orderBy: (t) => t.createdAt.desc(),
      limit: 100,
    );

    final accessible = <ChatRoom>[];
    for (final room in allRooms) {
      try {
        if (room.participantIds.contains(callerId)) {
          accessible.add(room);
          continue;
        }

        // Academic group eligibility
        if (room.roomType == 'academic_community' && profile != null) {
          final branchMatch =
              room.allowedBranch == null ||
              room.allowedBranch!.isEmpty ||
              room.allowedBranch == 'All' ||
              room.allowedBranch == profile.branch;
          final yearMatch =
              room.allowedAcademicYear == null ||
              room.allowedAcademicYear == 0 ||
              room.allowedAcademicYear == profile.academicYear;
          if (branchMatch && yearMatch) {
            accessible.add(room);
            continue;
          }
        }

        // Event discussion
        if (room.roomType == 'event_discussion') {
          accessible.add(room);
        }
      } catch (_) {}
    }

    return accessible;
  }

  /// Creates a custom room with name, optional description, topic, and academic restrictions.
  /// Derives creator identity from the authenticated session, adds creator as member,
  /// and prevents duplicate creation.
  Future<ChatRoom> createCustomRoom(
    Session session, {
    required String name,
    String? description,
    String? topic,
    String? allowedBranch,
    int? allowedAcademicYear,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to create chat rooms.');
    }

    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw ArgumentError('Room name is required.');
    }

    // Check for existing room with the same name to prevent duplicates
    final existing = await ChatRoom.db.findFirstRow(
      session,
      where: (t) => t.name.ilike(trimmedName),
    );
    if (existing != null) {
      // Add caller as participant if not present
      if (!existing.participantIds.contains(callerId)) {
        existing.participantIds.add(callerId);
        await ChatRoom.db.updateRow(session, existing);
      }
      return existing;
    }

    final now = DateTime.now().toUtc();
    final newRoom = await ChatRoom.db.insertRow(
      session,
      ChatRoom(
        roomType: 'custom_group',
        name: trimmedName,
        description: description?.trim(),
        topic: topic?.trim(),
        creatorAuthUserId: callerId,
        participantIds: [callerId],
        allowedBranch: allowedBranch,
        allowedAcademicYear: allowedAcademicYear,
        createdAt: now,
      ),
    );

    return newRoom;
  }

  /// Joins an eligible room for non-members, enforcing academic restrictions.
  Future<ChatRoom> joinRoom(Session session, int roomId) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to join rooms.');
    }

    final room = await ChatRoom.db.findById(session, roomId);
    if (room == null) {
      throw ArgumentError('Chat room not found.');
    }

    // Verify academic eligibility
    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId),
    );

    if (room.allowedBranch != null &&
        room.allowedBranch!.isNotEmpty &&
        room.allowedBranch != 'All' &&
        profile?.branch != room.allowedBranch) {
      throw StateError(
        'Not eligible: Restricted to branch ${room.allowedBranch}.',
      );
    }
    if (room.allowedAcademicYear != null &&
        room.allowedAcademicYear! > 0 &&
        profile?.academicYear != room.allowedAcademicYear) {
      throw StateError(
        'Not eligible: Restricted to academic year ${room.allowedAcademicYear}.',
      );
    }

    if (!room.participantIds.contains(callerId)) {
      room.participantIds.add(callerId);
      await ChatRoom.db.updateRow(session, room);
    }

    return room;
  }

  /// List all accessible rooms partitioned for My Rooms vs Discover Rooms.
  Future<List<ChatRoom>> listAllAccessibleRooms(Session session) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) return [];

    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId),
    );

    final allRooms = await ChatRoom.db.find(
      session,
      orderBy: (t) => t.createdAt.desc(),
      limit: 100,
    );

    final accessible = <ChatRoom>[];
    for (final room in allRooms) {
      try {
        if (room.participantIds.contains(callerId)) {
          accessible.add(room);
          continue;
        }

        if (profile != null) {
          final branchMatch =
              room.allowedBranch == null ||
              room.allowedBranch!.isEmpty ||
              room.allowedBranch == 'All' ||
              room.allowedBranch == profile.branch;
          final yearMatch =
              room.allowedAcademicYear == null ||
              room.allowedAcademicYear == 0 ||
              room.allowedAcademicYear == profile.academicYear;
          if (branchMatch && yearMatch) {
            accessible.add(room);
            continue;
          }
        } else if (room.roomType == 'custom_group' ||
            room.roomType == 'event_discussion') {
          accessible.add(room);
        }
      } catch (_) {}
    }

    return accessible;
  }
}
