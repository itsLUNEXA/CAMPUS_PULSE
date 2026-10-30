import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class AttendanceEndpoint extends Endpoint {
  /// Record or update student attendance for an event
  Future<AttendanceRecord> markAttendance(
    Session session, {
    required int eventId,
    required UuidValue studentAuthUserId,
    required String studentName,
    required String status,
    String? checkInCode,
    String? notes,
  }) async {
    final callerId = session.authenticated?.authUserId;

    // Check existing
    final existing = await AttendanceRecord.db.findFirstRow(
      session,
      where: (t) =>
          t.eventId.equals(eventId) & t.authUserId.equals(studentAuthUserId),
    );

    final now = DateTime.now().toUtc();
    AttendanceRecord record;

    if (existing != null) {
      existing.status = status;
      existing.notes = notes ?? existing.notes;
      existing.markedAt = now;
      existing.markedByUserId = callerId;
      record = await AttendanceRecord.db.updateRow(session, existing);
    } else {
      record = await AttendanceRecord.db.insertRow(
        session,
        AttendanceRecord(
          eventId: eventId,
          authUserId: studentAuthUserId,
          studentName: studentName,
          status: status,
          checkInCode: checkInCode,
          markedByUserId: callerId,
          markedAt: now,
          notes: notes,
        ),
      );
    }

    // Log attendance modification
    if (callerId != null) {
      await AdminAuditLog.db.insertRow(
        session,
        AdminAuditLog(
          actorUserId: callerId,
          actorName: 'Staff/Organizer',
          actionType: 'ATTENDANCE_MARK',
          targetEntity: 'attendance_record',
          targetId: '${record.id}',
          details: 'Marked $studentName as $status for Event #$eventId',
          timestamp: now,
        ),
      );
    }

    return record;
  }

  /// Self check-in via event check-in code
  Future<AttendanceRecord> checkInWithCode(
    Session session, {
    required int eventId,
    required String enteredCode,
    required String studentName,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required for check-in');
    }

    final event = await CampusEvent.db.findById(session, eventId);
    if (event == null) {
      throw ArgumentError('Event not found');
    }

    // Verify student is RSVP'd
    final rsvp = await EventRsvp.db.findFirstRow(
      session,
      where: (t) => t.eventId.equals(eventId) & t.authUserId.equals(callerId),
    );
    if (rsvp == null) {
      throw StateError(
        'Must be registered/RSVPed for event before checking in',
      );
    }

    // Prevent duplicate check-in
    final existing = await AttendanceRecord.db.findFirstRow(
      session,
      where: (t) => t.eventId.equals(eventId) & t.authUserId.equals(callerId),
    );
    if (existing != null && existing.status == 'attended') {
      return existing;
    }

    final now = DateTime.now().toUtc();
    return await AttendanceRecord.db.insertRow(
      session,
      AttendanceRecord(
        eventId: eventId,
        authUserId: callerId,
        studentName: studentName,
        status: 'attended',
        checkInCode: enteredCode,
        markedByUserId: callerId,
        markedAt: now,
        notes: 'Verified self check-in',
      ),
    );
  }

  /// Get attendance list for an event
  Future<List<AttendanceRecord>> getEventAttendance(
    Session session,
    int eventId,
  ) async {
    return await AttendanceRecord.db.find(
      session,
      where: (t) => t.eventId.equals(eventId),
      orderBy: (t) => t.markedAt.desc(),
    );
  }

  /// Get attendance history for the logged-in student
  Future<List<AttendanceRecord>> getMyAttendanceHistory(Session session) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) return [];

    return await AttendanceRecord.db.find(
      session,
      where: (t) => t.authUserId.equals(callerId),
      orderBy: (t) => t.markedAt.desc(),
    );
  }
}
