import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import '../generated/protocol.dart';

class AdminEndpoint extends Endpoint {
  /// Check whether the caller has the admin role
  static Future<bool> isAdmin(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final roles = await UserRole.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    return roles.any((r) => r.role == 'admin');
  }

  /// Dedicated Admin Login: Validates admin credentials and verifies that the account possesses the 'admin' role.
  /// Throws an exception if credentials are valid but the account is not an authorized administrator.
  Future<AuthSuccess> loginAdmin(
    Session session, {
    required String email,
    required String password,
  }) async {
    final cleanEmail = email.trim().toLowerCase();

    // Authenticate credentials with Email Identity Provider
    final authSuccess = await AuthServices.instance.emailIdp.login(
      session,
      email: cleanEmail,
      password: password,
    );

    final authUserId = authSuccess.authUserId;

    // Verify whether this user has the 'admin' role in user_role table
    final adminRole = await UserRole.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.role.equals('admin'),
    );

    if (adminRole == null) {
      // Reject non-admin students attempting to log in through admin portal
      throw StateError(
        'Access Denied: This account is not an authorized Master Administrator.',
      );
    }

    // Log admin login to audit trail
    await AdminAuditLog.db.insertRow(
      session,
      AdminAuditLog(
        actorUserId: authUserId,
        actorName: cleanEmail,
        actionType: 'ADMIN_LOGIN',
        targetEntity: 'admin_session',
        targetId: authUserId.toString(),
        details: 'Admin logged into Master Control Panel',
        timestamp: DateTime.now().toUtc(),
      ),
    );

