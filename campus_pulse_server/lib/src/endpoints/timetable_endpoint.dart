import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import 'admin_endpoint.dart';

class TimetableEndpoint extends Endpoint {
  /// Admin only: Create or update class timetable for a section
  Future<SectionTimetable> addSectionTimetable(
    Session session, {
    required String branch,
    required int academicYear,
    required int semester,
    required String section,
    required String dayOfWeek,
    required String startTime,
    required String endTime,
    required String subject,
    required String room,
  }) async {
    final isAuthorized = await AdminEndpoint.isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Unauthorized: Only administrators can modify class timetables.');
    }

    final entry = await SectionTimetable.db.insertRow(
      session,
      SectionTimetable(
        branch: branch,
        academicYear: academicYear,
        semester: semester,
        section: section,
        dayOfWeek: dayOfWeek,
        startTime: startTime,
        endTime: endTime,
        subject: subject,
        room: room,
      ),
    );

    return entry;
  }

  /// Get class timetable for specific section
  Future<List<SectionTimetable>> getSectionTimetable(
    Session session, {
    required String branch,
    required int semester,
    required String section,
  }) async {
    return await SectionTimetable.db.find(
      session,
      where:
          (t) =>
              t.branch.equals(branch) &
              t.semester.equals(semester) &
              t.section.equals(section),
      orderBy: (t) => t.startTime,
    );
  }

  /// Student: Get my saved free slots
  Future<List<StudentFreeSlot>> getMyFreeSlots(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return [];

    return await StudentFreeSlot.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
  }

  /// Student: Toggle or set free slot status
  Future<StudentFreeSlot> updateFreeSlot(
    Session session, {
    required String dayOfWeek,
    required String slotLabel,
    required String startTime,
    required String endTime,
    required bool isFree,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('Authentication required to update free slots.');
    }

    final existing = await StudentFreeSlot.db.findFirstRow(
      session,
      where:
          (t) =>
              t.authUserId.equals(authUserId) &
              t.dayOfWeek.equals(dayOfWeek) &
              t.slotLabel.equals(slotLabel),
    );

    if (existing != null) {
      existing.isFree = isFree;
      existing.updatedAt = DateTime.now().toUtc();
      return await StudentFreeSlot.db.updateRow(session, existing);
    } else {
      return await StudentFreeSlot.db.insertRow(
        session,
        StudentFreeSlot(
          authUserId: authUserId,
          dayOfWeek: dayOfWeek,
          slotLabel: slotLabel,
          startTime: startTime,
          endTime: endTime,
          isFree: isFree,
          updatedAt: DateTime.now().toUtc(),
        ),
      );
    }
  }

  /// Timetable-aware study buddy matching upgrade
  /// Combines common subjects + overlapping free time slots + location
  Future<List<Map<String, dynamic>>> findTimetableStudyMatches(
    Session session,
  ) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return [];

    final myProfile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (myProfile == null) return [];

    final myFreeSlots = await StudentFreeSlot.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.isFree.equals(true),
    );

    // Other students
    final otherStudents = await StudentProfile.db.find(
      session,
      where: (t) => t.authUserId.notEquals(authUserId),
      limit: 30,
    );

    final List<Map<String, dynamic>> results = [];

    for (final other in otherStudents) {
      // 1. Shared subjects
      final sharedSubjects = other.subjectInterests
          .where((s) => myProfile.subjectInterests.contains(s))
          .toList();

      // 2. Overlapping free slots
      final otherFreeSlots = await StudentFreeSlot.db.find(
        session,
        where: (t) => t.authUserId.equals(other.authUserId) & t.isFree.equals(true),
      );

      final List<String> sharedSlots = [];
      for (final mySlot in myFreeSlots) {
        final matches = otherFreeSlots.any(
          (o) => o.dayOfWeek == mySlot.dayOfWeek && o.slotLabel == mySlot.slotLabel,
        );
        if (matches) {
          sharedSlots.add('${mySlot.dayOfWeek} ${mySlot.slotLabel}');
        }
      }

      // Calculate score: (subjects * 30) + (shared slots * 25) + (location * 20)
      var score = (sharedSubjects.length * 30) + (sharedSlots.length * 25);
      if (other.hostelOrArea.toLowerCase() == myProfile.hostelOrArea.toLowerCase()) {
        score += 20;
      }

      results.add({
        'student': other.toJson(),
        'sharedSubjects': sharedSubjects,
        'sharedSlots': sharedSlots,
        'matchScore': score,
        'hasTimetableData': otherFreeSlots.isNotEmpty,
      });
    }

    // Sort descending by match score
    results.sort((a, b) => (b['matchScore'] as int).compareTo(a['matchScore'] as int));
    return results;
  }
}

