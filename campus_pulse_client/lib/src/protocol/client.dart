/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:campus_pulse_client/src/protocol/academic_resource.dart'
    as _id97hjpr;
import 'package:campus_pulse_client/src/protocol/admin_audit_log.dart'
    as _i6e8adep;
import 'package:campus_pulse_client/src/protocol/attendance_record.dart'
    as _id4j1rwr;
import 'package:campus_pulse_client/src/protocol/campus_event.dart'
    as _ip4v6fvs;
import 'package:campus_pulse_client/src/protocol/chat_message.dart'
    as _ik3iv9q2;
import 'package:campus_pulse_client/src/protocol/chat_report.dart' as _izhvp4kh;
import 'package:campus_pulse_client/src/protocol/chat_room.dart' as _i69co3yd;
import 'package:campus_pulse_client/src/protocol/event_certificate.dart'
    as _ihpqvest;
import 'package:campus_pulse_client/src/protocol/event_rsvp.dart' as _in2xsmyl;
import 'package:campus_pulse_client/src/protocol/greetings/greeting.dart'
    as _itza125m;
import 'package:campus_pulse_client/src/protocol/leaderboard_entry.dart'
    as _ipx1rsvs;
import 'package:campus_pulse_client/src/protocol/leaderboard_update.dart'
    as _ivors92c;
import 'package:campus_pulse_client/src/protocol/minutes_of_meeting.dart'
    as _idz08l1h;
import 'package:campus_pulse_client/src/protocol/quiz_attempt.dart'
    as _i395nlzx;
import 'package:campus_pulse_client/src/protocol/quiz_question_view.dart'
    as _iipzebr3;
import 'package:campus_pulse_client/src/protocol/quiz_result_summary.dart'
    as _iy42s5tm;
import 'package:campus_pulse_client/src/protocol/quiz_submission.dart'
    as _ipj905dc;
import 'package:campus_pulse_client/src/protocol/reward_perk.dart' as _i04nrlxs;
import 'package:campus_pulse_client/src/protocol/rsvp_update.dart' as _i2m6gzec;
import 'package:campus_pulse_client/src/protocol/search_response.dart'
    as _irna5qn8;
import 'package:campus_pulse_client/src/protocol/section_timetable.dart'
    as _ij8cgkiw;
import 'package:campus_pulse_client/src/protocol/student_free_slot.dart'
    as _iuvh50w9;
import 'package:campus_pulse_client/src/protocol/student_profile.dart'
    as _i66wptcz;
import 'package:campus_pulse_client/src/protocol/study_request.dart'
    as _i18m6utc;
import 'package:campus_pulse_client/src/protocol/syllabus_node.dart'
    as _i5ej9mnt;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// {@category Endpoint}
