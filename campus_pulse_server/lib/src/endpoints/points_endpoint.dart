import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import 'admin_endpoint.dart';

class PointsEndpoint extends Endpoint {
  /// Validates QR scan, confirms attendance, and awards points
  Future<Map<String, dynamic>> checkInWithQrToken(
    Session session, {
    required int eventId,
    required String qrToken,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      return {'status': 'unauthorized', 'message': 'Please log in to check in.'};
    }

    final event = await CampusEvent.db.findById(session, eventId);
    if (event == null) {
      return {'status': 'invalid_event', 'message': 'Event does not exist.'};
    }

    // Check RSVP
    final rsvp = await EventRsvp.db.findFirstRow(
      session,
      where: (t) => t.eventId.equals(eventId) & t.authUserId.equals(authUserId),
    );
    if (rsvp == null) {
      return {
        'status': 'no_rsvp',
        'message': 'No RSVP found! You must register for this event before check-in.',
      };
    }

    // Check if already checked in
    final existingAttendance = await AttendanceRecord.db.findFirstRow(
      session,
      where: (t) => t.eventId.equals(eventId) & t.authUserId.equals(authUserId),
    );
    if (existingAttendance != null && existingAttendance.status == 'attended') {
      return {
        'status': 'already_checked_in',
        'message': 'You have already checked in for this event.',
      };
    }

    // Check time window: within 2 hours before start and 4 hours after start
    final now = DateTime.now().toUtc();
    final windowStart = event.startTime.subtract(const Duration(hours: 2));
    final windowEnd = event.endTime ?? event.startTime.add(const Duration(hours: 4));
    if (now.isBefore(windowStart) || now.isAfter(windowEnd)) {
      return {
        'status': 'expired_qr',
        'message': 'Check-in window is closed for this event.',
      };
    }

    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final studentName = profile?.fullName ?? 'Student';

    // 1. Mark attendance confirmed
    if (existingAttendance != null) {
      existingAttendance.status = 'attended';
      existingAttendance.checkInCode = qrToken;
      existingAttendance.markedAt = now;
      await AttendanceRecord.db.updateRow(session, existingAttendance);
    } else {
      await AttendanceRecord.db.insertRow(
        session,
        AttendanceRecord(
          eventId: eventId,
          authUserId: authUserId,
          studentName: studentName,
          status: 'attended',
          checkInCode: qrToken,
          markedByUserId: authUserId,
          markedAt: now,
          notes: 'QR venue scan check-in',
        ),
      );
    }

    // 2. Award 50 points to points_ledger
    const pointsAwarded = 50;
    await PointsLedger.db.insertRow(
      session,
      PointsLedger(
        authUserId: authUserId,
        studentName: studentName,
        source: 'event_checkin',
        points: pointsAwarded,
        description: 'Attended ${event.title}',
        timestamp: now,
      ),
    );

    // 3. Notify via WebSocket channel using CampusNotification model
    await session.messages.postMessage(
      'notifications_$authUserId',
      CampusNotification(
        id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
        title: 'Event Check-In Confirmed',
        message: '🎉 Checked in to ${event.title}! +$pointsAwarded Campus Points earned.',
        type: 'event_checkin',
        timestamp: now,
      ),
    );

    return {
      'status': 'confirmed',
      'pointsAwarded': pointsAwarded,
      'message': 'Attendance confirmed! You earned $pointsAwarded points.',
    };
  }

  /// Get student total points & streak
  Future<Map<String, int>> getMyPointsAndStreak(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return {'totalPoints': 0, 'currentStreak': 0};

    final ledger = await PointsLedger.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      orderBy: (t) => t.timestamp.desc(),
    );

    final totalPoints = ledger.fold<int>(0, (sum, entry) => sum + entry.points);

    // Calculate streak: count distinct days in sequence
    var streak = 0;
    if (ledger.isNotEmpty) {
      streak = 1;
      var lastDate = DateTime(
        ledger.first.timestamp.year,
        ledger.first.timestamp.month,
        ledger.first.timestamp.day,
      );

      for (var i = 1; i < ledger.length; i++) {
        final entryDate = DateTime(
          ledger[i].timestamp.year,
          ledger[i].timestamp.month,
          ledger[i].timestamp.day,
        );
        final difference = lastDate.difference(entryDate).inDays;
        if (difference == 1) {
          streak++;
          lastDate = entryDate;
        } else if (difference > 1) {
          break;
        }
      }
    }

    return {
      'totalPoints': totalPoints,
      'currentStreak': streak,
    };
  }

  /// List reward perks available for redemption
  Future<List<RewardPerk>> listRewards(Session session) async {
    return await RewardPerk.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderBy: (t) => t.costPoints,
    );
  }

  /// Admin: Create reward perk
  Future<RewardPerk> addRewardPerk(
    Session session, {
    required String title,
    required String category,
    required String description,
    required int costPoints,
    required int stockRemaining,
  }) async {
    final isAuthorized = await AdminEndpoint.isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Unauthorized: Admin access required.');
    }

    return await RewardPerk.db.insertRow(
      session,
      RewardPerk(
        title: title,
        category: category,
        description: description,
        costPoints: costPoints,
        stockRemaining: stockRemaining,
        isActive: true,
      ),
    );
  }

  /// Redeem reward perk
  Future<bool> redeemReward(Session session, int perkId) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('Authentication required.');
    }

    final perk = await RewardPerk.db.findById(session, perkId);
    if (perk == null || perk.stockRemaining <= 0) {
      throw StateError('Reward out of stock or unavailable.');
    }

    final myStats = await getMyPointsAndStreak(session);
    if (myStats['totalPoints']! < perk.costPoints) {
      throw StateError('Insufficient points balance.');
    }

    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final studentName = profile?.fullName ?? 'Student';

    // Deduct points in ledger
    await PointsLedger.db.insertRow(
      session,
      PointsLedger(
        authUserId: authUserId,
        studentName: studentName,
        source: 'reward_redemption',
        points: -perk.costPoints,
        description: 'Redeemed ${perk.title}',
        timestamp: DateTime.now().toUtc(),
      ),
    );

    perk.stockRemaining -= 1;
    await RewardPerk.db.updateRow(session, perk);

    return true;
  }
}
