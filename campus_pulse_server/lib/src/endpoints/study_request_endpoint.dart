import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import '../services/notification_service.dart';

class StudyRequestEndpoint extends Endpoint {
  /// Sends a study match request to another student.
  Future<StudyRequest> sendRequest(
    Session session, {
    required UuidValue recipientAuthUserId,
    required String subject,
    required String message,
    required String urgency,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated to send study requests.');
    }

    if (authUserId == recipientAuthUserId) {
      throw ArgumentError('Cannot send a study request to yourself.');
    }

    // Sender student profile
    final senderProfile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final senderName = senderProfile?.fullName ?? 'Student';
    final senderBranch = senderProfile?.branch ?? 'CSE';
    final senderYear = senderProfile?.academicYear ?? 1;

    // Recipient name
    final recipientProfile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(recipientAuthUserId),
    );
    final recipientName = recipientProfile?.fullName ?? 'Peer Student';

    final now = DateTime.now().toUtc();
    final request = StudyRequest(
      senderAuthUserId: authUserId,
      senderName: senderName,
      senderBranch: senderBranch,
      senderYear: senderYear,
      recipientAuthUserId: recipientAuthUserId,
      recipientName: recipientName,
      subject: subject.trim(),
      message: message.trim(),
      status: 'pending',
      urgency: urgency.trim(),
      createdAt: now,
      updatedAt: now,
    );

    final saved = await StudyRequest.db.insertRow(session, request);

    try {
      await NotificationService.sendNotification(
        session,
        authUserId: recipientAuthUserId,
        title: 'New Study Buddy Request',
        message:
            '$senderName sent you a study buddy request for "$subject" ($urgency priority).',
        type: 'study_request',
        targetRoute: 'study_buddies',
        targetId: saved.id.toString(),
        eventIdTag: 'study_req_send_${saved.id}',
      );
    } catch (_) {}

    return saved;
  }

  /// Retrieves all study requests received by the current student.
  Future<List<StudyRequest>> getMyIncomingRequests(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return [];

    return await StudyRequest.db.find(
      session,
      where: (t) => t.recipientAuthUserId.equals(authUserId),
      orderBy: (t) => t.createdAt.desc(),
      limit: 50,
    );
  }

  /// Retrieves all study requests sent by the current student.
  Future<List<StudyRequest>> getMyOutgoingRequests(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return [];

    return await StudyRequest.db.find(
      session,
      where: (t) => t.senderAuthUserId.equals(authUserId),
      orderBy: (t) => t.createdAt.desc(),
      limit: 50,
    );
  }

  /// Updates status of a study request (accepted, declined, cancelled).
  Future<StudyRequest> updateRequestStatus(
    Session session, {
    required int requestId,
    required String newStatus,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated.');
    }

    final validStatuses = {'accepted', 'declined', 'cancelled'};
    if (!validStatuses.contains(newStatus)) {
      throw ArgumentError('Invalid status: $newStatus');
    }

    final req = await StudyRequest.db.findById(session, requestId);
    if (req == null) {
      throw ArgumentError('Study request not found.');
    }

    // Authorization checks:
    // Only recipient can accept or decline
    if ((newStatus == 'accepted' || newStatus == 'declined') &&
        req.recipientAuthUserId != authUserId) {
      throw StateError(
        'Only the recipient can accept or decline this request.',
      );
    }

    // Only sender can cancel
    if (newStatus == 'cancelled' && req.senderAuthUserId != authUserId) {
      throw StateError('Only the sender can cancel this request.');
    }

    final updated = req.copyWith(
      status: newStatus,
      updatedAt: DateTime.now().toUtc(),
    );

    final saved = await StudyRequest.db.updateRow(session, updated);

    // Send notifications based on status change
    try {
      if (newStatus == 'accepted') {
        await NotificationService.sendNotification(
          session,
          authUserId: req.senderAuthUserId,
          title: 'Study Buddy Request Accepted! 🎉',
          message:
              '${req.recipientName} accepted your study buddy request for "${req.subject}". You can now coordinate study sessions together.',
          type: 'study_request',
          targetRoute: 'study_buddies',
          targetId: saved.id.toString(),
          eventIdTag: 'study_req_accepted_${saved.id}',
        );
      } else if (newStatus == 'declined') {
        await NotificationService.sendNotification(
          session,
          authUserId: req.senderAuthUserId,
          title: 'Study Buddy Request Declined',
          message:
              '${req.recipientName} was unable to accept your study buddy request for "${req.subject}".',
          type: 'study_request',
          targetRoute: 'study_buddies',
          targetId: saved.id.toString(),
          eventIdTag: 'study_req_declined_${saved.id}',
        );
      }
    } catch (_) {}

    return saved;
  }
}