class EndpointAcademicResource extends _isc.EndpointRef {
  EndpointAcademicResource(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'academicResource';

  /// Upload an academic resource (notes, pyqs, textbooks, syllabus)
  _ida.Future<_id97hjpr.AcademicResource> uploadResource({
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
  }) => caller.callServerEndpoint<_id97hjpr.AcademicResource>(
    'academicResource',
    'uploadResource',
    {
      'title': title,
      'description': description,
      'university': university,
      'course': course,
      'branch': branch,
      'academicYear': academicYear,
      'semester': semester,
      'subjectCode': subjectCode,
      'subjectName': subjectName,
      'unitNumber': unitNumber,
      'resourceType': resourceType,
      'fileUrl': fileUrl,
      'fileSize': fileSize,
      'uploaderName': uploaderName,
    },
  );

  /// Filter academic resources
  _ida.Future<List<_id97hjpr.AcademicResource>> filterResources({
    String? university,
    String? course,
    String? branch,
    int? semester,
    String? subjectCode,
    int? unitNumber,
    String? resourceType,
    required bool onlyApproved,
  }) => caller.callServerEndpoint<List<_id97hjpr.AcademicResource>>(
    'academicResource',
    'filterResources',
    {
      'university': university,
      'course': course,
      'branch': branch,
      'semester': semester,
      'subjectCode': subjectCode,
      'unitNumber': unitNumber,
      'resourceType': resourceType,
      'onlyApproved': onlyApproved,
    },
  );

  /// Approve or reject resource (Admin / Contributor Review)
  _ida.Future<bool> setApprovalStatus(
    int resourceId,
    bool approved,
  ) => caller.callServerEndpoint<bool>(
    'academicResource',
    'setApprovalStatus',
    {
      'resourceId': resourceId,
      'approved': approved,
    },
  );

  /// Increment download count
  _ida.Future<bool> recordDownload(int resourceId) =>
      caller.callServerEndpoint<bool>(
        'academicResource',
        'recordDownload',
        {'resourceId': resourceId},
      );

  /// List syllabus units for a subject
  _ida.Future<List<_i5ej9mnt.SyllabusNode>> getSubjectSyllabus({
    required String branch,
    required int semester,
    required String subjectCode,
  }) => caller.callServerEndpoint<List<_i5ej9mnt.SyllabusNode>>(
    'academicResource',
    'getSubjectSyllabus',
    {
      'branch': branch,
      'semester': semester,
      'subjectCode': subjectCode,
    },
  );
}

/// {@category Endpoint}
class EndpointAdmin extends _isc.EndpointRef {
  EndpointAdmin(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  /// Dedicated Admin Login: Validates admin credentials and verifies that the account possesses the 'admin' role.
  /// Throws an exception if credentials are valid but the account is not an authorized administrator.
  _ida.Future<_iacc.AuthSuccess> loginAdmin({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'admin',
    'loginAdmin',
    {
      'email': email,
      'password': password,
    },
  );

  /// 1-Click Master Admin Setup / Demo Login for Authorized Campus Administrators
  /// Securely provisions the master administrator account if it does not yet exist.
  _ida.Future<_iacc.AuthSuccess> loginMasterAdminDemo() =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'admin',
        'loginMasterAdminDemo',
        {},
      );

  /// Verify whether currently authenticated session has master admin role
  _ida.Future<bool> verifyAdminSession() => caller.callServerEndpoint<bool>(
    'admin',
    'verifyAdminSession',
    {},
  );

  /// Get real-time aggregated counts from actual database records
  _ida.Future<Map<String, int>> getDashboardOverview() =>
      caller.callServerEndpoint<Map<String, int>>(
        'admin',
        'getDashboardOverview',
        {},
      );

  /// Assign a role to a user (Admin only)
  _ida.Future<bool> assignRole(
    _isc.UuidValue targetUserId,
    String role, {
    String? scope,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'assignRole',
    {
      'targetUserId': targetUserId,
      'role': role,
      'scope': scope,
    },
  );

  /// Get roles for current caller
  _ida.Future<List<String>> getMyRoles() =>
      caller.callServerEndpoint<List<String>>(
        'admin',
        'getMyRoles',
        {},
      );

  /// List admin audit logs (Admin only)
  _ida.Future<List<_i6e8adep.AdminAuditLog>> listAuditLogs({
    required int limit,
  }) => caller.callServerEndpoint<List<_i6e8adep.AdminAuditLog>>(
    'admin',
    'listAuditLogs',
    {'limit': limit},
  );
}

/// {@category Endpoint}
class EndpointAttendance extends _isc.EndpointRef {
  EndpointAttendance(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'attendance';

  /// Record or update student attendance for an event
  _ida.Future<_id4j1rwr.AttendanceRecord> markAttendance({
    required int eventId,
    required _isc.UuidValue studentAuthUserId,
    required String studentName,
    required String status,
    String? checkInCode,
    String? notes,
  }) => caller.callServerEndpoint<_id4j1rwr.AttendanceRecord>(
    'attendance',
    'markAttendance',
    {
      'eventId': eventId,
      'studentAuthUserId': studentAuthUserId,
      'studentName': studentName,
      'status': status,
      'checkInCode': checkInCode,
      'notes': notes,
    },
  );

  /// Self check-in via event check-in code
  _ida.Future<_id4j1rwr.AttendanceRecord> checkInWithCode({
    required int eventId,
    required String enteredCode,
    required String studentName,
  }) => caller.callServerEndpoint<_id4j1rwr.AttendanceRecord>(
    'attendance',
    'checkInWithCode',
    {
      'eventId': eventId,
      'enteredCode': enteredCode,
      'studentName': studentName,
    },
  );

  /// Get attendance list for an event
  _ida.Future<List<_id4j1rwr.AttendanceRecord>> getEventAttendance(
    int eventId,
  ) => caller.callServerEndpoint<List<_id4j1rwr.AttendanceRecord>>(
    'attendance',
    'getEventAttendance',
    {'eventId': eventId},
  );

  /// Get attendance history for the logged-in student
  _ida.Future<List<_id4j1rwr.AttendanceRecord>> getMyAttendanceHistory() =>
      caller.callServerEndpoint<List<_id4j1rwr.AttendanceRecord>>(
        'attendance',
        'getMyAttendanceHistory',
        {},
      );
}

/// {@category Endpoint}
class EndpointCertificate extends _isc.EndpointRef {
  EndpointCertificate(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'certificate';

  /// Generate and issue a certificate for an attendee
  _ida.Future<_ihpqvest.EventCertificate> issueCertificate({
    required int eventId,
    required _isc.UuidValue studentAuthUserId,
    required String studentName,
    required String signatureTitle,
  }) => caller.callServerEndpoint<_ihpqvest.EventCertificate>(
    'certificate',
    'issueCertificate',
    {
      'eventId': eventId,
      'studentAuthUserId': studentAuthUserId,
      'studentName': studentName,
      'signatureTitle': signatureTitle,
    },
  );

  /// Verify certificate by ID
  _ida.Future<_ihpqvest.EventCertificate?> verifyCertificate(
    String certificateId,
  ) => caller.callServerEndpoint<_ihpqvest.EventCertificate?>(
    'certificate',
    'verifyCertificate',
    {'certificateId': certificateId},
  );

  /// Get my certificates
  _ida.Future<List<_ihpqvest.EventCertificate>> getMyCertificates() =>
      caller.callServerEndpoint<List<_ihpqvest.EventCertificate>>(
        'certificate',
        'getMyCertificates',
        {},
      );

  /// Revoke certificate (Admin only)
  _ida.Future<bool> revokeCertificate(
    String certificateId,
    String reason,
  ) => caller.callServerEndpoint<bool>(
    'certificate',
    'revokeCertificate',
    {
      'certificateId': certificateId,
      'reason': reason,
    },
  );
}

/// {@category Endpoint}
class EndpointChat extends _isc.EndpointRef {
  EndpointChat(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  /// Create or fetch an existing chat room with optional branch/year restrictions
  _ida.Future<_i69co3yd.ChatRoom> getOrCreateRoom({
    required String roomType,
    String? referenceId,
    required String name,
    required List<_isc.UuidValue> participantIds,
    String? allowedBranch,
    int? allowedAcademicYear,
  }) => caller.callServerEndpoint<_i69co3yd.ChatRoom>(
    'chat',
    'getOrCreateRoom',
    {
      'roomType': roomType,
      'referenceId': referenceId,
      'name': name,
      'participantIds': participantIds,
      'allowedBranch': allowedBranch,
      'allowedAcademicYear': allowedAcademicYear,
    },
  );

  /// Send message in a room with enforced membership & safe authenticated sender identity
  _ida.Future<_ik3iv9q2.ChatMessage> sendMessage({
    required int roomId,
    required String content,
    String? attachmentUrl,
    String? attachmentType,
  }) => caller.callServerEndpoint<_ik3iv9q2.ChatMessage>(
    'chat',
    'sendMessage',
    {
      'roomId': roomId,
      'content': content,
      'attachmentUrl': attachmentUrl,
      'attachmentType': attachmentType,
    },
  );

  /// Retrieve messages for room with membership enforcement
  _ida.Future<List<_ik3iv9q2.ChatMessage>> getRoomMessages(
    int roomId, {
    required int limit,
  }) => caller.callServerEndpoint<List<_ik3iv9q2.ChatMessage>>(
    'chat',
    'getRoomMessages',
    {
      'roomId': roomId,
      'limit': limit,
    },
  );

  /// Real-time stream of messages for a room with membership enforcement
  _ida.Stream<_ik3iv9q2.ChatMessage> streamChatMessages(int roomId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ik3iv9q2.ChatMessage>,
        _ik3iv9q2.ChatMessage
      >(
        'chat',
        'streamChatMessages',
        {'roomId': roomId},
        {},
      );

  /// Report an inappropriate chat message
  _ida.Future<_izhvp4kh.ChatReport> reportMessage({
    required int messageId,
    required String reason,
  }) => caller.callServerEndpoint<_izhvp4kh.ChatReport>(
    'chat',
    'reportMessage',
    {
      'messageId': messageId,
      'reason': reason,
    },
  );

  /// List chat reports (Admin only)
  _ida.Future<List<_izhvp4kh.ChatReport>> listChatReports({String? status}) =>
      caller.callServerEndpoint<List<_izhvp4kh.ChatReport>>(
        'chat',
        'listChatReports',
        {'status': status},
      );

  /// Resolve a chat report (Admin only)
  _ida.Future<bool> resolveChatReport({
    required int reportId,
    required String action,
  }) => caller.callServerEndpoint<bool>(
    'chat',
    'resolveChatReport',
    {
      'reportId': reportId,
      'action': action,
    },
  );

  /// List rooms accessible to the authenticated caller
  _ida.Future<List<_i69co3yd.ChatRoom>> listMyRooms() =>
      caller.callServerEndpoint<List<_i69co3yd.ChatRoom>>(
        'chat',
        'listMyRooms',
        {},
      );
}

/// {@category Endpoint}
class EndpointEvent extends _isc.EndpointRef {
  EndpointEvent(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'event';

  /// Lists campus events with category filtering and approval check.
  /// By default returns only approved events for regular students.
  _ida.Future<List<_ip4v6fvs.CampusEvent>> listEvents({
    String? category,
    String? approvalStatus,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ip4v6fvs.CampusEvent>>(
    'event',
    'listEvents',
    {
      'category': category,
      'approvalStatus': approvalStatus,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Gets a single event by ID.
  _ida.Future<_ip4v6fvs.CampusEvent?> getEvent(int id) =>
      caller.callServerEndpoint<_ip4v6fvs.CampusEvent?>(
        'event',
        'getEvent',
        {'id': id},
      );

  /// Creates a new campus event in 'pending' status awaiting review.
  _ida.Future<_ip4v6fvs.CampusEvent> createEvent({
    required String title,
    required String description,
    required String category,
    required DateTime startTime,
    DateTime? endTime,
    required String venue,
    String? bannerUrl,
    DateTime? registrationDeadline,
    required bool isTeamEvent,
    required int minTeamSize,
    required int maxTeamSize,
    String? approvalStatus,
  }) => caller.callServerEndpoint<_ip4v6fvs.CampusEvent>(
    'event',
    'createEvent',
    {
      'title': title,
      'description': description,
      'category': category,
      'startTime': startTime,
      'endTime': endTime,
      'venue': venue,
      'bannerUrl': bannerUrl,
      'registrationDeadline': registrationDeadline,
      'isTeamEvent': isTeamEvent,
      'minTeamSize': minTeamSize,
      'maxTeamSize': maxTeamSize,
      'approvalStatus': approvalStatus,
    },
  );

  /// Edits an existing event.
  /// Material edits (title, venue, timing, deadline, category, team rules) to approved events
  /// reset approvalStatus to 'pending' and require reapproval.
  _ida.Future<_ip4v6fvs.CampusEvent> editEvent({
    required int eventId,
    required String title,
    required String description,
    required String category,
    required DateTime startTime,
    DateTime? endTime,
    required String venue,
    String? bannerUrl,
    DateTime? registrationDeadline,
    required bool isTeamEvent,
    required int minTeamSize,
    required int maxTeamSize,
  }) => caller.callServerEndpoint<_ip4v6fvs.CampusEvent>(
    'event',
    'editEvent',
    {
      'eventId': eventId,
      'title': title,
      'description': description,
      'category': category,
      'startTime': startTime,
      'endTime': endTime,
      'venue': venue,
      'bannerUrl': bannerUrl,
      'registrationDeadline': registrationDeadline,
      'isTeamEvent': isTeamEvent,
      'minTeamSize': minTeamSize,
      'maxTeamSize': maxTeamSize,
    },
  );

  /// Review event (Admin only: approve or reject with reason)
  _ida.Future<_ip4v6fvs.CampusEvent> reviewEvent({
    required int eventId,
    required String decision,
    String? rejectionReason,
  }) => caller.callServerEndpoint<_ip4v6fvs.CampusEvent>(
    'event',
    'reviewEvent',
    {
      'eventId': eventId,
      'decision': decision,
      'rejectionReason': rejectionReason,
    },
  );

  /// Registers a student or team for an event transactionally.
  /// Enforces approval status, registration deadlines, team size validation,
  /// and concurrent duplicate prevention.
  _ida.Future<bool> registerForEvent(
    int eventId, {
    String? teamName,
    List<String>? teamMemberNames,
    List<String>? teamMemberEmails,
  }) => caller.callServerEndpoint<bool>(
    'event',
    'registerForEvent',
    {
      'eventId': eventId,
      'teamName': teamName,
      'teamMemberNames': teamMemberNames,
      'teamMemberEmails': teamMemberEmails,
    },
  );

  /// Backward-compatible alias for registerForEvent
  _ida.Future<bool> rsvpEvent(int eventId) => caller.callServerEndpoint<bool>(
    'event',
    'rsvpEvent',
    {'eventId': eventId},
  );

  /// Cancels a registration transactionally.
  _ida.Future<bool> cancelRegistration(int eventId) =>
      caller.callServerEndpoint<bool>(
        'event',
        'cancelRegistration',
        {'eventId': eventId},
      );

  /// Backward-compatible alias for cancelRegistration
  _ida.Future<bool> cancelRsvp(int eventId) => caller.callServerEndpoint<bool>(
    'event',
    'cancelRsvp',
    {'eventId': eventId},
  );

  /// Checks whether the authenticated user has registered for this event.
  _ida.Future<bool> hasUserRegistered(int eventId) =>
      caller.callServerEndpoint<bool>(
        'event',
        'hasUserRegistered',
        {'eventId': eventId},
      );

  /// Backward-compatible alias
  _ida.Future<bool> hasUserRsvpd(int eventId) =>
      caller.callServerEndpoint<bool>(
        'event',
        'hasUserRsvpd',
        {'eventId': eventId},
      );

  /// Returns all event IDs that the current student has registered for.
  _ida.Future<List<int>> getMyRegisteredEventIds() =>
      caller.callServerEndpoint<List<int>>(
        'event',
        'getMyRegisteredEventIds',
        {},
      );

  /// Backward-compatible alias
  _ida.Future<List<int>> getMyRsvpdEventIds() =>
      caller.callServerEndpoint<List<int>>(
        'event',
        'getMyRsvpdEventIds',
        {},
      );

  /// Retrieves participant registration details for the owning organizer or an admin.
  _ida.Future<List<_in2xsmyl.EventRsvp>> getMyOrganizerRegistrations(
    int eventId,
  ) => caller.callServerEndpoint<List<_in2xsmyl.EventRsvp>>(
    'event',
    'getMyOrganizerRegistrations',
    {'eventId': eventId},
  );

  /// Streams real-time registration updates to connected clients.
  _ida.Stream<_i2m6gzec.RsvpUpdate> streamRsvpUpdates() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i2m6gzec.RsvpUpdate>,
        _i2m6gzec.RsvpUpdate
      >(
        'event',
        'streamRsvpUpdates',
        {},
        {},
      );
}

/// {@category Endpoint}
class EndpointLeaderboard extends _isc.EndpointRef {
  EndpointLeaderboard(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'leaderboard';

  /// Computes authoritative leaderboard rankings from persisted quiz attempts.
  _ida.Future<List<_ipx1rsvs.LeaderboardEntry>> getLeaderboard({
    String? subject,
    String? branch,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_ipx1rsvs.LeaderboardEntry>>(
    'leaderboard',
    'getLeaderboard',
    {
      'subject': subject,
      'branch': branch,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Retrieves the current student's leaderboard rank and statistics.
  _ida.Future<_ipx1rsvs.LeaderboardEntry?> getMyRank({String? subject}) =>
      caller.callServerEndpoint<_ipx1rsvs.LeaderboardEntry?>(
        'leaderboard',
        'getMyRank',
        {'subject': subject},
      );

  /// Streams real-time leaderboard update notifications to connected clients.
  _ida.Stream<_ivors92c.LeaderboardUpdate> streamLeaderboardUpdates() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ivors92c.LeaderboardUpdate>,
        _ivors92c.LeaderboardUpdate
      >(
        'leaderboard',
        'streamLeaderboardUpdates',
        {},
        {},
      );
}

/// {@category Endpoint}
class EndpointMom extends _isc.EndpointRef {
  EndpointMom(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'mom';

  /// Create a new Minutes of Meeting record
  _ida.Future<_idz08l1h.MinutesOfMeeting> createMom({
    required String title,
    required DateTime meetingDate,
    required String organizerName,
    required List<String> attendeeNames,
    required String agenda,
    required List<String> discussionPoints,
    required List<String> decisions,
    required List<String> actionItems,
  }) => caller.callServerEndpoint<_idz08l1h.MinutesOfMeeting>(
    'mom',
    'createMom',
    {
      'title': title,
      'meetingDate': meetingDate,
      'organizerName': organizerName,
      'attendeeNames': attendeeNames,
      'agenda': agenda,
      'discussionPoints': discussionPoints,
      'decisions': decisions,
      'actionItems': actionItems,
    },
  );

  /// List all Minutes of Meeting
  _ida.Future<List<_idz08l1h.MinutesOfMeeting>> listMoms() =>
      caller.callServerEndpoint<List<_idz08l1h.MinutesOfMeeting>>(
        'mom',
        'listMoms',
        {},
      );

  /// Get MoM by ID
  _ida.Future<_idz08l1h.MinutesOfMeeting?> getMomDetail(int momId) =>
      caller.callServerEndpoint<_idz08l1h.MinutesOfMeeting?>(
        'mom',
        'getMomDetail',
        {'momId': momId},
      );
}

/// {@category Endpoint}
class EndpointPoints extends _isc.EndpointRef {
  EndpointPoints(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'points';

  /// Validates QR scan, confirms attendance, and awards points
  _ida.Future<Map<String, dynamic>> checkInWithQrToken({
    required int eventId,
    required String qrToken,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'points',
    'checkInWithQrToken',
    {
      'eventId': eventId,
      'qrToken': qrToken,
    },
  );

  /// Get student total points & streak
  _ida.Future<Map<String, int>> getMyPointsAndStreak() =>
      caller.callServerEndpoint<Map<String, int>>(
        'points',
        'getMyPointsAndStreak',
        {},
      );

  /// List reward perks available for redemption
  _ida.Future<List<_i04nrlxs.RewardPerk>> listRewards() =>
      caller.callServerEndpoint<List<_i04nrlxs.RewardPerk>>(
        'points',
        'listRewards',
        {},
      );

  /// Admin: Create reward perk
  _ida.Future<_i04nrlxs.RewardPerk> addRewardPerk({
    required String title,
    required String category,
    required String description,
    required int costPoints,
    required int stockRemaining,
  }) => caller.callServerEndpoint<_i04nrlxs.RewardPerk>(
    'points',
    'addRewardPerk',
    {
      'title': title,
      'category': category,
      'description': description,
      'costPoints': costPoints,
      'stockRemaining': stockRemaining,
    },
  );

  /// Redeem reward perk
  _ida.Future<bool> redeemReward(int perkId) => caller.callServerEndpoint<bool>(
    'points',
    'redeemReward',
    {'perkId': perkId},
  );
}

/// {@category Endpoint}
class EndpointQuiz extends _isc.EndpointRef {
  EndpointQuiz(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'quiz';

  /// Returns questions for a subject WITHOUT answer keys (authoritative, cheat-proof).
  _ida.Future<List<_iipzebr3.QuizQuestionView>> getQuestionsForSubject(
    String subject, {
    required int limit,
  }) => caller.callServerEndpoint<List<_iipzebr3.QuizQuestionView>>(
    'quiz',
    'getQuestionsForSubject',
    {
      'subject': subject,
      'limit': limit,
    },
  );

  /// Evaluates quiz answers securely on the server and persists the attempt.
  /// Idempotent: resubmitting with the same attemptId returns existing results
  /// without re-scoring or double-posting to the leaderboard.
  /// Legitimate retakes with new attemptIds are cleanly tracked with isRetake=true.
  _ida.Future<_iy42s5tm.QuizResultSummary> submitQuiz(
    _ipj905dc.QuizSubmission submission,
  ) => caller.callServerEndpoint<_iy42s5tm.QuizResultSummary>(
    'quiz',
    'submitQuiz',
    {'submission': submission},
  );

  /// Retrieves past attempts for the current user.
  _ida.Future<List<_i395nlzx.QuizAttempt>> getMyAttempts({String? subject}) =>
      caller.callServerEndpoint<List<_i395nlzx.QuizAttempt>>(
        'quiz',
        'getMyAttempts',
        {'subject': subject},
      );
}

/// {@category Endpoint}
class EndpointSearch extends _isc.EndpointRef {
  EndpointSearch(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'search';

  /// Bounded global campus search across events, study buddies, and public profiles.
  _ida.Future<_irna5qn8.SearchResponse> search(
    String query, {
    required int limit,
  }) => caller.callServerEndpoint<_irna5qn8.SearchResponse>(
    'search',
    'search',
    {
      'query': query,
      'limit': limit,
    },
  );

  /// Submits a contact or support message.
  _ida.Future<bool> submitContact({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) => caller.callServerEndpoint<bool>(
    'search',
    'submitContact',
    {
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
    },
  );
}

/// {@category Endpoint}
class EndpointSeed extends _isc.EndpointRef {
  EndpointSeed(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'seed';

  /// Seeds initial campus events and quiz questions if they are not already populated.
  _ida.Future<bool> seedData() => caller.callServerEndpoint<bool>(
    'seed',
    'seedData',
    {},
  );
}

/// {@category Endpoint}
class EndpointStudent extends _isc.EndpointRef {
  EndpointStudent(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'student';

  /// 1-click instant demo login for Aarav Sharma (CSE Year 3)
  _ida.Future<_iacc.AuthSuccess> loginDemo() =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'student',
        'loginDemo',
        {},
      );

  /// Registers a new student and signs them in directly
  _ida.Future<_iacc.AuthSuccess> registerStudent({
    required String fullName,
    required String email,
    required String password,
    required String branch,
    required int academicYear,
    required String hostelOrArea,
    String? bio,
    required List<String> subjectInterests,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'student',
    'registerStudent',
    {
      'fullName': fullName,
      'email': email,
      'password': password,
      'branch': branch,
      'academicYear': academicYear,
      'hostelOrArea': hostelOrArea,
      'bio': bio,
      'subjectInterests': subjectInterests,
    },
  );

  /// Returns the profile of the currently authenticated student.
  _ida.Future<_i66wptcz.StudentProfile?> getProfile() =>
      caller.callServerEndpoint<_i66wptcz.StudentProfile?>(
        'student',
        'getProfile',
        {},
      );

  /// Creates or updates the profile for the currently authenticated student.
  _ida.Future<_i66wptcz.StudentProfile> updateProfile({
    required String fullName,
    String? email,
    required String branch,
    required int academicYear,
    required String hostelOrArea,
    String? bio,
    required List<String> subjectInterests,
  }) => caller.callServerEndpoint<_i66wptcz.StudentProfile>(
    'student',
    'updateProfile',
    {
      'fullName': fullName,
      'email': email,
      'branch': branch,
      'academicYear': academicYear,
      'hostelOrArea': hostelOrArea,
      'bio': bio,
      'subjectInterests': subjectInterests,
    },
  );

  /// Public student profile for matching and discovery (excludes email/private details).
  _ida.Future<_i66wptcz.StudentProfile?> getPublicProfile(
    _isc.UuidValue authUserId,
  ) => caller.callServerEndpoint<_i66wptcz.StudentProfile?>(
    'student',
    'getPublicProfile',
    {'authUserId': authUserId},
  );

  /// Discovers student study partners with deterministic compatibility matching.
  _ida.Future<List<_i66wptcz.StudentProfile>> discoverStudents({
    String? branch,
    int? academicYear,
    String? subject,
    String? hostelOrArea,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i66wptcz.StudentProfile>>(
    'student',
    'discoverStudents',
    {
      'branch': branch,
      'academicYear': academicYear,
      'subject': subject,
      'hostelOrArea': hostelOrArea,
      'limit': limit,
      'offset': offset,
    },
  );
}

/// {@category Endpoint}
class EndpointStudyRequest extends _isc.EndpointRef {
  EndpointStudyRequest(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'studyRequest';

  /// Sends a study match request to another student.
  _ida.Future<_i18m6utc.StudyRequest> sendRequest({
    required _isc.UuidValue recipientAuthUserId,
    required String subject,
    required String message,
    required String urgency,
  }) => caller.callServerEndpoint<_i18m6utc.StudyRequest>(
    'studyRequest',
    'sendRequest',
    {
      'recipientAuthUserId': recipientAuthUserId,
      'subject': subject,
      'message': message,
      'urgency': urgency,
    },
  );

  /// Retrieves all study requests received by the current student.
  _ida.Future<List<_i18m6utc.StudyRequest>> getMyIncomingRequests() =>
      caller.callServerEndpoint<List<_i18m6utc.StudyRequest>>(
        'studyRequest',
        'getMyIncomingRequests',
        {},
      );

  /// Retrieves all study requests sent by the current student.
  _ida.Future<List<_i18m6utc.StudyRequest>> getMyOutgoingRequests() =>
      caller.callServerEndpoint<List<_i18m6utc.StudyRequest>>(
        'studyRequest',
        'getMyOutgoingRequests',
        {},
      );

  /// Updates status of a study request (accepted, declined, cancelled).
  _ida.Future<_i18m6utc.StudyRequest> updateRequestStatus({
    required int requestId,
    required String newStatus,
  }) => caller.callServerEndpoint<_i18m6utc.StudyRequest>(
    'studyRequest',
    'updateRequestStatus',
    {
      'requestId': requestId,
      'newStatus': newStatus,
    },
  );
}

/// {@category Endpoint}
class EndpointTimetable extends _isc.EndpointRef {
  EndpointTimetable(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'timetable';

  /// Admin only: Create or update class timetable for a section
  _ida.Future<_ij8cgkiw.SectionTimetable> addSectionTimetable({
    required String branch,
    required int academicYear,
    required int semester,
    required String section,
    required String dayOfWeek,
    required String startTime,
    required String endTime,
    required String subject,
    required String room,
  }) => caller.callServerEndpoint<_ij8cgkiw.SectionTimetable>(
    'timetable',
    'addSectionTimetable',
    {
      'branch': branch,
      'academicYear': academicYear,
      'semester': semester,
      'section': section,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'subject': subject,
      'room': room,
    },
  );

  /// Get class timetable for specific section
  _ida.Future<List<_ij8cgkiw.SectionTimetable>> getSectionTimetable({
    required String branch,
    required int semester,
    required String section,
  }) => caller.callServerEndpoint<List<_ij8cgkiw.SectionTimetable>>(
    'timetable',
    'getSectionTimetable',
    {
      'branch': branch,
      'semester': semester,
      'section': section,
    },
  );

  /// Student: Get my saved free slots
  _ida.Future<List<_iuvh50w9.StudentFreeSlot>> getMyFreeSlots() =>
      caller.callServerEndpoint<List<_iuvh50w9.StudentFreeSlot>>(
        'timetable',
        'getMyFreeSlots',
        {},
      );

  /// Student: Toggle or set free slot status
  _ida.Future<_iuvh50w9.StudentFreeSlot> updateFreeSlot({
    required String dayOfWeek,
    required String slotLabel,
    required String startTime,
    required String endTime,
    required bool isFree,
  }) => caller.callServerEndpoint<_iuvh50w9.StudentFreeSlot>(
    'timetable',
    'updateFreeSlot',
    {
      'dayOfWeek': dayOfWeek,
      'slotLabel': slotLabel,
      'startTime': startTime,
      'endTime': endTime,
      'isFree': isFree,
    },
  );

  /// Timetable-aware study buddy matching upgrade
  /// Combines common subjects + overlapping free time slots + location
  _ida.Future<List<Map<String, dynamic>>> findTimetableStudyMatches() =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'timetable',
        'findTimetableStudyMatches',
        {},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_itza125m.Greeting> hello(String name) =>
      caller.callServerEndpoint<_itza125m.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    academicResource = EndpointAcademicResource(this);
    admin = EndpointAdmin(this);
    attendance = EndpointAttendance(this);
    certificate = EndpointCertificate(this);
    chat = EndpointChat(this);
    event = EndpointEvent(this);
    leaderboard = EndpointLeaderboard(this);
    mom = EndpointMom(this);
    points = EndpointPoints(this);
    quiz = EndpointQuiz(this);
    search = EndpointSearch(this);
    seed = EndpointSeed(this);
    student = EndpointStudent(this);
    studyRequest = EndpointStudyRequest(this);
    timetable = EndpointTimetable(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAcademicResource academicResource;

  late final EndpointAdmin admin;

  late final EndpointAttendance attendance;

  late final EndpointCertificate certificate;

  late final EndpointChat chat;

  late final EndpointEvent event;

  late final EndpointLeaderboard leaderboard;

  late final EndpointMom mom;

  late final EndpointPoints points;

  late final EndpointQuiz quiz;

  late final EndpointSearch search;

  late final EndpointSeed seed;

  late final EndpointStudent student;

  late final EndpointStudyRequest studyRequest;

  late final EndpointTimetable timetable;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'academicResource': academicResource,
    'admin': admin,
    'attendance': attendance,
    'certificate': certificate,
    'chat': chat,
    'event': event,
    'leaderboard': leaderboard,
    'mom': mom,
    'points': points,
    'quiz': quiz,
    'search': search,
    'seed': seed,
    'student': student,
    'studyRequest': studyRequest,
    'timetable': timetable,
    'greeting': greeting,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
