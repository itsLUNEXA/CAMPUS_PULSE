import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import '../generated/protocol.dart';

class StudentEndpoint extends Endpoint {
  /// 1-click instant demo login for Aarav Sharma (CSE Year 3)
  Future<AuthSuccess> loginDemo(Session session) async {
    const demoEmail = 'aarav.sharma@campus.edu';
    var emailAccount = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(demoEmail),
    );

    UuidValue authUserId;
    if (emailAccount == null) {
      final authUser = await const AuthUsers().create(session);
      authUserId = authUser.id;
      await AuthServices.instance.emailIdp.admin.createEmailAuthentication(
        session,
        authUserId: authUserId,
        email: demoEmail,
        password: 'password123',
      );
    } else {
      authUserId = emailAccount.authUserId;
    }

    final existingProfile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    if (existingProfile == null) {
      final now = DateTime.now().toUtc();
      await StudentProfile.db.insertRow(
        session,
        StudentProfile(
          authUserId: authUserId,
          fullName: 'Aarav Sharma',
          email: demoEmail,
          branch: 'CSE',
          academicYear: 3,
          hostelOrArea: 'Kaveri Hostel Block B',
          bio: 'Competitive programmer and open source enthusiast.',
          subjectInterests: ['DSA', 'Operating Systems', 'DBMS'],
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    return await AuthServices.instance.emailIdp.login(
      session,
      email: demoEmail,
      password: 'password123',
    );
  }

  /// Registers a new student and signs them in directly
  Future<AuthSuccess> registerStudent(
    Session session, {
    required String fullName,
    required String email,
    required String password,
    required String branch,
    required int academicYear,
    required String hostelOrArea,
    String? bio,
    required List<String> subjectInterests,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    var emailAccount = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(cleanEmail),
    );

    UuidValue authUserId;
    if (emailAccount == null) {
      final authUser = await const AuthUsers().create(session);
      authUserId = authUser.id;
      await AuthServices.instance.emailIdp.admin.createEmailAuthentication(
        session,
        authUserId: authUserId,
        email: cleanEmail,
        password: password,
      );
    } else {
      authUserId = emailAccount.authUserId;
    }

    final existingProfile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    final now = DateTime.now().toUtc();
    if (existingProfile == null) {
      await StudentProfile.db.insertRow(
        session,
        StudentProfile(
          authUserId: authUserId,
          fullName: fullName.trim(),
          email: cleanEmail,
          branch: branch,
          academicYear: academicYear,
          hostelOrArea: hostelOrArea.trim(),
          bio: bio?.trim(),
          subjectInterests: subjectInterests,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    return await AuthServices.instance.emailIdp.login(
      session,
      email: cleanEmail,
      password: password,
    );
  }

  /// Returns the profile of the currently authenticated student.
  Future<StudentProfile?> getProfile(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return null;

    return await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
  }

  /// Creates or updates the profile for the currently authenticated student.
  Future<StudentProfile> updateProfile(
    Session session, {
    required String fullName,
    String? email,
    required String branch,
    required int academicYear,
    required String hostelOrArea,
    String? bio,
    required List<String> subjectInterests,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated to update profile.');
    }

    // Input validation
    final trimmedName = fullName.trim();
    if (trimmedName.isEmpty) {
      throw ArgumentError('Full name cannot be empty.');
    }
    if (academicYear < 1 || academicYear > 4) {
      throw ArgumentError('Academic year must be between 1 and 4.');
    }

    final validBranches = {
      'CSE',
      'IT',
      'ECE',
      'Mechanical',
      'Civil',
      'General',
    };
    final cleanBranch = validBranches.contains(branch) ? branch : 'CSE';

    final now = DateTime.now().toUtc();
    final existing = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    final resolvedEmail = (email != null && email.trim().isNotEmpty)
        ? email.trim().toLowerCase()
        : (existing?.email ??
              '${authUserId.toString().substring(0, 8)}@campus.edu');

    if (existing != null) {
      final updated = existing.copyWith(
        fullName: trimmedName,
        email: resolvedEmail,
        branch: cleanBranch,
        academicYear: academicYear,
        hostelOrArea: hostelOrArea.trim(),
        bio: bio?.trim(),
        subjectInterests: subjectInterests,
        updatedAt: now,
      );
      return await StudentProfile.db.updateRow(session, updated);
    } else {
      final newProfile = StudentProfile(
        authUserId: authUserId,
        fullName: trimmedName,
        email: resolvedEmail,
        branch: cleanBranch,
        academicYear: academicYear,
        hostelOrArea: hostelOrArea.trim(),
        bio: bio?.trim(),
        subjectInterests: subjectInterests,
        createdAt: now,
        updatedAt: now,
      );
      return await StudentProfile.db.insertRow(session, newProfile);
    }
  }

  /// Public student profile for matching and discovery (excludes email/private details).
  Future<StudentProfile?> getPublicProfile(
    Session session,
    UuidValue authUserId,
  ) async {
    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (profile == null) return null;

    // Redact sensitive email in public view
    return profile.copyWith(email: '***@campus.edu');
  }

  /// Discovers student study partners with deterministic compatibility matching.
  Future<List<StudentProfile>> discoverStudents(
    Session session, {
    String? branch,
    int? academicYear,
    String? subject,
    String? hostelOrArea,
    int limit = 20,
    int offset = 0,
  }) async {
    final currentUserId = session.authenticated?.authUserId;

    // Fetch candidate profiles bounded by limit
    final candidates = await StudentProfile.db.find(
      session,
      where: (t) {
        Expression expr = currentUserId != null
            ? t.authUserId.notEquals(currentUserId)
            : Constant.bool(true);

        if (branch != null && branch.isNotEmpty && branch != 'All') {
          expr = expr & t.branch.equals(branch);
        }
        if (academicYear != null && academicYear > 0) {
          expr = expr & t.academicYear.equals(academicYear);
        }
        return expr;
      },
      limit: 100, // retrieve bounded set for in-memory score ranking
    );

    // If subject or hostel filter specified, filter and score deterministically
    var scoredList = candidates.map((student) {
      int score = 0;
      if (subject != null && subject.isNotEmpty && subject != 'All') {
        if (student.subjectInterests.any(
          (s) => s.toLowerCase() == subject.toLowerCase(),
        )) {
          score += 50;
        }
      }
      if (hostelOrArea != null && hostelOrArea.isNotEmpty) {
        if (student.hostelOrArea.toLowerCase().contains(
          hostelOrArea.toLowerCase(),
        )) {
          score += 30;
        }
      }
      return MapEntry(student, score);
    }).toList();

    // Sort by compatibility score descending, then by fullName
    scoredList.sort((a, b) {
      final cmp = b.value.compareTo(a.value);
      if (cmp != 0) return cmp;
      return a.key.fullName.compareTo(b.key.fullName);
    });

    final paged = scoredList
        .skip(offset)
        .take(limit)
        .map((e) => e.key.copyWith(email: '***@campus.edu'))
        .toList();

    return paged;
  }
}
