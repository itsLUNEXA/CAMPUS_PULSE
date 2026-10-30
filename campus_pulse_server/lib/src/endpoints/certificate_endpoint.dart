import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class CertificateEndpoint extends Endpoint {
  /// Generate and issue a certificate for an attendee
  Future<EventCertificate> issueCertificate(
    Session session, {
    required int eventId,
    required UuidValue studentAuthUserId,
    required String studentName,
    String signatureTitle = 'Dean of Student Affairs',
  }) async {
    final callerId = session.authenticated?.authUserId;

    // Verify event exists
    final event = await CampusEvent.db.findById(session, eventId);
    if (event == null) {
      throw ArgumentError('Event not found');
    }

    // Verify attendance is confirmed ('attended')
    final attendance = await AttendanceRecord.db.findFirstRow(
      session,
      where:
          (t) =>
              t.eventId.equals(eventId) &
              t.authUserId.equals(studentAuthUserId),
    );

    if (attendance == null || attendance.status != 'attended') {
      throw StateError(
        'Cannot issue certificate: Student attendance has not been confirmed for this event.',
      );
    }

    // Check if certificate already exists (prevent duplicate issuance)
    final existing = await EventCertificate.db.findFirstRow(
      session,
      where:
          (t) =>
              t.eventId.equals(eventId) &
              t.authUserId.equals(studentAuthUserId),
    );
    if (existing != null) {
      return existing;
    }

    // Create unique deterministic certificate ID
    final rawHash = md5.convert(
      utf8.encode('CP-CERT-$eventId-$studentAuthUserId-${DateTime.now().millisecondsSinceEpoch}'),
    ).toString().substring(0, 10).toUpperCase();
    final certificateId = 'CP-$eventId-$rawHash';
    final verificationUrl = 'https://campuspulse.edu/verify/$certificateId';
    final now = DateTime.now().toUtc();

    final cert = await EventCertificate.db.insertRow(
      session,
      EventCertificate(
        certificateId: certificateId,
        eventId: eventId,
        authUserId: studentAuthUserId,
        studentName: studentName,
        eventName: event.title,
        eventDate: event.startTime,
        issuedAt: now,
        issuedByUserId: callerId,
        verificationUrl: verificationUrl,
        status: 'valid',
        signatureTitle: signatureTitle,
      ),
    );

    // Audit log
    if (callerId != null) {
      await AdminAuditLog.db.insertRow(
        session,
        AdminAuditLog(
          actorUserId: callerId,
          actorName: 'Authorized Admin/Staff',
          actionType: 'CERT_ISSUE',
          targetEntity: 'event_certificate',
          targetId: certificateId,
          details: 'Issued certificate $certificateId to $studentName for event ${event.title}',
          timestamp: now,
        ),
      );
    }

    return cert;
  }

  /// Verify certificate by ID
  Future<EventCertificate?> verifyCertificate(
    Session session,
    String certificateId,
  ) async {
    return await EventCertificate.db.findFirstRow(
      session,
      where: (t) => t.certificateId.equals(certificateId),
    );
  }

  /// Get my certificates
  Future<List<EventCertificate>> getMyCertificates(Session session) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) return [];

    return await EventCertificate.db.find(
      session,
      where: (t) => t.authUserId.equals(callerId),
      orderBy: (t) => t.issuedAt.desc(),
    );
  }

  /// Revoke certificate (Admin only)
  Future<bool> revokeCertificate(
    Session session,
    String certificateId,
    String reason,
  ) async {
    final cert = await EventCertificate.db.findFirstRow(
      session,
      where: (t) => t.certificateId.equals(certificateId),
    );
    if (cert == null) return false;

    cert.status = 'revoked';
    await EventCertificate.db.updateRow(session, cert);

    final callerId = session.authenticated?.authUserId;
    if (callerId != null) {
      await AdminAuditLog.db.insertRow(
        session,
        AdminAuditLog(
          actorUserId: callerId,
          actorName: 'Admin',
          actionType: 'CERT_REVOKE',
          targetEntity: 'event_certificate',
          targetId: certificateId,
          details: 'Revoked certificate $certificateId. Reason: $reason',
          timestamp: DateTime.now().toUtc(),
        ),
      );
    }
    return true;
  }
}
