import 'dart:io';
import 'dart:typed_data';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import '../services/notification_service.dart';

class AcademicResourceEndpoint extends Endpoint {
  /// Upload an academic resource (notes, pyqs, textbooks, syllabus)
  Future<AcademicResource> uploadResource(
    Session session, {
    required String title,
    String? description,
    required String university,
    required String course,
    required String branch,
    required int academicYear,
    required int semester,
    required String subjectCode,
    required String subjectName,
    int? unitNumber,
    required String resourceType,
    required String fileUrl,
    int? fileSize,
    required String uploaderName,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to upload resources');
    }

    final now = DateTime.now().toUtc();
    final item = await AcademicResource.db.insertRow(
      session,
      AcademicResource(
        title: title,
        description: description,
        university: university,
        course: course,
        branch: branch,
        academicYear: academicYear,
        semester: semester,
        subjectCode: subjectCode,
        subjectName: subjectName,
        unitNumber: unitNumber,
        resourceType: resourceType,
        fileUrl: fileUrl,
        fileSize: fileSize,
        uploadedByUserId: callerId,
        uploaderName: uploaderName,
        isApproved: false,
        createdAt: now,
        downloadCount: 0,
      ),
    );

    // Notify admins of new pending submission
    try {
      await NotificationService.notifyAdmins(
        session,
        title: 'Academic Submission Pending Review',
        message:
            '$uploaderName submitted "$title" for $subjectName ($subjectCode). Review and verify.',
        type: 'admin_alert',
        targetRoute: 'master_admin',
        targetId: item.id.toString(),
        eventIdTag: 'res_upload_${item.id}',
      );
    } catch (_) {}

    return item;
  }

  /// Filter academic resources
  Future<List<AcademicResource>> filterResources(
    Session session, {
    String? university,
    String? course,
    String? branch,
    int? semester,
    String? subjectCode,
    int? unitNumber,
    String? resourceType,
    bool onlyApproved = true,
  }) async {
    return await AcademicResource.db.find(
      session,
      where: (t) {
        Expression expr = Constant.bool(true);
        if (onlyApproved) {
          expr = expr & t.isApproved.equals(true);
        }
        if (university != null && university.isNotEmpty) {
          expr = expr & t.university.ilike('%$university%');
        }
        if (course != null && course.isNotEmpty) {
          expr = expr & t.course.equals(course);
        }
        if (branch != null && branch.isNotEmpty) {
          expr = expr & t.branch.equals(branch);
        }
        if (semester != null && semester > 0) {
          expr = expr & t.semester.equals(semester);
        }
        if (subjectCode != null && subjectCode.isNotEmpty) {
          expr = expr & t.subjectCode.equals(subjectCode);
        }
        if (unitNumber != null) {
          expr = expr & t.unitNumber.equals(unitNumber);
        }
        if (resourceType != null &&
            resourceType.isNotEmpty &&
            resourceType != 'All') {
          expr = expr & t.resourceType.equals(resourceType);
        }
        return expr;
      },
      orderBy: (t) => t.createdAt.desc(),
      limit: 100,
    );
  }

  /// List pending academic resources awaiting verification
  Future<List<AcademicResource>> listPendingResources(Session session) async {
    return await AcademicResource.db.find(
      session,
      where: (t) => t.isApproved.equals(false),
      orderBy: (t) => t.createdAt.desc(),
      limit: 100,
    );
  }

  /// Approve or reject resource with optional reason and submitter alert
  Future<bool> setApprovalStatus(
    Session session,
    int resourceId,
    bool approved, {
    String? reason,
  }) async {
    final callerId = session.authenticated?.authUserId;
    final resource = await AcademicResource.db.findById(session, resourceId);
    if (resource == null) return false;

    resource.isApproved = approved;
    resource.approvedByUserId = callerId;
    resource.rejectionReason = reason;
    await AcademicResource.db.updateRow(session, resource);

    if (callerId != null) {
      await AdminAuditLog.db.insertRow(
        session,
        AdminAuditLog(
          actorUserId: callerId,
          actorName: 'Master Admin',
          actionType: approved ? 'RESOURCE_APPROVE' : 'RESOURCE_REJECT',
          targetEntity: 'academic_resource',
          targetId: '$resourceId',
          details:
              'Resource "${resource.title}" status set to approved=$approved${reason != null ? " (Reason: $reason)" : ""}',
          timestamp: DateTime.now().toUtc(),
        ),
      );
    }

    // Notify submitter of decision
    try {
      await NotificationService.sendNotification(
        session,
        authUserId: resource.uploadedByUserId,
        title: approved
            ? 'Academic Material Approved'
            : 'Academic Material Not Approved',
        message: approved
            ? 'Your notes "${resource.title}" for ${resource.subjectName} were approved and published to the student library!'
            : 'Your submission "${resource.title}" was not approved.${reason != null ? " Reason: $reason" : ""}',
        type: 'academic_approval',
        targetRoute: 'academic_resources',
        targetId: '$resourceId',
        eventIdTag: 'res_approval_${resourceId}_$approved',
      );
    } catch (_) {}

    return true;
  }

