import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class NotificationEndpoint extends Endpoint {
  /// Fetch user's persistent notifications
  Future<List<CampusNotification>> getMyNotifications(
    Session session, {
    bool? unreadOnly,
    String? type,
    int limit = 30,
    int offset = 0,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return [];

    return await CampusNotification.db.find(
      session,
      where: (t) {
        Expression expr = t.authUserId.equals(authUserId);
        if (unreadOnly == true) {
          expr = expr & t.isRead.equals(false);
        }
        if (type != null && type.isNotEmpty && type != 'all') {
          expr = expr & t.type.equals(type);
        }
        return expr;
      },
      orderBy: (t) => t.createdAt.desc(),
      limit: limit,
      offset: offset,
    );
  }

  /// Get unread notifications count
  Future<int> getUnreadCount(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return 0;

    return await CampusNotification.db.count(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.isRead.equals(false),
    );
  }

  /// Mark single notification as read
  Future<bool> markAsRead(Session session, int id) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final notif = await CampusNotification.db.findById(session, id);
    if (notif == null || notif.authUserId != authUserId) return false;

    notif.isRead = true;
    await CampusNotification.db.updateRow(session, notif);
    return true;
  }

  /// Mark all notifications as read
  Future<bool> markAllAsRead(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final unread = await CampusNotification.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.isRead.equals(false),
    );

    for (final n in unread) {
      n.isRead = true;
      await CampusNotification.db.updateRow(session, n);
    }
    return true;
  }

  /// Stream real-time notifications for the authenticated user
  Stream<CampusNotification> streamMyNotifications(Session session) async* {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return;

    final stream = session.messages.createStream<CampusNotification>(
      'notifications_$authUserId',
    );
    await for (final notif in stream) {
      yield notif;
    }
  }
}
