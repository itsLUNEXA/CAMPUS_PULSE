import 'dart:async';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/foundation.dart';
import '../client.dart';

class RealtimeService extends ChangeNotifier {
  StreamSubscription<RsvpUpdate>? _rsvpSubscription;
  StreamSubscription<LeaderboardUpdate>? _leaderboardSubscription;

  final List<RsvpUpdate> _recentRsvps = [];
  final List<LeaderboardUpdate> _recentLeaderboardUpdates = [];
  final List<CampusNotification> _notifications = [];

  List<RsvpUpdate> get recentRsvps => List.unmodifiable(_recentRsvps);
  List<LeaderboardUpdate> get recentLeaderboardUpdates =>
      List.unmodifiable(_recentLeaderboardUpdates);
  List<CampusNotification> get notifications =>
      List.unmodifiable(_notifications);

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

          _notifications.insert(
            0,
            CampusNotification(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: update.action == 'rsvp' ? 'New RSVP' : 'RSVP Cancelled',
              message:
                  'Event #${update.eventId} now has ${update.rsvpCount} RSVPs',
              type: 'event',
              timestamp: DateTime.now(),
            ),
          );
          if (_notifications.length > 50) _notifications.removeLast();
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

          _notifications.insert(
            0,
            CampusNotification(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: 'Leaderboard Update',
              message:
                  '${update.studentName} scored ${update.score} in ${update.subject}!',
              type: 'quiz',
              timestamp: DateTime.now(),
            ),
          );
          if (_notifications.length > 50) _notifications.removeLast();
          notifyListeners();
        },
        onError: (err) {
          _isConnected = false;
        },
        onDone: () {
          _isConnected = false;
        },
      );

      _isConnecting = false;
      _isConnected = true;
      notifyListeners();
    } catch (_) {
      _isConnecting = false;
      _isConnected = false;
      _scheduleReconnect();
    }
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
    super.dispose();
  }
}
