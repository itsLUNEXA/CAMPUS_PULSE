import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

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
    return await AcademicResource.db.insertRow(
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
        if (resourceType != null && resourceType.isNotEmpty && resourceType != 'All') {
          expr = expr & t.resourceType.equals(resourceType);
        }
        return expr;
      },
      orderBy: (t) => t.createdAt.desc(),
      limit: 100,
    );
  }

  /// Approve or reject resource (Admin / Contributor Review)
  Future<bool> setApprovalStatus(
    Session session,
    int resourceId,
    bool approved,
  ) async {
    final callerId = session.authenticated?.authUserId;
    final resource = await AcademicResource.db.findById(session, resourceId);
    if (resource == null) return false;

    resource.isApproved = approved;
    resource.approvedByUserId = callerId;
    await AcademicResource.db.updateRow(session, resource);

    if (callerId != null) {
      await AdminAuditLog.db.insertRow(
        session,
        AdminAuditLog(
          actorUserId: callerId,
          actorName: 'Moderator',
          actionType: approved ? 'RESOURCE_APPROVE' : 'RESOURCE_REJECT',
          targetEntity: 'academic_resource',
          targetId: '$resourceId',
          details: 'Resource "${resource.title}" status set to approved=$approved',
          timestamp: DateTime.now().toUtc(),
        ),
      );
    }
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
      where:
          (t) =>
              t.branch.equals(branch) &
              t.semester.equals(semester) &
              t.subjectCode.equals(subjectCode),
      orderBy: (t) => t.unitNumber,
    );
  }
}