  /// Increment download count
  Future<bool> recordDownload(Session session, int resourceId) async {
    final resource = await AcademicResource.db.findById(session, resourceId);
    if (resource == null) return false;

    resource.downloadCount += 1;
    await AcademicResource.db.updateRow(session, resource);
    return true;
  }

  /// List syllabus units for a subject
  Future<List<SyllabusNode>> getSubjectSyllabus(
    Session session, {
    required String branch,
    required int semester,
    required String subjectCode,
  }) async {
    return await SyllabusNode.db.find(
      session,
      where: (t) =>
          t.branch.equals(branch) &
          t.semester.equals(semester) &
          t.subjectCode.equals(subjectCode),
      orderBy: (t) => t.unitNumber,
    );
  }

  /// Upload an actual PDF file to persistent backend storage,
  /// validate size and magic bytes, record in PostgreSQL, and return the record.
  Future<AcademicResource> uploadPdf(
    Session session, {
    required String title,
    String? description,
    required String university,
    required String course,
    required String branch,
    required int academicYear,
    required int semester,
    required String subjectCode,
    required String subjectName,
    int? unitNumber,
    required String resourceType,
    required String filename,
    required ByteData fileBytes,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to upload resources.');
    }

    final bytes = fileBytes.buffer.asUint8List();
    if (bytes.isEmpty) {
      throw ArgumentError('The selected file is empty.');
    }

    // Configured size limit: 25 MB
    const maxBytes = 25 * 1024 * 1024;
    if (bytes.length > maxBytes) {
      throw ArgumentError('File size exceeds the 25 MB limit.');
    }

    // Validate PDF magic bytes: %PDF-
    if (bytes.length < 4 ||
        bytes[0] != 0x25 ||
        bytes[1] != 0x50 ||
        bytes[2] != 0x44 ||
        bytes[3] != 0x46) {
      throw ArgumentError(
        'Invalid file: The file must be a valid PDF document.',
      );
    }

    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId),
    );
    final verifiedUploaderName = profile?.fullName ?? 'Student Contributor';

    final storageDir = Directory('storage/academic_resources');
    if (!storageDir.existsSync()) {
      storageDir.createSync(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final sanitizedFilename = filename.replaceAll(
      RegExp(r'[^a-zA-Z0-9_\-\.]'),
      '_',
    );
    final durableStoragePath =
        'storage/academic_resources/${timestamp}_$sanitizedFilename';

    final file = File(durableStoragePath);
    try {
      await file.writeAsBytes(bytes, flush: true);
    } catch (e) {
      throw StateError('Failed to persist file to server storage: $e');
    }

    try {
      final now = DateTime.now().toUtc();
      final resource = await AcademicResource.db.insertRow(
        session,
        AcademicResource(
          title: title.trim(),
          description: description?.trim(),
          university: university.trim().isNotEmpty
              ? university.trim()
              : 'State Technological University',
          course: course.trim().isNotEmpty ? course.trim() : 'B.Tech',
          branch: branch.trim(),
          academicYear: academicYear,
          semester: semester,
          subjectCode: subjectCode.trim().isNotEmpty
              ? subjectCode.trim()
              : 'ACAD',
          subjectName: subjectName.trim(),
          unitNumber: unitNumber,
          resourceType: resourceType.trim(),
          fileUrl: durableStoragePath,
          fileSize: bytes.length,
          uploadedByUserId: callerId,
          uploaderName: verifiedUploaderName,
          isApproved: true,
          createdAt: now,
          downloadCount: 0,
        ),
      );
      return resource;
    } catch (e) {
      if (file.existsSync()) {
        try {
          file.deleteSync();
        } catch (_) {}
      }
      throw StateError('Failed to save resource record in database: $e');
    }
  }

  /// Downloads the actual stored PDF file.
  /// Returns ByteData containing physical PDF bytes, or null if the file is unavailable.
  /// Increments the download counter only upon successful physical retrieval.
  Future<ByteData?> downloadPdf(Session session, int resourceId) async {
    final resource = await AcademicResource.db.findById(session, resourceId);
    if (resource == null) {
      throw ArgumentError('Academic resource not found.');
    }

    final file = File(resource.fileUrl);
    if (!file.existsSync()) {
      // File does not exist on storage: return null without incrementing counter
      return null;
    }

    try {
      final bytes = await file.readAsBytes();

      // Successful physical retrieval: increment download counter
      resource.downloadCount += 1;
      await AcademicResource.db.updateRow(session, resource);

      return ByteData.sublistView(bytes);
    } catch (e) {
      return null;
    }
  }

  /// Checks whether an actual physical PDF file exists on storage for this resource.
  Future<bool> isPdfAvailable(Session session, int resourceId) async {
    final resource = await AcademicResource.db.findById(session, resourceId);
    if (resource == null) return false;
    final file = File(resource.fileUrl);
    return file.existsSync();
  }
}
