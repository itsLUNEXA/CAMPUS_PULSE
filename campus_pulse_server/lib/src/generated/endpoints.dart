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
import 'dart:typed_data' as _idt;
import 'package:campus_pulse_server/src/generated/quiz_submission.dart'
    as _ikt4w0rg;
import 'package:campus_pulse_server/src/generated/reward_perk.dart'
    as _i5apij9o;
import 'package:campus_pulse_server/src/generated/section_timetable.dart'
    as _i6o9odyo;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/academic_resource_endpoint.dart' as _ipmkipkb;
import '../endpoints/admin_endpoint.dart' as _i5t1w2d2;
import '../endpoints/attendance_endpoint.dart' as _ieghzlx7;
import '../endpoints/certificate_endpoint.dart' as _ixxjh8q7;
import '../endpoints/chat_endpoint.dart' as _ihc7hrsa;
import '../endpoints/club_endpoint.dart' as _i2t636zb;
import '../endpoints/event_endpoint.dart' as _icw8lb6p;
import '../endpoints/interview_prep_endpoint.dart' as _ik7tibzk;
import '../endpoints/leaderboard_endpoint.dart' as _iy80ldha;
import '../endpoints/library_endpoint.dart' as _iqlmnpik;
import '../endpoints/mom_endpoint.dart' as _ifiqiuci;
import '../endpoints/notification_endpoint.dart' as _ihb11yhk;
import '../endpoints/points_endpoint.dart' as _isfdgr65;
import '../endpoints/quiz_endpoint.dart' as _i7z0uw2a;
import '../endpoints/search_endpoint.dart' as _ipmmezh5;
import '../endpoints/seed_endpoint.dart' as _i8h1zywb;
import '../endpoints/student_endpoint.dart' as _if6txhyr;
import '../endpoints/study_request_endpoint.dart' as _i2439pix;
import '../endpoints/timetable_endpoint.dart' as _in4fhk5u;
import '../greetings/greeting_endpoint.dart' as _il624ik7;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'academicResource': _ipmkipkb.AcademicResourceEndpoint()
        ..initialize(
          server,
          'academicResource',
          null,
        ),
      'admin': _i5t1w2d2.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'attendance': _ieghzlx7.AttendanceEndpoint()
        ..initialize(
          server,
          'attendance',
          null,
        ),
      'certificate': _ixxjh8q7.CertificateEndpoint()
        ..initialize(
          server,
          'certificate',
          null,
        ),
      'chat': _ihc7hrsa.ChatEndpoint()
        ..initialize(
          server,
          'chat',
          null,
        ),
      'club': _i2t636zb.ClubEndpoint()
        ..initialize(
          server,
          'club',
          null,
        ),
      'event': _icw8lb6p.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'interviewPrep': _ik7tibzk.InterviewPrepEndpoint()
        ..initialize(
          server,
          'interviewPrep',
          null,
        ),
      'leaderboard': _iy80ldha.LeaderboardEndpoint()
        ..initialize(
          server,
          'leaderboard',
          null,
        ),
      'library': _iqlmnpik.LibraryEndpoint()
        ..initialize(
          server,
          'library',
          null,
        ),
      'mom': _ifiqiuci.MomEndpoint()
        ..initialize(
          server,
          'mom',
          null,
        ),
      'notification': _ihb11yhk.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'points': _isfdgr65.PointsEndpoint()
        ..initialize(
          server,
          'points',
          null,
        ),
      'quiz': _i7z0uw2a.QuizEndpoint()
        ..initialize(
          server,
          'quiz',
          null,
        ),
      'search': _ipmmezh5.SearchEndpoint()
        ..initialize(
          server,
          'search',
          null,
        ),
      'seed': _i8h1zywb.SeedEndpoint()
        ..initialize(
          server,
          'seed',
          null,
        ),
      'student': _if6txhyr.StudentEndpoint()
        ..initialize(
          server,
          'student',
          null,
        ),
      'studyRequest': _i2439pix.StudyRequestEndpoint()
        ..initialize(
          server,
          'studyRequest',
          null,
        ),
      'timetable': _in4fhk5u.TimetableEndpoint()
        ..initialize(
          server,
          'timetable',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['academicResource'] = _is.EndpointConnector(
      name: 'academicResource',
      endpoint: endpoints['academicResource']!,
      methodConnectors: {
        'uploadResource': _is.MethodConnector(
          name: 'uploadResource',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'university': _is.ParameterDescription(
              name: 'university',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'course': _is.ParameterDescription(
              name: 'course',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'academicYear': _is.ParameterDescription(
              name: 'academicYear',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'semester': _is.ParameterDescription(
              name: 'semester',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'subjectCode': _is.ParameterDescription(
              name: 'subjectCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'subjectName': _is.ParameterDescription(
              name: 'subjectName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'unitNumber': _is.ParameterDescription(
              name: 'unitNumber',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'resourceType': _is.ParameterDescription(
              name: 'resourceType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fileUrl': _is.ParameterDescription(
              name: 'fileUrl',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fileSize': _is.ParameterDescription(
              name: 'fileSize',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'uploaderName': _is.ParameterDescription(
              name: 'uploaderName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['academicResource']
                          as _ipmkipkb.AcademicResourceEndpoint)
                      .uploadResource(
                        session,
                        title: params['title'],
                        description: params['description'],
                        university: params['university'],
                        course: params['course'],
                        branch: params['branch'],
                        academicYear: params['academicYear'],
                        semester: params['semester'],
                        subjectCode: params['subjectCode'],
                        subjectName: params['subjectName'],
                        unitNumber: params['unitNumber'],
                        resourceType: params['resourceType'],
                        fileUrl: params['fileUrl'],
                        fileSize: params['fileSize'],
                        uploaderName: params['uploaderName'],
                      ),
        ),
        'filterResources': _is.MethodConnector(
          name: 'filterResources',
          params: {
            'university': _is.ParameterDescription(
              name: 'university',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'course': _is.ParameterDescription(
              name: 'course',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'semester': _is.ParameterDescription(
              name: 'semester',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'subjectCode': _is.ParameterDescription(
              name: 'subjectCode',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'unitNumber': _is.ParameterDescription(
              name: 'unitNumber',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'resourceType': _is.ParameterDescription(
              name: 'resourceType',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'onlyApproved': _is.ParameterDescription(
              name: 'onlyApproved',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['academicResource']
                          as _ipmkipkb.AcademicResourceEndpoint)
                      .filterResources(
                        session,
                        university: params['university'],
                        course: params['course'],
                        branch: params['branch'],
                        semester: params['semester'],
                        subjectCode: params['subjectCode'],
                        unitNumber: params['unitNumber'],
                        resourceType: params['resourceType'],
                        onlyApproved: params['onlyApproved'],
                      ),
        ),
        'listPendingResources': _is.MethodConnector(
          name: 'listPendingResources',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['academicResource']
                          as _ipmkipkb.AcademicResourceEndpoint)
                      .listPendingResources(session),
        ),
        'setApprovalStatus': _is.MethodConnector(
          name: 'setApprovalStatus',
          params: {
            'resourceId': _is.ParameterDescription(
              name: 'resourceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'approved': _is.ParameterDescription(
              name: 'approved',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['academicResource']
                          as _ipmkipkb.AcademicResourceEndpoint)
                      .setApprovalStatus(
                        session,
                        params['resourceId'],
                        params['approved'],
                        reason: params['reason'],
                      ),
        ),
        'recordDownload': _is.MethodConnector(
          name: 'recordDownload',
          params: {
            'resourceId': _is.ParameterDescription(
              name: 'resourceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['academicResource']
                          as _ipmkipkb.AcademicResourceEndpoint)
                      .recordDownload(
                        session,
                        params['resourceId'],
                      ),
        ),
        'getSubjectSyllabus': _is.MethodConnector(
          name: 'getSubjectSyllabus',
          params: {
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'semester': _is.ParameterDescription(
              name: 'semester',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'subjectCode': _is.ParameterDescription(
              name: 'subjectCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['academicResource']
                          as _ipmkipkb.AcademicResourceEndpoint)
                      .getSubjectSyllabus(
                        session,
                        branch: params['branch'],
                        semester: params['semester'],
                        subjectCode: params['subjectCode'],
                      ),
        ),
        'uploadPdf': _is.MethodConnector(
          name: 'uploadPdf',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'university': _is.ParameterDescription(
              name: 'university',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'course': _is.ParameterDescription(
              name: 'course',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'academicYear': _is.ParameterDescription(
              name: 'academicYear',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'semester': _is.ParameterDescription(
              name: 'semester',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'subjectCode': _is.ParameterDescription(
              name: 'subjectCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'subjectName': _is.ParameterDescription(
              name: 'subjectName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'unitNumber': _is.ParameterDescription(
              name: 'unitNumber',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'resourceType': _is.ParameterDescription(
              name: 'resourceType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'filename': _is.ParameterDescription(
              name: 'filename',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fileBytes': _is.ParameterDescription(
              name: 'fileBytes',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['academicResource']
                          as _ipmkipkb.AcademicResourceEndpoint)
                      .uploadPdf(
                        session,
                        title: params['title'],
                        description: params['description'],
                        university: params['university'],
                        course: params['course'],
                        branch: params['branch'],
                        academicYear: params['academicYear'],
                        semester: params['semester'],
                        subjectCode: params['subjectCode'],
                        subjectName: params['subjectName'],
                        unitNumber: params['unitNumber'],
                        resourceType: params['resourceType'],
                        filename: params['filename'],
                        fileBytes: params['fileBytes'],
                      ),
        ),
        'downloadPdf': _is.MethodConnector(
          name: 'downloadPdf',
          params: {
            'resourceId': _is.ParameterDescription(
              name: 'resourceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['academicResource']
                          as _ipmkipkb.AcademicResourceEndpoint)
                      .downloadPdf(
                        session,
                        params['resourceId'],
                      ),
        ),
        'isPdfAvailable': _is.MethodConnector(
          name: 'isPdfAvailable',
          params: {
            'resourceId': _is.ParameterDescription(
              name: 'resourceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['academicResource']
                          as _ipmkipkb.AcademicResourceEndpoint)
                      .isPdfAvailable(
                        session,
                        params['resourceId'],
                      ),
        ),
      },
    );
    connectors['admin'] = _is.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'loginAdmin': _is.MethodConnector(
          name: 'loginAdmin',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).loginAdmin(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'loginMasterAdminDemo': _is.MethodConnector(
          name: 'loginMasterAdminDemo',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5t1w2d2.AdminEndpoint)
                  .loginMasterAdminDemo(session),
        ),
        'verifyAdminSession': _is.MethodConnector(
          name: 'verifyAdminSession',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5t1w2d2.AdminEndpoint)
                  .verifyAdminSession(session),
        ),
        'getDashboardOverview': _is.MethodConnector(
          name: 'getDashboardOverview',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5t1w2d2.AdminEndpoint)
                  .getDashboardOverview(session),
        ),
        'assignRole': _is.MethodConnector(
          name: 'assignRole',
          params: {
            'targetUserId': _is.ParameterDescription(
              name: 'targetUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'scope': _is.ParameterDescription(
              name: 'scope',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).assignRole(
                    session,
                    params['targetUserId'],
                    params['role'],
                    scope: params['scope'],
                  ),
        ),
        'revokeRole': _is.MethodConnector(
          name: 'revokeRole',
          params: {
            'targetUserId': _is.ParameterDescription(
              name: 'targetUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).revokeRole(
                    session,
                    params['targetUserId'],
                    params['role'],
                  ),
        ),
        'getUserRoles': _is.MethodConnector(
          name: 'getUserRoles',
          params: {
            'targetUserId': _is.ParameterDescription(
              name: 'targetUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).getUserRoles(
                    session,
                    params['targetUserId'],
                  ),
        ),
        'listStudents': _is.MethodConnector(
          name: 'listStudents',
          params: {
            'search': _is.ParameterDescription(
              name: 'search',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).listStudents(
                    session,
                    search: params['search'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getStudentCount': _is.MethodConnector(
          name: 'getStudentCount',
          params: {
            'search': _is.ParameterDescription(
              name: 'search',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5t1w2d2.AdminEndpoint)
                  .getStudentCount(
                    session,
                    search: params['search'],
                  ),
        ),
        'getMyRoles': _is.MethodConnector(
          name: 'getMyRoles',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5t1w2d2.AdminEndpoint)
                  .getMyRoles(session),
        ),
        'listAuditLogs': _is.MethodConnector(
          name: 'listAuditLogs',
          params: {
            'search': _is.ParameterDescription(
              name: 'search',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'actionType': _is.ParameterDescription(
              name: 'actionType',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).listAuditLogs(
                    session,
                    search: params['search'],
                    actionType: params['actionType'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
      },
    );
    connectors['attendance'] = _is.EndpointConnector(
      name: 'attendance',
      endpoint: endpoints['attendance']!,
      methodConnectors: {
        'markAttendance': _is.MethodConnector(
          name: 'markAttendance',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'studentAuthUserId': _is.ParameterDescription(
              name: 'studentAuthUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'studentName': _is.ParameterDescription(
              name: 'studentName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'checkInCode': _is.ParameterDescription(
              name: 'checkInCode',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['attendance'] as _ieghzlx7.AttendanceEndpoint)
                      .markAttendance(
                        session,
                        eventId: params['eventId'],
                        studentAuthUserId: params['studentAuthUserId'],
                        studentName: params['studentName'],
                        status: params['status'],
                        checkInCode: params['checkInCode'],
                        notes: params['notes'],
                      ),
        ),
        'checkInWithCode': _is.MethodConnector(
          name: 'checkInWithCode',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'enteredCode': _is.ParameterDescription(
              name: 'enteredCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'studentName': _is.ParameterDescription(
              name: 'studentName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['attendance'] as _ieghzlx7.AttendanceEndpoint)
                      .checkInWithCode(
                        session,
                        eventId: params['eventId'],
                        enteredCode: params['enteredCode'],
                        studentName: params['studentName'],
                      ),
        ),
        'getEventAttendance': _is.MethodConnector(
          name: 'getEventAttendance',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['attendance'] as _ieghzlx7.AttendanceEndpoint)
                      .getEventAttendance(
                        session,
                        params['eventId'],
                      ),
        ),
        'getMyAttendanceHistory': _is.MethodConnector(
          name: 'getMyAttendanceHistory',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['attendance'] as _ieghzlx7.AttendanceEndpoint)
                      .getMyAttendanceHistory(session),
        ),
      },
    );
    connectors['certificate'] = _is.EndpointConnector(
      name: 'certificate',
      endpoint: endpoints['certificate']!,
      methodConnectors: {
        'issueCertificate': _is.MethodConnector(
          name: 'issueCertificate',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'studentAuthUserId': _is.ParameterDescription(
              name: 'studentAuthUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'studentName': _is.ParameterDescription(
              name: 'studentName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'signatureTitle': _is.ParameterDescription(
              name: 'signatureTitle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['certificate'] as _ixxjh8q7.CertificateEndpoint)
                      .issueCertificate(
                        session,
                        eventId: params['eventId'],
                        studentAuthUserId: params['studentAuthUserId'],
                        studentName: params['studentName'],
                        signatureTitle: params['signatureTitle'],
                      ),
        ),
        'verifyCertificate': _is.MethodConnector(
          name: 'verifyCertificate',
          params: {
            'certificateId': _is.ParameterDescription(
              name: 'certificateId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['certificate'] as _ixxjh8q7.CertificateEndpoint)
                      .verifyCertificate(
                        session,
                        params['certificateId'],
                      ),
        ),
        'getMyCertificates': _is.MethodConnector(
          name: 'getMyCertificates',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['certificate'] as _ixxjh8q7.CertificateEndpoint)
                      .getMyCertificates(session),
        ),
        'revokeCertificate': _is.MethodConnector(
          name: 'revokeCertificate',
          params: {
            'certificateId': _is.ParameterDescription(
              name: 'certificateId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['certificate'] as _ixxjh8q7.CertificateEndpoint)
                      .revokeCertificate(
                        session,
                        params['certificateId'],
                        params['reason'],
                      ),
        ),
      },
    );
    connectors['chat'] = _is.EndpointConnector(
      name: 'chat',
      endpoint: endpoints['chat']!,
      methodConnectors: {
        'getOrCreateRoom': _is.MethodConnector(
          name: 'getOrCreateRoom',
          params: {
            'roomType': _is.ParameterDescription(
              name: 'roomType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'referenceId': _is.ParameterDescription(
              name: 'referenceId',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'participantIds': _is.ParameterDescription(
              name: 'participantIds',
              type: _is.getType<List<_is.UuidValue>>(),
              nullable: false,
            ),
            'allowedBranch': _is.ParameterDescription(
              name: 'allowedBranch',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'allowedAcademicYear': _is.ParameterDescription(
              name: 'allowedAcademicYear',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _ihc7hrsa.ChatEndpoint).getOrCreateRoom(
                    session,
                    roomType: params['roomType'],
                    referenceId: params['referenceId'],
                    name: params['name'],
                    participantIds: params['participantIds'],
                    allowedBranch: params['allowedBranch'],
                    allowedAcademicYear: params['allowedAcademicYear'],
                  ),
        ),
        'sendMessage': _is.MethodConnector(
          name: 'sendMessage',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'content': _is.ParameterDescription(
              name: 'content',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'attachmentUrl': _is.ParameterDescription(
              name: 'attachmentUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'attachmentType': _is.ParameterDescription(
              name: 'attachmentType',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _ihc7hrsa.ChatEndpoint).sendMessage(
                    session,
                    roomId: params['roomId'],
                    content: params['content'],
                    attachmentUrl: params['attachmentUrl'],
                    attachmentType: params['attachmentType'],
                  ),
        ),
        'getRoomMessages': _is.MethodConnector(
          name: 'getRoomMessages',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _ihc7hrsa.ChatEndpoint).getRoomMessages(
                    session,
                    params['roomId'],
                    limit: params['limit'],
                  ),
        ),
        'reportMessage': _is.MethodConnector(
          name: 'reportMessage',
          params: {
            'messageId': _is.ParameterDescription(
              name: 'messageId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _ihc7hrsa.ChatEndpoint).reportMessage(
                    session,
                    messageId: params['messageId'],
                    reason: params['reason'],
                  ),
        ),
        'listChatReports': _is.MethodConnector(
          name: 'listChatReports',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _ihc7hrsa.ChatEndpoint).listChatReports(
                    session,
                    status: params['status'],
                  ),
        ),
        'resolveChatReport': _is.MethodConnector(
          name: 'resolveChatReport',
          params: {
            'reportId': _is.ParameterDescription(
              name: 'reportId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'action': _is.ParameterDescription(
              name: 'action',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .resolveChatReport(
                    session,
                    reportId: params['reportId'],
                    action: params['action'],
                  ),
        ),
        'listMyRooms': _is.MethodConnector(
          name: 'listMyRooms',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .listMyRooms(session),
        ),
        'createCustomRoom': _is.MethodConnector(
          name: 'createCustomRoom',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'topic': _is.ParameterDescription(
              name: 'topic',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'allowedBranch': _is.ParameterDescription(
              name: 'allowedBranch',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'allowedAcademicYear': _is.ParameterDescription(
              name: 'allowedAcademicYear',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .createCustomRoom(
                    session,
                    name: params['name'],
                    description: params['description'],
                    topic: params['topic'],
                    allowedBranch: params['allowedBranch'],
                    allowedAcademicYear: params['allowedAcademicYear'],
                  ),
        ),
        'joinRoom': _is.MethodConnector(
          name: 'joinRoom',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint).joinRoom(
                session,
                params['roomId'],
              ),
        ),
        'listAllAccessibleRooms': _is.MethodConnector(
          name: 'listAllAccessibleRooms',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .listAllAccessibleRooms(session),
        ),
        'streamChatMessages': _is.MethodStreamConnector(
          name: 'streamChatMessages',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['chat'] as _ihc7hrsa.ChatEndpoint)
                  .streamChatMessages(
                    session,
                    params['roomId'],
                  ),
        ),
      },
    );
    connectors['club'] = _is.EndpointConnector(
      name: 'club',
      endpoint: endpoints['club']!,
      methodConnectors: {
        'listClubs': _is.MethodConnector(
          name: 'listClubs',
          params: {
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['club'] as _i2t636zb.ClubEndpoint).listClubs(
                    session,
                    category: params['category'],
                  ),
        ),
        'getClub': _is.MethodConnector(
          name: 'getClub',
          params: {
            'clubId': _is.ParameterDescription(
              name: 'clubId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['club'] as _i2t636zb.ClubEndpoint).getClub(
                session,
                params['clubId'],
              ),
        ),
        'submitClubQuery': _is.MethodConnector(
          name: 'submitClubQuery',
          params: {
            'clubId': _is.ParameterDescription(
              name: 'clubId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'targetTeam': _is.ParameterDescription(
              name: 'targetTeam',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['club'] as _i2t636zb.ClubEndpoint).submitClubQuery(
                    session,
                    clubId: params['clubId'],
                    targetTeam: params['targetTeam'],
                    category: params['category'],
                    subject: params['subject'],
                    message: params['message'],
                  ),
        ),
        'getMyClubQueries': _is.MethodConnector(
          name: 'getMyClubQueries',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['club'] as _i2t636zb.ClubEndpoint)
                  .getMyClubQueries(session),
        ),
        'getClubQueries': _is.MethodConnector(
          name: 'getClubQueries',
          params: {
            'clubId': _is.ParameterDescription(
              name: 'clubId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'targetTeam': _is.ParameterDescription(
              name: 'targetTeam',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['club'] as _i2t636zb.ClubEndpoint).getClubQueries(
                    session,
                    clubId: params['clubId'],
                    targetTeam: params['targetTeam'],
                    status: params['status'],
                  ),
        ),
        'respondToClubQuery': _is.MethodConnector(
          name: 'respondToClubQuery',
          params: {
            'queryId': _is.ParameterDescription(
              name: 'queryId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'responseMessage': _is.ParameterDescription(
              name: 'responseMessage',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'responderName': _is.ParameterDescription(
              name: 'responderName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['club'] as _i2t636zb.ClubEndpoint)
                  .respondToClubQuery(
                    session,
                    queryId: params['queryId'],
                    responseMessage: params['responseMessage'],
                    responderName: params['responderName'],
                  ),
        ),
      },
    );
    connectors['event'] = _is.EndpointConnector(
      name: 'event',
      endpoint: endpoints['event']!,
      methodConnectors: {
        'listEvents': _is.MethodConnector(
          name: 'listEvents',
          params: {
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'approvalStatus': _is.ParameterDescription(
              name: 'approvalStatus',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).listEvents(
                    session,
                    category: params['category'],
                    approvalStatus: params['approvalStatus'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getEvent': _is.MethodConnector(
          name: 'getEvent',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).getEvent(
                    session,
                    params['id'],
                  ),
        ),
        'getRecommendedEvents': _is.MethodConnector(
          name: 'getRecommendedEvents',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .getRecommendedEvents(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'createEvent': _is.MethodConnector(
          name: 'createEvent',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'startTime': _is.ParameterDescription(
              name: 'startTime',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'endTime': _is.ParameterDescription(
              name: 'endTime',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'venue': _is.ParameterDescription(
              name: 'venue',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'bannerUrl': _is.ParameterDescription(
              name: 'bannerUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'registrationDeadline': _is.ParameterDescription(
              name: 'registrationDeadline',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'isTeamEvent': _is.ParameterDescription(
              name: 'isTeamEvent',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'minTeamSize': _is.ParameterDescription(
              name: 'minTeamSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'maxTeamSize': _is.ParameterDescription(
              name: 'maxTeamSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'approvalStatus': _is.ParameterDescription(
              name: 'approvalStatus',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).createEvent(
                    session,
                    title: params['title'],
                    description: params['description'],
                    category: params['category'],
                    startTime: params['startTime'],
                    endTime: params['endTime'],
                    venue: params['venue'],
                    bannerUrl: params['bannerUrl'],
                    registrationDeadline: params['registrationDeadline'],
                    isTeamEvent: params['isTeamEvent'],
                    minTeamSize: params['minTeamSize'],
                    maxTeamSize: params['maxTeamSize'],
                    approvalStatus: params['approvalStatus'],
                  ),
        ),
        'editEvent': _is.MethodConnector(
          name: 'editEvent',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'startTime': _is.ParameterDescription(
              name: 'startTime',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'endTime': _is.ParameterDescription(
              name: 'endTime',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'venue': _is.ParameterDescription(
              name: 'venue',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'bannerUrl': _is.ParameterDescription(
              name: 'bannerUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'registrationDeadline': _is.ParameterDescription(
              name: 'registrationDeadline',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'isTeamEvent': _is.ParameterDescription(
              name: 'isTeamEvent',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'minTeamSize': _is.ParameterDescription(
              name: 'minTeamSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'maxTeamSize': _is.ParameterDescription(
              name: 'maxTeamSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).editEvent(
                    session,
                    eventId: params['eventId'],
                    title: params['title'],
                    description: params['description'],
                    category: params['category'],
                    startTime: params['startTime'],
                    endTime: params['endTime'],
                    venue: params['venue'],
                    bannerUrl: params['bannerUrl'],
                    registrationDeadline: params['registrationDeadline'],
                    isTeamEvent: params['isTeamEvent'],
                    minTeamSize: params['minTeamSize'],
                    maxTeamSize: params['maxTeamSize'],
                  ),
        ),
        'reviewEvent': _is.MethodConnector(
          name: 'reviewEvent',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'decision': _is.ParameterDescription(
              name: 'decision',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'rejectionReason': _is.ParameterDescription(
              name: 'rejectionReason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).reviewEvent(
                    session,
                    eventId: params['eventId'],
                    decision: params['decision'],
                    rejectionReason: params['rejectionReason'],
                  ),
        ),
        'registerForEvent': _is.MethodConnector(
          name: 'registerForEvent',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'teamName': _is.ParameterDescription(
              name: 'teamName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'teamMemberNames': _is.ParameterDescription(
              name: 'teamMemberNames',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
            'teamMemberEmails': _is.ParameterDescription(
              name: 'teamMemberEmails',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .registerForEvent(
                    session,
                    params['eventId'],
                    teamName: params['teamName'],
                    teamMemberNames: params['teamMemberNames'],
                    teamMemberEmails: params['teamMemberEmails'],
                  ),
        ),
        'rsvpEvent': _is.MethodConnector(
          name: 'rsvpEvent',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).rsvpEvent(
                    session,
                    params['eventId'],
                  ),
        ),
        'cancelRegistration': _is.MethodConnector(
          name: 'cancelRegistration',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .cancelRegistration(
                    session,
                    params['eventId'],
                  ),
        ),
        'cancelRsvp': _is.MethodConnector(
          name: 'cancelRsvp',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).cancelRsvp(
                    session,
                    params['eventId'],
                  ),
        ),
        'hasUserRegistered': _is.MethodConnector(
          name: 'hasUserRegistered',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .hasUserRegistered(
                    session,
                    params['eventId'],
                  ),
        ),
        'hasUserRsvpd': _is.MethodConnector(
          name: 'hasUserRsvpd',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).hasUserRsvpd(
                    session,
                    params['eventId'],
                  ),
        ),
        'getMyRegisteredEventIds': _is.MethodConnector(
          name: 'getMyRegisteredEventIds',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .getMyRegisteredEventIds(session),
        ),
        'getMyRsvpdEventIds': _is.MethodConnector(
          name: 'getMyRsvpdEventIds',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .getMyRsvpdEventIds(session),
        ),
        'getMyOrganizerRegistrations': _is.MethodConnector(
          name: 'getMyOrganizerRegistrations',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .getMyOrganizerRegistrations(
                    session,
                    params['eventId'],
                  ),
        ),
        'getPendingEvents': _is.MethodConnector(
          name: 'getPendingEvents',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .getPendingEvents(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getPendingEventsCount': _is.MethodConnector(
          name: 'getPendingEventsCount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .getPendingEventsCount(session),
        ),
        'getMyEvents': _is.MethodConnector(
          name: 'getMyEvents',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).getMyEvents(
                    session,
                    status: params['status'],
                  ),
        ),
        'streamRsvpUpdates': _is.MethodStreamConnector(
          name: 'streamRsvpUpdates',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .streamRsvpUpdates(session),
        ),
      },
    );
    connectors['interviewPrep'] = _is.EndpointConnector(
      name: 'interviewPrep',
      endpoint: endpoints['interviewPrep']!,
      methodConnectors: {
        'listCompanies': _is.MethodConnector(
          name: 'listCompanies',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['interviewPrep']
                          as _ik7tibzk.InterviewPrepEndpoint)
                      .listCompanies(session),
        ),
        'listSeniorExperiences': _is.MethodConnector(
          name: 'listSeniorExperiences',
          params: {
            'companyName': _is.ParameterDescription(
              name: 'companyName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['interviewPrep']
                          as _ik7tibzk.InterviewPrepEndpoint)
                      .listSeniorExperiences(
                        session,
                        companyName: params['companyName'],
                      ),
        ),
        'requestMockInterview': _is.MethodConnector(
          name: 'requestMockInterview',
          params: {
            'targetCompany': _is.ParameterDescription(
              name: 'targetCompany',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'targetRole': _is.ParameterDescription(
              name: 'targetRole',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'mockRound': _is.ParameterDescription(
              name: 'mockRound',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'preferredDate': _is.ParameterDescription(
              name: 'preferredDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'resumeUrl': _is.ParameterDescription(
              name: 'resumeUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['interviewPrep']
                          as _ik7tibzk.InterviewPrepEndpoint)
                      .requestMockInterview(
                        session,
                        targetCompany: params['targetCompany'],
                        targetRole: params['targetRole'],
                        mockRound: params['mockRound'],
                        preferredDate: params['preferredDate'],
                        resumeUrl: params['resumeUrl'],
                        notes: params['notes'],
                      ),
        ),
        'getMyMockInterviewSlots': _is.MethodConnector(
          name: 'getMyMockInterviewSlots',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['interviewPrep']
                          as _ik7tibzk.InterviewPrepEndpoint)
                      .getMyMockInterviewSlots(session),
        ),
        'updateMockInterviewStatus': _is.MethodConnector(
          name: 'updateMockInterviewStatus',
          params: {
            'slotId': _is.ParameterDescription(
              name: 'slotId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'seniorMentorName': _is.ParameterDescription(
              name: 'seniorMentorName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'meetingLink': _is.ParameterDescription(
              name: 'meetingLink',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'feedbackNotes': _is.ParameterDescription(
              name: 'feedbackNotes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['interviewPrep']
                          as _ik7tibzk.InterviewPrepEndpoint)
                      .updateMockInterviewStatus(
                        session,
                        slotId: params['slotId'],
                        status: params['status'],
                        seniorMentorName: params['seniorMentorName'],
                        meetingLink: params['meetingLink'],
                        feedbackNotes: params['feedbackNotes'],
                      ),
        ),
      },
    );
    connectors['leaderboard'] = _is.EndpointConnector(
      name: 'leaderboard',
      endpoint: endpoints['leaderboard']!,
      methodConnectors: {
        'getLeaderboard': _is.MethodConnector(
          name: 'getLeaderboard',
          params: {
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'academicYear': _is.ParameterDescription(
              name: 'academicYear',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['leaderboard'] as _iy80ldha.LeaderboardEndpoint)
                      .getLeaderboard(
                        session,
                        subject: params['subject'],
                        branch: params['branch'],
                        academicYear: params['academicYear'],
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'getMyRank': _is.MethodConnector(
          name: 'getMyRank',
          params: {
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'academicYear': _is.ParameterDescription(
              name: 'academicYear',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['leaderboard'] as _iy80ldha.LeaderboardEndpoint)
                      .getMyRank(
                        session,
                        subject: params['subject'],
                        branch: params['branch'],
                        academicYear: params['academicYear'],
                      ),
        ),
        'streamLeaderboardUpdates': _is.MethodStreamConnector(
          name: 'streamLeaderboardUpdates',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['leaderboard'] as _iy80ldha.LeaderboardEndpoint)
                  .streamLeaderboardUpdates(session),
        ),
      },
    );
    connectors['library'] = _is.EndpointConnector(
      name: 'library',
      endpoint: endpoints['library']!,
      methodConnectors: {
        'getStaffProfile': _is.MethodConnector(
          name: 'getStaffProfile',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .getStaffProfile(session),
        ),
        'getAvailableCounters': _is.MethodConnector(
          name: 'getAvailableCounters',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .getAvailableCounters(session),
        ),
        'getLibraryRequests': _is.MethodConnector(
          name: 'getLibraryRequests',
          params: {
            'counterName': _is.ParameterDescription(
              name: 'counterName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'statusFilter': _is.ParameterDescription(
              name: 'statusFilter',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'searchQuery': _is.ParameterDescription(
              name: 'searchQuery',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .getLibraryRequests(
                    session,
                    counterName: params['counterName'],
                    statusFilter: params['statusFilter'],
                    searchQuery: params['searchQuery'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'updateRequestStatus': _is.MethodConnector(
          name: 'updateRequestStatus',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'targetStatus': _is.ParameterDescription(
              name: 'targetStatus',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .updateRequestStatus(
                    session,
                    requestId: params['requestId'],
                    targetStatus: params['targetStatus'],
                    reason: params['reason'],
                  ),
        ),
        'verifyCollection': _is.MethodConnector(
          name: 'verifyCollection',
          params: {
            'collectionCodeOrToken': _is.ParameterDescription(
              name: 'collectionCodeOrToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .verifyCollection(
                    session,
                    collectionCodeOrToken: params['collectionCodeOrToken'],
                  ),
        ),
        'getStudentPrintRequests': _is.MethodConnector(
          name: 'getStudentPrintRequests',
          params: {
            'paymentStatusFilter': _is.ParameterDescription(
              name: 'paymentStatusFilter',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .getStudentPrintRequests(
                    session,
                    paymentStatusFilter: params['paymentStatusFilter'],
                  ),
        ),
        'createPrintRequest': _is.MethodConnector(
          name: 'createPrintRequest',
          params: {
            'fileName': _is.ParameterDescription(
              name: 'fileName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fileUrl': _is.ParameterDescription(
              name: 'fileUrl',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fileSizeBytes': _is.ParameterDescription(
              name: 'fileSizeBytes',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'pageCount': _is.ParameterDescription(
              name: 'pageCount',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'copies': _is.ParameterDescription(
              name: 'copies',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'printType': _is.ParameterDescription(
              name: 'printType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'paperSize': _is.ParameterDescription(
              name: 'paperSize',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'printSide': _is.ParameterDescription(
              name: 'printSide',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'binding': _is.ParameterDescription(
              name: 'binding',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'deliveryMode': _is.ParameterDescription(
              name: 'deliveryMode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'counterName': _is.ParameterDescription(
              name: 'counterName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'pointsToRedeem': _is.ParameterDescription(
              name: 'pointsToRedeem',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'simulatePaymentFailure': _is.ParameterDescription(
              name: 'simulatePaymentFailure',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .createPrintRequest(
                    session,
                    fileName: params['fileName'],
                    fileUrl: params['fileUrl'],
                    fileSizeBytes: params['fileSizeBytes'],
                    pageCount: params['pageCount'],
                    copies: params['copies'],
                    printType: params['printType'],
                    paperSize: params['paperSize'],
                    printSide: params['printSide'],
                    binding: params['binding'],
                    deliveryMode: params['deliveryMode'],
                    counterName: params['counterName'],
                    pointsToRedeem: params['pointsToRedeem'],
                    simulatePaymentFailure: params['simulatePaymentFailure'],
                  ),
        ),
        'retryPrintPayment': _is.MethodConnector(
          name: 'retryPrintPayment',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'simulatePaymentFailure': _is.ParameterDescription(
              name: 'simulatePaymentFailure',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .retryPrintPayment(
                    session,
                    requestId: params['requestId'],
                    simulatePaymentFailure: params['simulatePaymentFailure'],
                  ),
        ),
        'getStudentPointWallet': _is.MethodConnector(
          name: 'getStudentPointWallet',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .getStudentPointWallet(session),
        ),
        'getPointTransactions': _is.MethodConnector(
          name: 'getPointTransactions',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _iqlmnpik.LibraryEndpoint)
                  .getPointTransactions(
                    session,
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['mom'] = _is.EndpointConnector(
      name: 'mom',
      endpoint: endpoints['mom']!,
      methodConnectors: {
        'createMom': _is.MethodConnector(
          name: 'createMom',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'meetingDate': _is.ParameterDescription(
              name: 'meetingDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'organizerName': _is.ParameterDescription(
              name: 'organizerName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'attendeeNames': _is.ParameterDescription(
              name: 'attendeeNames',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'agenda': _is.ParameterDescription(
              name: 'agenda',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'discussionPoints': _is.ParameterDescription(
              name: 'discussionPoints',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'decisions': _is.ParameterDescription(
              name: 'decisions',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'actionItems': _is.ParameterDescription(
              name: 'actionItems',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mom'] as _ifiqiuci.MomEndpoint).createMom(
                session,
                title: params['title'],
                meetingDate: params['meetingDate'],
                organizerName: params['organizerName'],
                attendeeNames: params['attendeeNames'],
                agenda: params['agenda'],
                discussionPoints: params['discussionPoints'],
                decisions: params['decisions'],
                actionItems: params['actionItems'],
              ),
        ),
        'listMoms': _is.MethodConnector(
          name: 'listMoms',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mom'] as _ifiqiuci.MomEndpoint).listMoms(session),
        ),
        'getMomDetail': _is.MethodConnector(
          name: 'getMomDetail',
          params: {
            'momId': _is.ParameterDescription(
              name: 'momId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mom'] as _ifiqiuci.MomEndpoint).getMomDetail(
                    session,
                    params['momId'],
                  ),
        ),
      },
    );
    connectors['notification'] = _is.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'getMyNotifications': _is.MethodConnector(
          name: 'getMyNotifications',
          params: {
            'unreadOnly': _is.ParameterDescription(
              name: 'unreadOnly',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
            'type': _is.ParameterDescription(
              name: 'type',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .getMyNotifications(
                        session,
                        unreadOnly: params['unreadOnly'],
                        type: params['type'],
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'getUnreadCount': _is.MethodConnector(
          name: 'getUnreadCount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .getUnreadCount(session),
        ),
        'markAsRead': _is.MethodConnector(
          name: 'markAsRead',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .markAsRead(
                        session,
                        params['id'],
                      ),
        ),
        'markAllAsRead': _is.MethodConnector(
          name: 'markAllAsRead',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .markAllAsRead(session),
        ),
        'streamMyNotifications': _is.MethodStreamConnector(
          name: 'streamMyNotifications',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                  .streamMyNotifications(session),
        ),
      },
    );
    connectors['points'] = _is.EndpointConnector(
      name: 'points',
      endpoint: endpoints['points']!,
      methodConnectors: {
        'checkInWithQrToken': _is.MethodConnector(
          name: 'checkInWithQrToken',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'qrToken': _is.ParameterDescription(
              name: 'qrToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['points'] as _isfdgr65.PointsEndpoint)
                  .checkInWithQrToken(
                    session,
                    eventId: params['eventId'],
                    qrToken: params['qrToken'],
                  ),
        ),
        'getMyPointsAndStreak': _is.MethodConnector(
          name: 'getMyPointsAndStreak',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['points'] as _isfdgr65.PointsEndpoint)
                  .getMyPointsAndStreak(session),
        ),
        'listRewards': _is.MethodConnector(
          name: 'listRewards',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['points'] as _isfdgr65.PointsEndpoint)
                  .listRewards(session),
        ),
        'addRewardPerk': _is.MethodConnector(
          name: 'addRewardPerk',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'costPoints': _is.ParameterDescription(
              name: 'costPoints',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'stockRemaining': _is.ParameterDescription(
              name: 'stockRemaining',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['points'] as _isfdgr65.PointsEndpoint)
                  .addRewardPerk(
                    session,
                    title: params['title'],
                    category: params['category'],
                    description: params['description'],
                    costPoints: params['costPoints'],
                    stockRemaining: params['stockRemaining'],
                  ),
        ),
        'listAllRewards': _is.MethodConnector(
          name: 'listAllRewards',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['points'] as _isfdgr65.PointsEndpoint)
                  .listAllRewards(session),
        ),
        'updateRewardPerk': _is.MethodConnector(
          name: 'updateRewardPerk',
          params: {
            'perk': _is.ParameterDescription(
              name: 'perk',
              type: _is.getType<_i5apij9o.RewardPerk>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['points'] as _isfdgr65.PointsEndpoint)
                  .updateRewardPerk(
                    session,
                    params['perk'],
                  ),
        ),
        'deleteRewardPerk': _is.MethodConnector(
          name: 'deleteRewardPerk',
          params: {
            'perkId': _is.ParameterDescription(
              name: 'perkId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['points'] as _isfdgr65.PointsEndpoint)
                  .deleteRewardPerk(
                    session,
                    params['perkId'],
                  ),
        ),
        'listRedemptions': _is.MethodConnector(
          name: 'listRedemptions',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['points'] as _isfdgr65.PointsEndpoint)
                  .listRedemptions(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'redeemReward': _is.MethodConnector(
          name: 'redeemReward',
          params: {
            'perkId': _is.ParameterDescription(
              name: 'perkId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['points'] as _isfdgr65.PointsEndpoint)
                  .redeemReward(
                    session,
                    params['perkId'],
                  ),
        ),
      },
    );
    connectors['quiz'] = _is.EndpointConnector(
      name: 'quiz',
      endpoint: endpoints['quiz']!,
      methodConnectors: {
        'getQuestionsForSubject': _is.MethodConnector(
          name: 'getQuestionsForSubject',
          params: {
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['quiz'] as _i7z0uw2a.QuizEndpoint)
                  .getQuestionsForSubject(
                    session,
                    params['subject'],
                    limit: params['limit'],
                  ),
        ),
        'submitQuiz': _is.MethodConnector(
          name: 'submitQuiz',
          params: {
            'submission': _is.ParameterDescription(
              name: 'submission',
              type: _is.getType<_ikt4w0rg.QuizSubmission>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['quiz'] as _i7z0uw2a.QuizEndpoint).submitQuiz(
                    session,
                    params['submission'],
                  ),
        ),
        'getRecommendedQuizSubjects': _is.MethodConnector(
          name: 'getRecommendedQuizSubjects',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['quiz'] as _i7z0uw2a.QuizEndpoint)
                  .getRecommendedQuizSubjects(session),
        ),
        'getMyAttempts': _is.MethodConnector(
          name: 'getMyAttempts',
          params: {
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['quiz'] as _i7z0uw2a.QuizEndpoint).getMyAttempts(
                    session,
                    subject: params['subject'],
                  ),
        ),
      },
    );
    connectors['search'] = _is.EndpointConnector(
      name: 'search',
      endpoint: endpoints['search']!,
      methodConnectors: {
        'search': _is.MethodConnector(
          name: 'search',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['search'] as _ipmmezh5.SearchEndpoint).search(
                    session,
                    params['query'],
                    limit: params['limit'],
                  ),
        ),
        'submitContact': _is.MethodConnector(
          name: 'submitContact',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _ipmmezh5.SearchEndpoint)
                  .submitContact(
                    session,
                    name: params['name'],
                    email: params['email'],
                    subject: params['subject'],
                    message: params['message'],
                  ),
        ),
      },
    );
    connectors['seed'] = _is.EndpointConnector(
      name: 'seed',
      endpoint: endpoints['seed']!,
      methodConnectors: {
        'seedData': _is.MethodConnector(
          name: 'seedData',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seed'] as _i8h1zywb.SeedEndpoint).seedData(
                session,
              ),
        ),
      },
    );
    connectors['student'] = _is.EndpointConnector(
      name: 'student',
      endpoint: endpoints['student']!,
      methodConnectors: {
        'loginDemo': _is.MethodConnector(
          name: 'loginDemo',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['student'] as _if6txhyr.StudentEndpoint)
                  .loginDemo(session),
        ),
        'loginDemoStudent2': _is.MethodConnector(
          name: 'loginDemoStudent2',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['student'] as _if6txhyr.StudentEndpoint)
                  .loginDemoStudent2(session),
        ),
        'registerStudent': _is.MethodConnector(
          name: 'registerStudent',
          params: {
            'fullName': _is.ParameterDescription(
              name: 'fullName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'academicYear': _is.ParameterDescription(
              name: 'academicYear',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'hostelOrArea': _is.ParameterDescription(
              name: 'hostelOrArea',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'bio': _is.ParameterDescription(
              name: 'bio',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'subjectInterests': _is.ParameterDescription(
              name: 'subjectInterests',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['student'] as _if6txhyr.StudentEndpoint)
                  .registerStudent(
                    session,
                    fullName: params['fullName'],
                    email: params['email'],
                    password: params['password'],
                    branch: params['branch'],
                    academicYear: params['academicYear'],
                    hostelOrArea: params['hostelOrArea'],
                    bio: params['bio'],
                    subjectInterests: params['subjectInterests'],
                  ),
        ),
        'getProfile': _is.MethodConnector(
          name: 'getProfile',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['student'] as _if6txhyr.StudentEndpoint)
                  .getProfile(session),
        ),
        'updateProfile': _is.MethodConnector(
          name: 'updateProfile',
          params: {
            'fullName': _is.ParameterDescription(
              name: 'fullName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'academicYear': _is.ParameterDescription(
              name: 'academicYear',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'hostelOrArea': _is.ParameterDescription(
              name: 'hostelOrArea',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'bio': _is.ParameterDescription(
              name: 'bio',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'subjectInterests': _is.ParameterDescription(
              name: 'subjectInterests',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'eventInterests': _is.ParameterDescription(
              name: 'eventInterests',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
            'preferredQuizSubjects': _is.ParameterDescription(
              name: 'preferredQuizSubjects',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
            'preferredQuizTypes': _is.ParameterDescription(
              name: 'preferredQuizTypes',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['student'] as _if6txhyr.StudentEndpoint)
                  .updateProfile(
                    session,
                    fullName: params['fullName'],
                    email: params['email'],
                    branch: params['branch'],
                    academicYear: params['academicYear'],
                    hostelOrArea: params['hostelOrArea'],
                    bio: params['bio'],
                    subjectInterests: params['subjectInterests'],
                    eventInterests: params['eventInterests'],
                    preferredQuizSubjects: params['preferredQuizSubjects'],
                    preferredQuizTypes: params['preferredQuizTypes'],
                  ),
        ),
        'updatePreferences': _is.MethodConnector(
          name: 'updatePreferences',
          params: {
            'eventInterests': _is.ParameterDescription(
              name: 'eventInterests',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
            'preferredQuizSubjects': _is.ParameterDescription(
              name: 'preferredQuizSubjects',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
            'preferredQuizTypes': _is.ParameterDescription(
              name: 'preferredQuizTypes',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['student'] as _if6txhyr.StudentEndpoint)
                  .updatePreferences(
                    session,
                    eventInterests: params['eventInterests'],
                    preferredQuizSubjects: params['preferredQuizSubjects'],
                    preferredQuizTypes: params['preferredQuizTypes'],
                  ),
        ),
        'getPublicProfile': _is.MethodConnector(
          name: 'getPublicProfile',
          params: {
            'authUserId': _is.ParameterDescription(
              name: 'authUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['student'] as _if6txhyr.StudentEndpoint)
                  .getPublicProfile(
                    session,
                    params['authUserId'],
                  ),
        ),
        'discoverStudents': _is.MethodConnector(
          name: 'discoverStudents',
          params: {
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'academicYear': _is.ParameterDescription(
              name: 'academicYear',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'hostelOrArea': _is.ParameterDescription(
              name: 'hostelOrArea',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['student'] as _if6txhyr.StudentEndpoint)
                  .discoverStudents(
                    session,
                    branch: params['branch'],
                    academicYear: params['academicYear'],
                    subject: params['subject'],
                    hostelOrArea: params['hostelOrArea'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
      },
    );
    connectors['studyRequest'] = _is.EndpointConnector(
      name: 'studyRequest',
      endpoint: endpoints['studyRequest']!,
      methodConnectors: {
        'sendRequest': _is.MethodConnector(
          name: 'sendRequest',
          params: {
            'recipientAuthUserId': _is.ParameterDescription(
              name: 'recipientAuthUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'urgency': _is.ParameterDescription(
              name: 'urgency',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyRequest'] as _i2439pix.StudyRequestEndpoint)
                      .sendRequest(
                        session,
                        recipientAuthUserId: params['recipientAuthUserId'],
                        subject: params['subject'],
                        message: params['message'],
                        urgency: params['urgency'],
                      ),
        ),
        'getMyIncomingRequests': _is.MethodConnector(
          name: 'getMyIncomingRequests',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyRequest'] as _i2439pix.StudyRequestEndpoint)
                      .getMyIncomingRequests(session),
        ),
        'getMyOutgoingRequests': _is.MethodConnector(
          name: 'getMyOutgoingRequests',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyRequest'] as _i2439pix.StudyRequestEndpoint)
                      .getMyOutgoingRequests(session),
        ),
        'updateRequestStatus': _is.MethodConnector(
          name: 'updateRequestStatus',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'newStatus': _is.ParameterDescription(
              name: 'newStatus',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studyRequest'] as _i2439pix.StudyRequestEndpoint)
                      .updateRequestStatus(
                        session,
                        requestId: params['requestId'],
                        newStatus: params['newStatus'],
                      ),
        ),
      },
    );
    connectors['timetable'] = _is.EndpointConnector(
      name: 'timetable',
      endpoint: endpoints['timetable']!,
      methodConnectors: {
        'addSectionTimetable': _is.MethodConnector(
          name: 'addSectionTimetable',
          params: {
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'academicYear': _is.ParameterDescription(
              name: 'academicYear',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'semester': _is.ParameterDescription(
              name: 'semester',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'section': _is.ParameterDescription(
              name: 'section',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'dayOfWeek': _is.ParameterDescription(
              name: 'dayOfWeek',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'startTime': _is.ParameterDescription(
              name: 'startTime',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'endTime': _is.ParameterDescription(
              name: 'endTime',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'room': _is.ParameterDescription(
              name: 'room',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'faculty': _is.ParameterDescription(
              name: 'faculty',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timetable'] as _in4fhk5u.TimetableEndpoint)
                  .addSectionTimetable(
                    session,
                    branch: params['branch'],
                    academicYear: params['academicYear'],
                    semester: params['semester'],
                    section: params['section'],
                    dayOfWeek: params['dayOfWeek'],
                    startTime: params['startTime'],
                    endTime: params['endTime'],
                    subject: params['subject'],
                    room: params['room'],
                    faculty: params['faculty'],
                  ),
        ),
        'updateSectionTimetable': _is.MethodConnector(
          name: 'updateSectionTimetable',
          params: {
            'entry': _is.ParameterDescription(
              name: 'entry',
              type: _is.getType<_i6o9odyo.SectionTimetable>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timetable'] as _in4fhk5u.TimetableEndpoint)
                  .updateSectionTimetable(
                    session,
                    params['entry'],
                  ),
        ),
        'deleteSectionTimetable': _is.MethodConnector(
          name: 'deleteSectionTimetable',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timetable'] as _in4fhk5u.TimetableEndpoint)
                  .deleteSectionTimetable(
                    session,
                    params['id'],
                  ),
        ),
        'listAllTimetables': _is.MethodConnector(
          name: 'listAllTimetables',
          params: {
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'semester': _is.ParameterDescription(
              name: 'semester',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'section': _is.ParameterDescription(
              name: 'section',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timetable'] as _in4fhk5u.TimetableEndpoint)
                  .listAllTimetables(
                    session,
                    branch: params['branch'],
                    semester: params['semester'],
                    section: params['section'],
                  ),
        ),
        'getSectionTimetable': _is.MethodConnector(
          name: 'getSectionTimetable',
          params: {
            'branch': _is.ParameterDescription(
              name: 'branch',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'semester': _is.ParameterDescription(
              name: 'semester',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'section': _is.ParameterDescription(
              name: 'section',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timetable'] as _in4fhk5u.TimetableEndpoint)
                  .getSectionTimetable(
                    session,
                    branch: params['branch'],
                    semester: params['semester'],
                    section: params['section'],
                  ),
        ),
        'getMyFreeSlots': _is.MethodConnector(
          name: 'getMyFreeSlots',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timetable'] as _in4fhk5u.TimetableEndpoint)
                  .getMyFreeSlots(session),
        ),
        'updateFreeSlot': _is.MethodConnector(
          name: 'updateFreeSlot',
          params: {
            'dayOfWeek': _is.ParameterDescription(
              name: 'dayOfWeek',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'slotLabel': _is.ParameterDescription(
              name: 'slotLabel',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'startTime': _is.ParameterDescription(
              name: 'startTime',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'endTime': _is.ParameterDescription(
              name: 'endTime',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'isFree': _is.ParameterDescription(
              name: 'isFree',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timetable'] as _in4fhk5u.TimetableEndpoint)
                  .updateFreeSlot(
                    session,
                    dayOfWeek: params['dayOfWeek'],
                    slotLabel: params['slotLabel'],
                    startTime: params['startTime'],
                    endTime: params['endTime'],
                    isFree: params['isFree'],
                  ),
        ),
        'clearFreeSlot': _is.MethodConnector(
          name: 'clearFreeSlot',
          params: {
            'dayOfWeek': _is.ParameterDescription(
              name: 'dayOfWeek',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'slotLabel': _is.ParameterDescription(
              name: 'slotLabel',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timetable'] as _in4fhk5u.TimetableEndpoint)
                  .clearFreeSlot(
                    session,
                    dayOfWeek: params['dayOfWeek'],
                    slotLabel: params['slotLabel'],
                  ),
        ),
        'findTimetableStudyMatches': _is.MethodConnector(
          name: 'findTimetableStudyMatches',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timetable'] as _in4fhk5u.TimetableEndpoint)
                  .findTimetableStudyMatches(session),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
