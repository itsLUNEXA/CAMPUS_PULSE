import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class NotificationService {
  /// Sends a persistent PostgreSQL notification and broadcasts via WebSocket stream.
  static Future<CampusNotification?> sendNotification(
    Session session, {
    required UuidValue authUserId,
    required String title,
    required String message,
    required String type,
    String? targetRoute,
    String? targetId,
    String? eventIdTag,
  }) async {
    // 1. Deduplication check if eventIdTag is provided
    if (eventIdTag != null) {
      final existing = await CampusNotification.db.findFirstRow(
        session,
        where: (t) =>
            t.authUserId.equals(authUserId) & t.eventIdTag.equals(eventIdTag),
      );
      if (existing != null) {
        return existing; // idempotent deduplication
      }
    }

    final now = DateTime.now().toUtc();
    final notif = await CampusNotification.db.insertRow(
      session,
      CampusNotification(
        authUserId: authUserId,
        title: title,
        message: message,
        type: type,
        targetRoute: targetRoute,
        targetId: targetId,
        isRead: false,
        createdAt: now,
        eventIdTag: eventIdTag,
      ),
    );

    // 2. Broadcast via real-time WebSocket channel
    await session.messages.postMessage(
      'notifications_$authUserId',
      notif,
    );

    return notif;
  }

  /// Notify all master administrators of system alerts or pending reviews
  static Future<void> notifyAdmins(
    Session session, {
    required String title,
    required String message,
    required String type,
    String? targetRoute,
    String? targetId,
    String? eventIdTag,
  }) async {
    final adminRoles = await UserRole.db.find(
      session,
      where: (t) => t.role.equals('admin'),
    );

    for (final r in adminRoles) {
      await sendNotification(
        session,
        authUserId: r.authUserId,
        title: title,
        message: message,
        type: type,
        targetRoute: targetRoute,
        targetId: targetId,
        eventIdTag: eventIdTag != null ? '${eventIdTag}_${r.authUserId}' : null,
      );
    }
  }
}
