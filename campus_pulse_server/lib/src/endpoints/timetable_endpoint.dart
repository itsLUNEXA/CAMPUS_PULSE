import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import '../services/notification_service.dart';
import 'admin_endpoint.dart';

class TimetableEndpoint extends Endpoint {
  bool _timesOverlap(String startA, String endA, String startB, String endB) {
    int toMin(String t) {
      final p = t.split(':');
      return (int.tryParse(p[0]) ?? 0) * 60 +
          (p.length > 1 ? (int.tryParse(p[1]) ?? 0) : 0);
    }

    final sA = toMin(startA);
    final eA = toMin(endA);
    final sB = toMin(startB);
    final eB = toMin(endB);
    return sA < eB && eA > sB;
  }

  /// Admin only: Create class timetable entry with overlap validation and student alerts
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
    String? faculty,
  }) async {
    final isAuthorized = await AdminEndpoint.isAdmin(session);
    if (!isAuthorized) {
      throw StateError(
        'Unauthorized: Only administrators can modify class timetables.',
      );
    }

    // Overlap validation
    final existing = await SectionTimetable.db.find(
      session,
      where: (t) =>
          t.branch.equals(branch) &
          t.semester.equals(semester) &
          t.section.equals(section) &
          t.dayOfWeek.equals(dayOfWeek),
    );

    for (final other in existing) {
      if (_timesOverlap(startTime, endTime, other.startTime, other.endTime)) {
        throw ArgumentError(
          'Time slot collision: "${other.subject}" is already scheduled on $dayOfWeek at ${other.startTime} - ${other.endTime} in ${other.room}.',
        );
      }
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
        faculty: faculty,
      ),
    );

    final callerId = session.authenticated!.authUserId;
    await AdminAuditLog.db.insertRow(
      session,
      AdminAuditLog(
        actorUserId: callerId,
        actorName: 'Master Admin',
        actionType: 'TIMETABLE_CREATE',
        targetEntity: 'section_timetable',
        targetId: entry.id.toString(),
        details:
            'Published class "$subject" on $dayOfWeek ($startTime - $endTime) in $room for $branch Sem $semester-$section',
        timestamp: DateTime.now().toUtc(),
      ),
    );

    // Notify students of this branch & year
    try {
      final students = await StudentProfile.db.find(
        session,
        where: (t) =>
            t.branch.equals(branch) & t.academicYear.equals(academicYear),
      );
      for (final s in students) {
        await NotificationService.sendNotification(
          session,
          authUserId: s.authUserId,
          title: 'Class Timetable Published',
          message:
              'New class "$subject" added on $dayOfWeek ($startTime - $endTime) in $room.',
          type: 'timetable_change',
          targetRoute: 'student_timetable',
          targetId: entry.id.toString(),
          eventIdTag: 'tt_add_${entry.id}_${s.authUserId}',
        );
      }
    } catch (_) {}

    return entry;
  }

  /// Admin: Update an existing class timetable entry
  Future<SectionTimetable> updateSectionTimetable(
    Session session,
    SectionTimetable entry,
  ) async {
    final isAuthorized = await AdminEndpoint.isAdmin(session);
    if (!isAuthorized) {
      throw StateError(
        'Unauthorized: Only administrators can modify class timetables.',
      );
    }

    // Overlap validation against other classes on same section & day
    final existing = await SectionTimetable.db.find(
      session,
      where: (t) =>
          t.branch.equals(entry.branch) &
          t.semester.equals(entry.semester) &
          t.section.equals(entry.section) &
          t.dayOfWeek.equals(entry.dayOfWeek) &
          t.id.notEquals(entry.id!),
    );

    for (final other in existing) {
      if (_timesOverlap(
        entry.startTime,
        entry.endTime,
        other.startTime,
        other.endTime,
      )) {
        throw ArgumentError(
          'Time slot collision: "${other.subject}" is already scheduled on ${entry.dayOfWeek} at ${other.startTime} - ${other.endTime} in ${other.room}.',
        );
      }
    }

    final updated = await SectionTimetable.db.updateRow(session, entry);

    final callerId = session.authenticated!.authUserId;
    await AdminAuditLog.db.insertRow(
      session,
      AdminAuditLog(
        actorUserId: callerId,
        actorName: 'Master Admin',
        actionType: 'TIMETABLE_UPDATE',
        targetEntity: 'section_timetable',
        targetId: entry.id.toString(),
        details:
            'Updated class "${entry.subject}" on ${entry.dayOfWeek} for ${entry.branch} Sem ${entry.semester}-${entry.section}',
        timestamp: DateTime.now().toUtc(),
      ),
    );

    return updated;
  }

  /// Admin: Delete a class timetable entry
  Future<bool> deleteSectionTimetable(Session session, int id) async {
    final isAuthorized = await AdminEndpoint.isAdmin(session);
    if (!isAuthorized) {
      throw StateError(
        'Unauthorized: Only administrators can modify class timetables.',
      );
    }

    final item = await SectionTimetable.db.findById(session, id);
    if (item == null) return false;

    await SectionTimetable.db.deleteRow(session, item);

    final callerId = session.authenticated!.authUserId;
    await AdminAuditLog.db.insertRow(
      session,
      AdminAuditLog(
        actorUserId: callerId,
        actorName: 'Master Admin',
        actionType: 'TIMETABLE_DELETE',
        targetEntity: 'section_timetable',
        targetId: id.toString(),
        details:
            'Deleted class "${item.subject}" for ${item.branch} Sem ${item.semester}-${item.section}',
        timestamp: DateTime.now().toUtc(),
      ),
    );

    return true;
  }

  /// List all class timetables (with optional branch, semester, section filters)
  Future<List<SectionTimetable>> listAllTimetables(
    Session session, {
    String? branch,
    int? semester,
    String? section,
  }) async {
    return await SectionTimetable.db.find(
      session,
      where: (t) {
        Expression expr = Constant.bool(true);
        if (branch != null && branch.isNotEmpty) {
          expr = expr & t.branch.equals(branch);
        }
        if (semester != null && semester > 0) {
          expr = expr & t.semester.equals(semester);
        }
        if (section != null && section.isNotEmpty) {
          expr = expr & t.section.equals(section);
        }
        return expr;
      },
      orderBy: (t) => t.startTime,
    );
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
      where: (t) =>
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
      where: (t) =>
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

  /// Student: Clear/unset availability slot
  Future<bool> clearFreeSlot(
    Session session, {
    required String dayOfWeek,
    required String slotLabel,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('Authentication required to clear availability slot.');
    }

    await StudentFreeSlot.db.deleteWhere(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) &
          t.dayOfWeek.equals(dayOfWeek) &
          t.slotLabel.equals(slotLabel),
    );
    return true;
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
        where: (t) =>
            t.authUserId.equals(other.authUserId) & t.isFree.equals(true),
      );

      final List<String> sharedSlots = [];
      for (final mySlot in myFreeSlots) {
        final matches = otherFreeSlots.any(
          (o) =>
              o.dayOfWeek == mySlot.dayOfWeek &&
              o.slotLabel == mySlot.slotLabel,
        );
        if (matches) {
          sharedSlots.add('${mySlot.dayOfWeek} ${mySlot.slotLabel}');
        }
      }

      // Calculate score: (subjects * 30) + (shared slots * 25) + (location * 20)
      var score = (sharedSubjects.length * 30) + (sharedSlots.length * 25);
      if (other.hostelOrArea.toLowerCase() ==
          myProfile.hostelOrArea.toLowerCase()) {
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
    results.sort(
      (a, b) => (b['matchScore'] as int).compareTo(a['matchScore'] as int),
    );
    return results;
  }
}
