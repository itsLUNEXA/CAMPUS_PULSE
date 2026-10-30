import 'dart:async';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/foundation.dart';
import '../client.dart';

class RealtimeService extends ChangeNotifier {
  StreamSubscription<RsvpUpdate>? _rsvpSubscription;
  StreamSubscription<LeaderboardUpdate>? _leaderboardSubscription;
  StreamSubscription<CampusNotification>? _notificationSubscription;

  final List<RsvpUpdate> _recentRsvps = [];
  final List<LeaderboardUpdate> _recentLeaderboardUpdates = [];
  final List<CampusNotification> _notifications = [];
  int _unreadCount = 0;

  List<RsvpUpdate> get recentRsvps => List.unmodifiable(_recentRsvps);
  List<LeaderboardUpdate> get recentLeaderboardUpdates =>
      List.unmodifiable(_recentLeaderboardUpdates);
  List<CampusNotification> get notifications =>
      List.unmodifiable(_notifications);
  int get unreadCount => _unreadCount;

  bool _isConnecting = false;
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  void startListening() {
    if (_isConnecting || _isConnected) return;
    _isConnecting = true;

    try {
      // 1. Subscribe to RSVP updates stream
      _rsvpSubscription?.cancel();
      final rsvpStream = client.event.streamRsvpUpdates();
      _rsvpSubscription = rsvpStream.listen(
        (update) {
          _isConnected = true;
          _recentRsvps.insert(0, update);
          if (_recentRsvps.length > 50) _recentRsvps.removeLast();
          notifyListeners();
        },
        onError: (err) {
          _isConnected = false;
          _scheduleReconnect();
        },
        onDone: () {
          _isConnected = false;
          _scheduleReconnect();
        },
      );

      // 2. Subscribe to Leaderboard updates stream
      _leaderboardSubscription?.cancel();
      final leaderboardStream = client.leaderboard.streamLeaderboardUpdates();
      _leaderboardSubscription = leaderboardStream.listen(
        (update) {
          _isConnected = true;
          _recentLeaderboardUpdates.insert(0, update);
          if (_recentLeaderboardUpdates.length > 50) {
            _recentLeaderboardUpdates.removeLast();
          }
          notifyListeners();
        },
        onError: (err) {
          _isConnected = false;
        },
        onDone: () {
          _isConnected = false;
        },
      );

      // 3. Subscribe to real-time personal notifications stream
      _startNotificationStream();

      // Fetch initial notifications
      refreshNotifications();

      _isConnecting = false;
      _isConnected = true;
      notifyListeners();
    } catch (_) {
      _isConnecting = false;
      _isConnected = false;
      _scheduleReconnect();
    }
  }

  void _startNotificationStream() {
    try {
      _notificationSubscription?.cancel();
      final notifStream = client.notification.streamMyNotifications();
      _notificationSubscription = notifStream.listen(
        (notif) {
          // Deduplicate if already present
          final idx = _notifications.indexWhere((n) => n.id == notif.id);
          if (idx >= 0) {
            _notifications[idx] = notif;
          } else {
            _notifications.insert(0, notif);
            if (!notif.isRead) {
              _unreadCount++;
            }
          }
          if (_notifications.length > 100) _notifications.removeLast();
          notifyListeners();
        },
        onError: (_) {},
        onDone: () {},
      );
    } catch (_) {}
  }

  /// Fetches persistent notifications and unread count from Serverpod PostgreSQL
  Future<void> refreshNotifications({String? type}) async {
    try {
      final notifs = await client.notification.getMyNotifications(
        limit: 50,
        offset: 0,
        type: type,
      );
      final unread = await client.notification.getUnreadCount();

      _notifications.clear();
      _notifications.addAll(notifs);
      _unreadCount = unread;
      notifyListeners();
    } catch (_) {
      // Offline / unauthenticated fallback
    }
  }

  /// Marks a specific notification as read
  Future<void> markAsRead(int notificationId) async {
    // Optimistic update
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      final old = _notifications[index];
      if (!old.isRead) {
        _notifications[index] = old.copyWith(isRead: true);
        if (_unreadCount > 0) _unreadCount--;
        notifyListeners();
      }
    }

    try {
      await client.notification.markAsRead(notificationId);
    } catch (_) {}
  }

  /// Marks all notifications as read
  Future<void> markAllAsRead() async {
    // Optimistic update
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    _unreadCount = 0;
    notifyListeners();

    try {
      await client.notification.markAllAsRead();
    } catch (_) {}
  }

  /// Clears previous account-specific state and cancels personal notification stream
  void clearSession() {
    _notificationSubscription?.cancel();
    _notificationSubscription = null;
    _notifications.clear();
    _unreadCount = 0;
    notifyListeners();
  }

  void _scheduleReconnect() {
    Timer(const Duration(seconds: 5), () {
      startListening();
    });
  }

  @override
  void dispose() {
    _rsvpSubscription?.cancel();
    _leaderboardSubscription?.cancel();
    _notificationSubscription?.cancel();
    super.dispose();
  }
}
