import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class MomEndpoint extends Endpoint {
  /// Create a new Minutes of Meeting record
  Future<MinutesOfMeeting> createMom(
    Session session, {
    required String title,
    required DateTime meetingDate,
    required String organizerName,
    required List<String> attendeeNames,
    required String agenda,
    required List<String> discussionPoints,
    required List<String> decisions,
    required List<String> actionItems,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to create MoM');
    }

    final now = DateTime.now().toUtc();
    return await MinutesOfMeeting.db.insertRow(
      session,
      MinutesOfMeeting(
        title: title,
        meetingDate: meetingDate,
        organizerUserId: callerId,
        organizerName: organizerName,
        attendeeNames: attendeeNames,
        agenda: agenda,
        discussionPoints: discussionPoints,
        decisions: decisions,
        actionItems: actionItems,
        createdAt: now,
      ),
    );
  }

  /// List all Minutes of Meeting
  Future<List<MinutesOfMeeting>> listMoms(Session session) async {
    return await MinutesOfMeeting.db.find(
      session,
      orderBy: (t) => t.meetingDate.desc(),
      limit: 50,
    );
  }

  /// Get MoM by ID
  Future<MinutesOfMeeting?> getMomDetail(Session session, int momId) async {
    return await MinutesOfMeeting.db.findById(session, momId);
  }
}
