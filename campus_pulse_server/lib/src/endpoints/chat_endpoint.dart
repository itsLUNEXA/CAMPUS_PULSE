import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class ChatEndpoint extends Endpoint {
  /// Create or fetch an existing chat room
  Future<ChatRoom> getOrCreateRoom(
    Session session, {
    required String roomType,
    String? referenceId,
    required String name,
    required List<UuidValue> participantIds,
  }) async {
    // For direct chat between 2 users
    if (roomType == 'direct' && participantIds.length == 2) {
      final rooms = await ChatRoom.db.find(
        session,
        where: (t) => t.roomType.equals('direct'),
      );
      for (final r in rooms) {
        if (r.participantIds.contains(participantIds[0]) &&
            r.participantIds.contains(participantIds[1])) {
          return r;
        }
      }
    }

    // For event discussion room
    if (roomType == 'event_discussion' && referenceId != null) {
      final existing = await ChatRoom.db.findFirstRow(
        session,
        where:
            (t) =>
                t.roomType.equals('event_discussion') &
                t.referenceId.equals(referenceId),
      );
      if (existing != null) return existing;
    }

    final now = DateTime.now().toUtc();
    return await ChatRoom.db.insertRow(
      session,
      ChatRoom(
        roomType: roomType,
        referenceId: referenceId,
        name: name,
        participantIds: participantIds,
        createdAt: now,
      ),
    );
  }

  /// Send message in a room
  Future<ChatMessage> sendMessage(
    Session session, {
    required int roomId,
    required String content,
    required String senderName,
    String? attachmentUrl,
    String? attachmentType,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to chat');
    }

    final now = DateTime.now().toUtc();
    final message = await ChatMessage.db.insertRow(
      session,
      ChatMessage(
        roomId: roomId,
        senderUserId: callerId,
        senderName: senderName,
        content: content,
        attachmentUrl: attachmentUrl,
        attachmentType: attachmentType,
        isRead: false,
        createdAt: now,
        isEdited: false,
      ),
    );

    // Update room lastMessage metadata
    final room = await ChatRoom.db.findById(session, roomId);
    if (room != null) {
      room.lastMessageText = content;
      room.lastMessageAt = now;
      await ChatRoom.db.updateRow(session, room);
    }

    // Broadcast in real-time to channel
    await session.messages.postMessage('chat_$roomId', message);

    return message;
  }

  /// Retrieve messages for room
  Future<List<ChatMessage>> getRoomMessages(
    Session session,
    int roomId, {
    int limit = 50,
  }) async {
    return await ChatMessage.db.find(
      session,
      where: (t) => t.roomId.equals(roomId),
      orderBy: (t) => t.createdAt,
      limit: limit,
    );
  }

  /// List rooms for caller
  Future<List<ChatRoom>> listMyRooms(Session session) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) return [];

    final allRooms = await ChatRoom.db.find(
      session,
      orderBy: (t) => t.createdAt.desc(),
    );

    return allRooms.where((r) => r.participantIds.contains(callerId) || r.roomType == 'event_discussion' || r.roomType == 'group').toList();
  }
}