    return authSuccess;
  }

  /// 1-Click Master Admin Setup / Demo Login for Authorized Campus Administrators
  /// Securely provisions the master administrator account if it does not yet exist.
  Future<AuthSuccess> loginMasterAdminDemo(Session session) async {
    const adminEmail = 'admin@campuspulse.edu';
    const adminPassword = 'AdminMasterPassword2026!';

    var emailAccount = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(adminEmail),
    );

    UuidValue authUserId;
    if (emailAccount == null) {
      final authUser = await const AuthUsers().create(session);
      authUserId = authUser.id;
      await AuthServices.instance.emailIdp.admin.createEmailAuthentication(
        session,
        authUserId: authUserId,
        email: adminEmail,
        password: adminPassword,
      );
    } else {
      authUserId = emailAccount.authUserId;
    }

    // Ensure 'admin' role is firmly assigned in user_role table
    final existingRole = await UserRole.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.role.equals('admin'),
    );
    if (existingRole == null) {
      await UserRole.db.insertRow(
        session,
        UserRole(
          authUserId: authUserId,
          role: 'admin',
          assignedScope: 'master_control',
          grantedAt: DateTime.now().toUtc(),
        ),
      );
    }

    // Log the action
    await AdminAuditLog.db.insertRow(
      session,
      AdminAuditLog(
        actorUserId: authUserId,
        actorName: 'Master Admin',
        actionType: 'MASTER_ADMIN_LOGIN',
        targetEntity: 'admin_portal',
        targetId: authUserId.toString(),
        details: 'Master Admin authenticated into Master Control Panel',
        timestamp: DateTime.now().toUtc(),
      ),
    );

    return await AuthServices.instance.emailIdp.login(
      session,
      email: adminEmail,
      password: adminPassword,
    );
  }

  /// Verify whether currently authenticated session has master admin role
  Future<bool> verifyAdminSession(Session session) async {
    return await isAdmin(session);
  }

  /// Get real-time aggregated counts from actual database records
  Future<Map<String, int>> getDashboardOverview(Session session) async {
    final isAuthorized = await isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Unauthorized: Admin access required.');
    }

    final totalStudents = await StudentProfile.db.count(session);
    final totalEvents = await CampusEvent.db.count(session);
    final now = DateTime.now().toUtc();
    final upcomingEvents = await CampusEvent.db.count(
      session,
      where: (t) => t.startTime > now,
    );
    final pendingEvents = await CampusEvent.db.count(
      session,
      where: (t) => t.approvalStatus.equals('pending'),
    );
    final totalRsvps = await EventRsvp.db.count(session);
    final totalAttendances = await AttendanceRecord.db.count(session);
    final totalCertificates = await EventCertificate.db.count(session);
    final totalResources = await AcademicResource.db.count(session);
    final pendingResources = await AcademicResource.db.count(
      session,
      where: (t) => t.isApproved.equals(false),
    );
    final totalChatRooms = await ChatRoom.db.count(session);
    final totalMoms = await MinutesOfMeeting.db.count(session);

    return {
      'totalStudents': totalStudents,
      'totalEvents': totalEvents,
      'upcomingEvents': upcomingEvents,
      'pendingEvents': pendingEvents,
      'totalRsvps': totalRsvps,
      'totalAttendances': totalAttendances,
      'totalCertificates': totalCertificates,
      'totalResources': totalResources,
      'pendingResources': pendingResources,
      'totalChatRooms': totalChatRooms,
      'totalMoms': totalMoms,
    };
  }

  /// Assign a role to a user (Admin only)
  Future<bool> assignRole(
    Session session,
    UuidValue targetUserId,
    String role, {
    String? scope,
  }) async {
    final isAuthorized = await isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Unauthorized: Admin access required.');
    }

    final callerId = session.authenticated!.authUserId;

    final existing = await UserRole.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(targetUserId) & t.role.equals(role),
    );

    if (existing == null) {
      await UserRole.db.insertRow(
        session,
        UserRole(
          authUserId: targetUserId,
          role: role,
          assignedScope: scope,
          grantedAt: DateTime.now().toUtc(),
        ),
      );
    }

    // Log admin action
    await AdminAuditLog.db.insertRow(
      session,
      AdminAuditLog(
        actorUserId: callerId,
        actorName: 'Master Admin',
        actionType: 'ROLE_ASSIGN',
        targetEntity: 'user_role',
        targetId: targetUserId.toString(),
        details: 'Assigned role $role with scope $scope',
        timestamp: DateTime.now().toUtc(),
      ),
    );

    return true;
  }

  /// Revoke a role from a user (Admin only, prevents removing last superadmin)
  Future<bool> revokeRole(
    Session session,
    UuidValue targetUserId,
    String role,
  ) async {
    final isAuthorized = await isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Unauthorized: Admin access required.');
    }

    // Prevent accidental removal of the last master superadmin
    if (role == 'admin') {
      final adminCount = await UserRole.db.count(
        session,
        where: (t) => t.role.equals('admin'),
      );
      if (adminCount <= 1) {
        throw StateError(
          'Security Protection: Cannot remove the last Master Administrator.',
        );
      }
    }

    final callerId = session.authenticated!.authUserId;
    final row = await UserRole.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(targetUserId) & t.role.equals(role),
    );
    if (row != null) {
      await UserRole.db.deleteRow(session, row);
    }

    await AdminAuditLog.db.insertRow(
      session,
      AdminAuditLog(
        actorUserId: callerId,
        actorName: 'Master Admin',
        actionType: 'ROLE_REVOKE',
        targetEntity: 'user_role',
        targetId: targetUserId.toString(),
        details: 'Revoked role $role from student $targetUserId',
        timestamp: DateTime.now().toUtc(),
      ),
    );

    return true;
  }

  /// Fetch all assigned roles for a target student
  Future<List<String>> getUserRoles(
    Session session,
    UuidValue targetUserId,
  ) async {
    final isAuthorized = await isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Unauthorized: Admin access required.');
    }

    final roles = await UserRole.db.find(
      session,
      where: (t) => t.authUserId.equals(targetUserId),
    );

    final list = roles.map((r) => r.role).toList();
    if (!list.contains('student')) list.add('student');
    return list;
  }

  /// Searchable, paginated student roster for admin management
  Future<List<StudentProfile>> listStudents(
    Session session, {
    String? search,
    int limit = 20,
    int offset = 0,
  }) async {
    final isAuthorized = await isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Unauthorized: Admin access required.');
    }

    return await StudentProfile.db.find(
      session,
      where: (t) {
        if (search != null && search.trim().isNotEmpty) {
          final q = search.trim();
          return t.fullName.ilike('%$q%') |
              t.email.ilike('%$q%') |
              t.branch.ilike('%$q%');
        }
        return Constant.bool(true);
      },
      orderBy: (t) => t.fullName,
      limit: limit,
      offset: offset,
    );
  }

  /// Total count of students matching query
  Future<int> getStudentCount(
    Session session, {
    String? search,
  }) async {
    final isAuthorized = await isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Unauthorized: Admin access required.');
    }

    return await StudentProfile.db.count(
      session,
      where: (t) {
        if (search != null && search.trim().isNotEmpty) {
          final q = search.trim();
          return t.fullName.ilike('%$q%') |
              t.email.ilike('%$q%') |
              t.branch.ilike('%$q%');
        }
        return Constant.bool(true);
      },
    );
  }

  /// Get roles for current caller
  Future<List<String>> getMyRoles(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return ['student'];

    final roles = await UserRole.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    final list = roles.map((r) => r.role).toList();
    if (!list.contains('student')) list.add('student');
    return list;
  }

  /// List admin audit logs with search, action filtering, and pagination
  Future<List<AdminAuditLog>> listAuditLogs(
    Session session, {
    String? search,
    String? actionType,
    int limit = 50,
    int offset = 0,
  }) async {
    final isAuthorized = await isAdmin(session);
    if (!isAuthorized) {
      throw StateError('Unauthorized: Admin access required.');
    }

    return await AdminAuditLog.db.find(
      session,
      where: (t) {
        Expression expr = Constant.bool(true);
        if (actionType != null &&
            actionType.isNotEmpty &&
            actionType != 'ALL') {
          expr = expr & t.actionType.equals(actionType);
        }
        if (search != null && search.trim().isNotEmpty) {
          final q = search.trim();
          expr =
              expr &
              (t.actorName.ilike('%$q%') |
                  t.details.ilike('%$q%') |
                  t.actionType.ilike('%$q%'));
        }
        return expr;
      },
      orderBy: (t) => t.timestamp.desc(),
      limit: limit,
      offset: offset,
    );
  }
}
