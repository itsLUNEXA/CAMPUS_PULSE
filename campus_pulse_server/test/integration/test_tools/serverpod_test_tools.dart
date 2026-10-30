/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: no_leading_underscores_for_local_identifiers

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'dart:io' as _idi;
import 'dart:typed_data' as _idt;
import 'package:campus_pulse_server/src/generated/academic_resource.dart'
    as _ifhojxs8;
import 'package:campus_pulse_server/src/generated/admin_audit_log.dart'
    as _i60whm80;
import 'package:campus_pulse_server/src/generated/attendance_record.dart'
    as _i4oe753t;
import 'package:campus_pulse_server/src/generated/campus_club.dart'
    as _ih6v9w0h;
import 'package:campus_pulse_server/src/generated/campus_company.dart'
    as _iq2r5nkx;
import 'package:campus_pulse_server/src/generated/campus_event.dart'
    as _iw7ccsb7;
import 'package:campus_pulse_server/src/generated/campus_notification.dart'
    as _if8eiets;
import 'package:campus_pulse_server/src/generated/chat_message.dart'
    as _iit1n394;
import 'package:campus_pulse_server/src/generated/chat_report.dart'
    as _i8osaxbj;
import 'package:campus_pulse_server/src/generated/chat_room.dart' as _i787pbkv;
import 'package:campus_pulse_server/src/generated/club_query_request.dart'
    as _ieve3lh1;
import 'package:campus_pulse_server/src/generated/event_certificate.dart'
    as _iii6sj61;
import 'package:campus_pulse_server/src/generated/event_rsvp.dart' as _iemrykml;
import 'package:campus_pulse_server/src/generated/greetings/greeting.dart'
    as _iwzyf8be;
import 'package:campus_pulse_server/src/generated/leaderboard_entry.dart'
    as _izc9hvlj;
import 'package:campus_pulse_server/src/generated/leaderboard_update.dart'
    as _iy2ytapw;
import 'package:campus_pulse_server/src/generated/minutes_of_meeting.dart'
    as _iecchb3j;
import 'package:campus_pulse_server/src/generated/mock_interview_slot.dart'
    as _i3jujyo2;
import 'package:campus_pulse_server/src/generated/points_ledger.dart'
    as _i966awo3;
import 'package:campus_pulse_server/src/generated/print_point_transaction.dart'
    as _i3a0j8k2;
import 'package:campus_pulse_server/src/generated/print_point_wallet.dart'
    as _imjfxwqg;
import 'package:campus_pulse_server/src/generated/print_request.dart'
    as _inb42hn4;
import 'package:campus_pulse_server/src/generated/quiz_attempt.dart'
    as _ii6cu1i5;
import 'package:campus_pulse_server/src/generated/quiz_question_view.dart'
    as _izqbs8j4;
import 'package:campus_pulse_server/src/generated/quiz_result_summary.dart'
    as _iff6nh57;
import 'package:campus_pulse_server/src/generated/quiz_submission.dart'
    as _ikt4w0rg;
import 'package:campus_pulse_server/src/generated/reward_perk.dart'
    as _i5apij9o;
import 'package:campus_pulse_server/src/generated/rsvp_update.dart'
    as _i0xerc06;
import 'package:campus_pulse_server/src/generated/search_response.dart'
    as _ia40hk63;
import 'package:campus_pulse_server/src/generated/section_timetable.dart'
    as _i6o9odyo;
import 'package:campus_pulse_server/src/generated/senior_experience.dart'
    as _iy2qccrj;
import 'package:campus_pulse_server/src/generated/student_free_slot.dart'
    as _iegmdz27;
import 'package:campus_pulse_server/src/generated/student_profile.dart'
    as _iyr83ylc;
import 'package:campus_pulse_server/src/generated/study_request.dart'
    as _i7nx4e5a;
import 'package:campus_pulse_server/src/generated/syllabus_node.dart'
    as _i2fq24ew;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_test/serverpod_test.dart' as _ist;
import 'package:campus_pulse_server/src/generated/protocol.dart';
import 'package:campus_pulse_server/src/generated/endpoints.dart';
export 'package:serverpod_test/serverpod_test_public_exports.dart';

/// Creates a new test group that takes a callback that can be used to write tests.
/// The callback has two parameters: `sessionBuilder` and `endpoints`.
/// `sessionBuilder` is used to build a `Session` object that represents the server state during an endpoint call and is used to set up scenarios.
/// `endpoints` contains all your Serverpod endpoints and lets you call them:
/// ```dart
/// withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
///   test('when calling `hello` then should return greeting', () async {
///     final greeting = await endpoints.example.hello(sessionBuilder, 'Michael');
///     expect(greeting, 'Hello Michael');
///   });
/// });
/// ```
///
/// **Configuration options**
///
/// [applyMigrations] Whether pending migrations should be applied when starting Serverpod. Defaults to `true`
///
/// [enableSessionLogging] Whether session logging should be enabled. Defaults to `false`
///
/// [ephemeralDatabase] Whether this group gets its own empty database, created when the group starts and dropped when it finishes. Defaults to `true`.
/// Set this to `false` to use the database configured for [runMode], including a previously seeded database. [configOverride] can still replace that database. The configured database is not created or dropped, so groups that share it cannot run in parallel. [rollbackDatabase] still controls whether writes inside the group are rolled back.
///
/// [rollbackDatabase] Options for when to rollback the database during the test lifecycle.
/// By default `withServerpod` does all database operations inside a transaction that is rolled back after each `test` case.
/// Just like the following enum describes, the behavior of the automatic rollbacks can be configured:
/// ```dart
/// /// Options for when to rollback the database during the test lifecycle.
/// enum RollbackDatabase {
///   /// After each test. This is the default.
///   afterEach,
///
///   /// After all tests.
///   afterAll,
///
///   /// Disable rolling back the database.
///   disabled,
/// }
/// ```
///
/// [runMode] The run mode that Serverpod should be running in. Defaults to `test`.
///
/// [serverpodLoggingMode] The logging mode used when creating Serverpod. Defaults to `ServerpodLoggingMode.normal`
///
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 120)`.
///
/// [testServerOutputMode] Options for controlling test server output during test execution. Defaults to `TestServerOutputMode.normal`.
/// ```dart
/// /// Options for controlling test server output during test execution.
/// enum TestServerOutputMode {
///   /// Default mode - only stderr is printed (stdout suppressed).
///   /// This hides normal startup/shutdown logs while preserving error messages.
///   normal,
///
///   /// All logging - both stdout and stderr are printed.
///   /// Useful for debugging when you need to see all server output.
///   verbose,
///
///   /// No logging - both stdout and stderr are suppressed.
///   /// Completely silent mode, useful when you don't want any server output.
///   silent,
/// }
/// ```
///
/// [configOverride] A function to override the server configuration. This function is called with
/// the default server configuration after it is loaded from the config/ directory
/// and before it is used to start the server. Use this to override particular
/// settings in the server configuration.
///
/// [databaseInterceptor] Optional interceptor that replaces the default database for each session.
/// See [Serverpod.databaseInterceptor] for more information.
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
///
/// [serverDirectory] The server package directory `config/<runMode>.yaml`, `config/passwords.yaml`,
/// and `migrations/<module>/...` are resolved against. Defaults to
/// [Directory.current] at the time the test boots. Pass this when the test
/// isolate's cwd is not the server package root (e.g. running tests from a
/// workspace parent directory) so config and migrations are still loaded
/// from the right place.
@_ist.isTestGroup
void withServerpod(
  String testGroupName,
  _ist.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  _is.ServerpodConfig Function(_is.ServerpodConfig)? configOverride,
  _is.DatabaseInterceptor? databaseInterceptor,
  bool? enableSessionLogging,
  bool? ephemeralDatabase,
  _is.ExperimentalFeatures? experimentalFeatures,
  _ist.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _is.RuntimeParametersListBuilder? runtimeParametersBuilder,
  _idi.Directory? serverDirectory,
  _is.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
  _ist.TestServerOutputMode? testServerOutputMode,
}) {
  _ist.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _ist.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      ephemeralDatabase: ephemeralDatabase,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      testServerOutputMode: testServerOutputMode,
      serverDirectory: serverDirectory,
      experimentalFeatures: experimentalFeatures,
      configOverride: configOverride,
      runtimeParametersBuilder: runtimeParametersBuilder,
      databaseInterceptor: databaseInterceptor,
    ),
    maybeRollbackDatabase: rollbackDatabase,
    maybeEnableSessionLogging: enableSessionLogging,
    maybeTestGroupTagsOverride: testGroupTagsOverride,
    maybeServerpodStartTimeout: serverpodStartTimeout,
    maybeTestServerOutputMode: testServerOutputMode,
  )(testClosure);
}

class TestEndpoints {
  late final _EmailIdpEndpoint emailIdp;

  late final _JwtRefreshEndpoint jwtRefresh;

  late final _AcademicResourceEndpoint academicResource;

  late final _AdminEndpoint admin;

  late final _AttendanceEndpoint attendance;

  late final _CertificateEndpoint certificate;

  late final _ChatEndpoint chat;

  late final _ClubEndpoint club;

  late final _EventEndpoint event;

  late final _InterviewPrepEndpoint interviewPrep;

  late final _LeaderboardEndpoint leaderboard;

  late final _LibraryEndpoint library;

  late final _MomEndpoint mom;

  late final _NotificationEndpoint notification;

  late final _PointsEndpoint points;

  late final _QuizEndpoint quiz;

  late final _SearchEndpoint search;

  late final _SeedEndpoint seed;

  late final _StudentEndpoint student;

  late final _StudyRequestEndpoint studyRequest;

  late final _TimetableEndpoint timetable;

  late final _GreetingEndpoint greeting;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _ist.InternalTestEndpoints {
  @override
  void initialize(
    _is.SerializationManager serializationManager,
    _is.EndpointDispatch endpoints,
  ) {
    emailIdp = _EmailIdpEndpoint(
      endpoints,
      serializationManager,
    );
    jwtRefresh = _JwtRefreshEndpoint(
      endpoints,
      serializationManager,
    );
    academicResource = _AcademicResourceEndpoint(
      endpoints,
      serializationManager,
    );
    admin = _AdminEndpoint(
      endpoints,
      serializationManager,
    );
    attendance = _AttendanceEndpoint(
      endpoints,
      serializationManager,
    );
    certificate = _CertificateEndpoint(
      endpoints,
      serializationManager,
    );
    chat = _ChatEndpoint(
      endpoints,
      serializationManager,
    );
    club = _ClubEndpoint(
      endpoints,
      serializationManager,
    );
    event = _EventEndpoint(
      endpoints,
      serializationManager,
    );
    interviewPrep = _InterviewPrepEndpoint(
      endpoints,
      serializationManager,
    );
    leaderboard = _LeaderboardEndpoint(
      endpoints,
      serializationManager,
    );
    library = _LibraryEndpoint(
      endpoints,
      serializationManager,
    );
    mom = _MomEndpoint(
      endpoints,
      serializationManager,
    );
    notification = _NotificationEndpoint(
      endpoints,
      serializationManager,
    );
    points = _PointsEndpoint(
      endpoints,
      serializationManager,
    );
    quiz = _QuizEndpoint(
      endpoints,
      serializationManager,
    );
    search = _SearchEndpoint(
      endpoints,
      serializationManager,
    );
    seed = _SeedEndpoint(
      endpoints,
      serializationManager,
    );
    student = _StudentEndpoint(
      endpoints,
      serializationManager,
    );
    studyRequest = _StudyRequestEndpoint(
      endpoints,
      serializationManager,
    );
    timetable = _TimetableEndpoint(
      endpoints,
      serializationManager,
    );
    greeting = _GreetingEndpoint(
      endpoints,
      serializationManager,
    );
  }
}

class _EmailIdpEndpoint {
  _EmailIdpEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iacs.AuthSuccess> login(
    _ist.TestSessionBuilder sessionBuilder, {
    required String email,
    required String password,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'login',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'login',
          parameters: _ist.testObjectToJson({
            'email': email,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_is.UuidValue> startRegistration(
    _ist.TestSessionBuilder sessionBuilder, {
    required String email,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'startRegistration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'startRegistration',
          parameters: _ist.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_is.UuidValue>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> verifyRegistrationCode(
    _ist.TestSessionBuilder sessionBuilder, {
    required _is.UuidValue accountRequestId,
    required String verificationCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'verifyRegistrationCode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'verifyRegistrationCode',
          parameters: _ist.testObjectToJson({
            'accountRequestId': accountRequestId,
            'verificationCode': verificationCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iacs.AuthSuccess> finishRegistration(
    _ist.TestSessionBuilder sessionBuilder, {
    required String registrationToken,
    required String password,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'finishRegistration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'finishRegistration',
          parameters: _ist.testObjectToJson({
            'registrationToken': registrationToken,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_is.UuidValue> startPasswordReset(
    _ist.TestSessionBuilder sessionBuilder, {
    required String email,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'startPasswordReset',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'startPasswordReset',
          parameters: _ist.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_is.UuidValue>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> verifyPasswordResetCode(
    _ist.TestSessionBuilder sessionBuilder, {
    required _is.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'verifyPasswordResetCode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'verifyPasswordResetCode',
          parameters: _ist.testObjectToJson({
            'passwordResetRequestId': passwordResetRequestId,
            'verificationCode': verificationCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> finishPasswordReset(
    _ist.TestSessionBuilder sessionBuilder, {
    required String finishPasswordResetToken,
    required String newPassword,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'finishPasswordReset',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'finishPasswordReset',
          parameters: _ist.testObjectToJson({
            'finishPasswordResetToken': finishPasswordResetToken,
            'newPassword': newPassword,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> hasAccount(_ist.TestSessionBuilder sessionBuilder) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'hasAccount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'hasAccount',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _JwtRefreshEndpoint {
  _JwtRefreshEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iacs.AuthSuccess> refreshAccessToken(
    _ist.TestSessionBuilder sessionBuilder, {
    String? refreshToken,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jwtRefresh',
            method: 'refreshAccessToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jwtRefresh',
          methodName: 'refreshAccessToken',
          parameters: _ist.testObjectToJson({'refreshToken': refreshToken}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AcademicResourceEndpoint {
  _AcademicResourceEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ifhojxs8.AcademicResource> uploadResource(
    _ist.TestSessionBuilder sessionBuilder, {
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
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicResource',
            method: 'uploadResource',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicResource',
          methodName: 'uploadResource',
          parameters: _ist.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ifhojxs8.AcademicResource>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ifhojxs8.AcademicResource>> filterResources(
    _ist.TestSessionBuilder sessionBuilder, {
    String? university,
    String? course,
    String? branch,
    int? semester,
    String? subjectCode,
    int? unitNumber,
    String? resourceType,
    required bool onlyApproved,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicResource',
            method: 'filterResources',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicResource',
          methodName: 'filterResources',
          parameters: _ist.testObjectToJson({
            'university': university,
            'course': course,
            'branch': branch,
            'semester': semester,
            'subjectCode': subjectCode,
            'unitNumber': unitNumber,
            'resourceType': resourceType,
            'onlyApproved': onlyApproved,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ifhojxs8.AcademicResource>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ifhojxs8.AcademicResource>> listPendingResources(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicResource',
            method: 'listPendingResources',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicResource',
          methodName: 'listPendingResources',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ifhojxs8.AcademicResource>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> setApprovalStatus(
    _ist.TestSessionBuilder sessionBuilder,
    int resourceId,
    bool approved, {
    String? reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicResource',
            method: 'setApprovalStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicResource',
          methodName: 'setApprovalStatus',
          parameters: _ist.testObjectToJson({
            'resourceId': resourceId,
            'approved': approved,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> recordDownload(
    _ist.TestSessionBuilder sessionBuilder,
    int resourceId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicResource',
            method: 'recordDownload',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicResource',
          methodName: 'recordDownload',
          parameters: _ist.testObjectToJson({'resourceId': resourceId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i2fq24ew.SyllabusNode>> getSubjectSyllabus(
    _ist.TestSessionBuilder sessionBuilder, {
    required String branch,
    required int semester,
    required String subjectCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicResource',
            method: 'getSubjectSyllabus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicResource',
          methodName: 'getSubjectSyllabus',
          parameters: _ist.testObjectToJson({
            'branch': branch,
            'semester': semester,
            'subjectCode': subjectCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i2fq24ew.SyllabusNode>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ifhojxs8.AcademicResource> uploadPdf(
    _ist.TestSessionBuilder sessionBuilder, {
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
    required _idt.ByteData fileBytes,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicResource',
            method: 'uploadPdf',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicResource',
          methodName: 'uploadPdf',
          parameters: _ist.testObjectToJson({
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
            'filename': filename,
            'fileBytes': fileBytes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ifhojxs8.AcademicResource>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_idt.ByteData?> downloadPdf(
    _ist.TestSessionBuilder sessionBuilder,
    int resourceId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicResource',
            method: 'downloadPdf',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicResource',
          methodName: 'downloadPdf',
          parameters: _ist.testObjectToJson({'resourceId': resourceId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_idt.ByteData?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> isPdfAvailable(
    _ist.TestSessionBuilder sessionBuilder,
    int resourceId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicResource',
            method: 'isPdfAvailable',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicResource',
          methodName: 'isPdfAvailable',
          parameters: _ist.testObjectToJson({'resourceId': resourceId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminEndpoint {
  _AdminEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iacs.AuthSuccess> loginAdmin(
    _ist.TestSessionBuilder sessionBuilder, {
    required String email,
    required String password,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'loginAdmin',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'loginAdmin',
          parameters: _ist.testObjectToJson({
            'email': email,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iacs.AuthSuccess> loginMasterAdminDemo(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'loginMasterAdminDemo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'loginMasterAdminDemo',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> verifyAdminSession(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'verifyAdminSession',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'verifyAdminSession',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<Map<String, int>> getDashboardOverview(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getDashboardOverview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getDashboardOverview',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<Map<String, int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> assignRole(
    _ist.TestSessionBuilder sessionBuilder,
    _is.UuidValue targetUserId,
    String role, {
    String? scope,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'assignRole',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'assignRole',
          parameters: _ist.testObjectToJson({
            'targetUserId': targetUserId,
            'role': role,
            'scope': scope,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> revokeRole(
    _ist.TestSessionBuilder sessionBuilder,
    _is.UuidValue targetUserId,
    String role,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'revokeRole',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'revokeRole',
          parameters: _ist.testObjectToJson({
            'targetUserId': targetUserId,
            'role': role,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<String>> getUserRoles(
    _ist.TestSessionBuilder sessionBuilder,
    _is.UuidValue targetUserId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getUserRoles',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getUserRoles',
          parameters: _ist.testObjectToJson({'targetUserId': targetUserId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iyr83ylc.StudentProfile>> listStudents(
    _ist.TestSessionBuilder sessionBuilder, {
    String? search,
    required int limit,
    required int offset,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listStudents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listStudents',
          parameters: _ist.testObjectToJson({
            'search': search,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iyr83ylc.StudentProfile>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<int> getStudentCount(
    _ist.TestSessionBuilder sessionBuilder, {
    String? search,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getStudentCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getStudentCount',
          parameters: _ist.testObjectToJson({'search': search}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<String>> getMyRoles(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getMyRoles',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getMyRoles',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i60whm80.AdminAuditLog>> listAuditLogs(
    _ist.TestSessionBuilder sessionBuilder, {
    String? search,
    String? actionType,
    required int limit,
    required int offset,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listAuditLogs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listAuditLogs',
          parameters: _ist.testObjectToJson({
            'search': search,
            'actionType': actionType,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i60whm80.AdminAuditLog>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AttendanceEndpoint {
  _AttendanceEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_i4oe753t.AttendanceRecord> markAttendance(
    _ist.TestSessionBuilder sessionBuilder, {
    required int eventId,
    required _is.UuidValue studentAuthUserId,
    required String studentName,
    required String status,
    String? checkInCode,
    String? notes,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'attendance',
            method: 'markAttendance',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'attendance',
          methodName: 'markAttendance',
          parameters: _ist.testObjectToJson({
            'eventId': eventId,
            'studentAuthUserId': studentAuthUserId,
            'studentName': studentName,
            'status': status,
            'checkInCode': checkInCode,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i4oe753t.AttendanceRecord>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i4oe753t.AttendanceRecord> checkInWithCode(
    _ist.TestSessionBuilder sessionBuilder, {
    required int eventId,
    required String enteredCode,
    required String studentName,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'attendance',
            method: 'checkInWithCode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'attendance',
          methodName: 'checkInWithCode',
          parameters: _ist.testObjectToJson({
            'eventId': eventId,
            'enteredCode': enteredCode,
            'studentName': studentName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i4oe753t.AttendanceRecord>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i4oe753t.AttendanceRecord>> getEventAttendance(
    _ist.TestSessionBuilder sessionBuilder,
    int eventId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'attendance',
            method: 'getEventAttendance',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'attendance',
          methodName: 'getEventAttendance',
          parameters: _ist.testObjectToJson({'eventId': eventId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i4oe753t.AttendanceRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i4oe753t.AttendanceRecord>> getMyAttendanceHistory(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'attendance',
            method: 'getMyAttendanceHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'attendance',
          methodName: 'getMyAttendanceHistory',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i4oe753t.AttendanceRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CertificateEndpoint {
  _CertificateEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iii6sj61.EventCertificate> issueCertificate(
    _ist.TestSessionBuilder sessionBuilder, {
    required int eventId,
    required _is.UuidValue studentAuthUserId,
    required String studentName,
    required String signatureTitle,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'issueCertificate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'issueCertificate',
          parameters: _ist.testObjectToJson({
            'eventId': eventId,
            'studentAuthUserId': studentAuthUserId,
            'studentName': studentName,
            'signatureTitle': signatureTitle,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iii6sj61.EventCertificate>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iii6sj61.EventCertificate?> verifyCertificate(
    _ist.TestSessionBuilder sessionBuilder,
    String certificateId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'verifyCertificate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'verifyCertificate',
          parameters: _ist.testObjectToJson({'certificateId': certificateId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iii6sj61.EventCertificate?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iii6sj61.EventCertificate>> getMyCertificates(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'getMyCertificates',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'getMyCertificates',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iii6sj61.EventCertificate>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> revokeCertificate(
    _ist.TestSessionBuilder sessionBuilder,
    String certificateId,
    String reason,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'certificate',
            method: 'revokeCertificate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'certificate',
          methodName: 'revokeCertificate',
          parameters: _ist.testObjectToJson({
            'certificateId': certificateId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ChatEndpoint {
  _ChatEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_i787pbkv.ChatRoom> getOrCreateRoom(
    _ist.TestSessionBuilder sessionBuilder, {
    required String roomType,
    String? referenceId,
    required String name,
    required List<_is.UuidValue> participantIds,
    String? allowedBranch,
    int? allowedAcademicYear,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'getOrCreateRoom',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'getOrCreateRoom',
          parameters: _ist.testObjectToJson({
            'roomType': roomType,
            'referenceId': referenceId,
            'name': name,
            'participantIds': participantIds,
            'allowedBranch': allowedBranch,
            'allowedAcademicYear': allowedAcademicYear,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i787pbkv.ChatRoom>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iit1n394.ChatMessage> sendMessage(
    _ist.TestSessionBuilder sessionBuilder, {
    required int roomId,
    required String content,
    String? attachmentUrl,
    String? attachmentType,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'sendMessage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'sendMessage',
          parameters: _ist.testObjectToJson({
            'roomId': roomId,
            'content': content,
            'attachmentUrl': attachmentUrl,
            'attachmentType': attachmentType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iit1n394.ChatMessage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iit1n394.ChatMessage>> getRoomMessages(
    _ist.TestSessionBuilder sessionBuilder,
    int roomId, {
    required int limit,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'getRoomMessages',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'getRoomMessages',
          parameters: _ist.testObjectToJson({
            'roomId': roomId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iit1n394.ChatMessage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Stream<_iit1n394.ChatMessage> streamChatMessages(
    _ist.TestSessionBuilder sessionBuilder,
    int roomId,
  ) {
    var _localTestStreamManager =
        _ist.TestStreamManager<_iit1n394.ChatMessage>();
    _ist.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
              endpoint: 'chat',
              method: 'streamChatMessages',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'chat',
              methodName: 'streamChatMessages',
              arguments: {'roomId': roomId},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _ida.Future<_i8osaxbj.ChatReport> reportMessage(
    _ist.TestSessionBuilder sessionBuilder, {
    required int messageId,
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'reportMessage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'reportMessage',
          parameters: _ist.testObjectToJson({
            'messageId': messageId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i8osaxbj.ChatReport>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i8osaxbj.ChatReport>> listChatReports(
    _ist.TestSessionBuilder sessionBuilder, {
    String? status,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'listChatReports',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'listChatReports',
          parameters: _ist.testObjectToJson({'status': status}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i8osaxbj.ChatReport>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> resolveChatReport(
    _ist.TestSessionBuilder sessionBuilder, {
    required int reportId,
    required String action,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'resolveChatReport',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'resolveChatReport',
          parameters: _ist.testObjectToJson({
            'reportId': reportId,
            'action': action,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i787pbkv.ChatRoom>> listMyRooms(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'listMyRooms',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'listMyRooms',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i787pbkv.ChatRoom>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i787pbkv.ChatRoom> createCustomRoom(
    _ist.TestSessionBuilder sessionBuilder, {
    required String name,
    String? description,
    String? topic,
    String? allowedBranch,
    int? allowedAcademicYear,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'createCustomRoom',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'createCustomRoom',
          parameters: _ist.testObjectToJson({
            'name': name,
            'description': description,
            'topic': topic,
            'allowedBranch': allowedBranch,
            'allowedAcademicYear': allowedAcademicYear,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i787pbkv.ChatRoom>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i787pbkv.ChatRoom> joinRoom(
    _ist.TestSessionBuilder sessionBuilder,
    int roomId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'joinRoom',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'joinRoom',
          parameters: _ist.testObjectToJson({'roomId': roomId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i787pbkv.ChatRoom>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i787pbkv.ChatRoom>> listAllAccessibleRooms(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'listAllAccessibleRooms',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'listAllAccessibleRooms',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i787pbkv.ChatRoom>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ClubEndpoint {
  _ClubEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<List<_ih6v9w0h.CampusClub>> listClubs(
    _ist.TestSessionBuilder sessionBuilder, {
    String? category,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'club',
            method: 'listClubs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'club',
          methodName: 'listClubs',
          parameters: _ist.testObjectToJson({'category': category}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ih6v9w0h.CampusClub>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ih6v9w0h.CampusClub?> getClub(
    _ist.TestSessionBuilder sessionBuilder,
    int clubId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'club',
            method: 'getClub',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'club',
          methodName: 'getClub',
          parameters: _ist.testObjectToJson({'clubId': clubId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ih6v9w0h.CampusClub?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ieve3lh1.ClubQueryRequest> submitClubQuery(
    _ist.TestSessionBuilder sessionBuilder, {
    required int clubId,
    required String targetTeam,
    required String category,
    required String subject,
    required String message,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'club',
            method: 'submitClubQuery',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'club',
          methodName: 'submitClubQuery',
          parameters: _ist.testObjectToJson({
            'clubId': clubId,
            'targetTeam': targetTeam,
            'category': category,
            'subject': subject,
            'message': message,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ieve3lh1.ClubQueryRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ieve3lh1.ClubQueryRequest>> getMyClubQueries(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'club',
            method: 'getMyClubQueries',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'club',
          methodName: 'getMyClubQueries',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ieve3lh1.ClubQueryRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ieve3lh1.ClubQueryRequest>> getClubQueries(
    _ist.TestSessionBuilder sessionBuilder, {
    int? clubId,
    String? targetTeam,
    String? status,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'club',
            method: 'getClubQueries',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'club',
          methodName: 'getClubQueries',
          parameters: _ist.testObjectToJson({
            'clubId': clubId,
            'targetTeam': targetTeam,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ieve3lh1.ClubQueryRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ieve3lh1.ClubQueryRequest> respondToClubQuery(
    _ist.TestSessionBuilder sessionBuilder, {
    required int queryId,
    required String responseMessage,
    String? responderName,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'club',
            method: 'respondToClubQuery',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'club',
          methodName: 'respondToClubQuery',
          parameters: _ist.testObjectToJson({
            'queryId': queryId,
            'responseMessage': responseMessage,
            'responderName': responderName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ieve3lh1.ClubQueryRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _EventEndpoint {
  _EventEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<List<_iw7ccsb7.CampusEvent>> listEvents(
    _ist.TestSessionBuilder sessionBuilder, {
    String? category,
    String? approvalStatus,
    required int limit,
    required int offset,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'listEvents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'listEvents',
          parameters: _ist.testObjectToJson({
            'category': category,
            'approvalStatus': approvalStatus,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iw7ccsb7.CampusEvent>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iw7ccsb7.CampusEvent?> getEvent(
    _ist.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'getEvent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'getEvent',
          parameters: _ist.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iw7ccsb7.CampusEvent?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iw7ccsb7.CampusEvent>> getRecommendedEvents(
    _ist.TestSessionBuilder sessionBuilder, {
    required int limit,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'getRecommendedEvents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'getRecommendedEvents',
          parameters: _ist.testObjectToJson({'limit': limit}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iw7ccsb7.CampusEvent>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iw7ccsb7.CampusEvent> createEvent(
    _ist.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'createEvent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'createEvent',
          parameters: _ist.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iw7ccsb7.CampusEvent>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iw7ccsb7.CampusEvent> editEvent(
    _ist.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'editEvent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'editEvent',
          parameters: _ist.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iw7ccsb7.CampusEvent>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iw7ccsb7.CampusEvent> reviewEvent(
    _ist.TestSessionBuilder sessionBuilder, {
    required int eventId,
    required String decision,
    String? rejectionReason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'reviewEvent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'reviewEvent',
          parameters: _ist.testObjectToJson({
            'eventId': eventId,
            'decision': decision,
            'rejectionReason': rejectionReason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iw7ccsb7.CampusEvent>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> registerForEvent(
    _ist.TestSessionBuilder sessionBuilder,
    int eventId, {
    String? teamName,
    List<String>? teamMemberNames,
    List<String>? teamMemberEmails,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'registerForEvent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'registerForEvent',
          parameters: _ist.testObjectToJson({
            'eventId': eventId,
            'teamName': teamName,
            'teamMemberNames': teamMemberNames,
            'teamMemberEmails': teamMemberEmails,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> rsvpEvent(
    _ist.TestSessionBuilder sessionBuilder,
    int eventId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'rsvpEvent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'rsvpEvent',
          parameters: _ist.testObjectToJson({'eventId': eventId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> cancelRegistration(
    _ist.TestSessionBuilder sessionBuilder,
    int eventId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'cancelRegistration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'cancelRegistration',
          parameters: _ist.testObjectToJson({'eventId': eventId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> cancelRsvp(
    _ist.TestSessionBuilder sessionBuilder,
    int eventId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'cancelRsvp',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'cancelRsvp',
          parameters: _ist.testObjectToJson({'eventId': eventId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> hasUserRegistered(
    _ist.TestSessionBuilder sessionBuilder,
    int eventId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'hasUserRegistered',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'hasUserRegistered',
          parameters: _ist.testObjectToJson({'eventId': eventId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> hasUserRsvpd(
    _ist.TestSessionBuilder sessionBuilder,
    int eventId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'hasUserRsvpd',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'hasUserRsvpd',
          parameters: _ist.testObjectToJson({'eventId': eventId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<int>> getMyRegisteredEventIds(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'getMyRegisteredEventIds',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'getMyRegisteredEventIds',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<int>> getMyRsvpdEventIds(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'getMyRsvpdEventIds',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'getMyRsvpdEventIds',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iemrykml.EventRsvp>> getMyOrganizerRegistrations(
    _ist.TestSessionBuilder sessionBuilder,
    int eventId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'getMyOrganizerRegistrations',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'getMyOrganizerRegistrations',
          parameters: _ist.testObjectToJson({'eventId': eventId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iemrykml.EventRsvp>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Stream<_i0xerc06.RsvpUpdate> streamRsvpUpdates(
    _ist.TestSessionBuilder sessionBuilder,
  ) {
    var _localTestStreamManager =
        _ist.TestStreamManager<_i0xerc06.RsvpUpdate>();
    _ist.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
              endpoint: 'event',
              method: 'streamRsvpUpdates',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'event',
              methodName: 'streamRsvpUpdates',
              arguments: {},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _ida.Future<List<_iw7ccsb7.CampusEvent>> getPendingEvents(
    _ist.TestSessionBuilder sessionBuilder, {
    required int limit,
    required int offset,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'getPendingEvents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'getPendingEvents',
          parameters: _ist.testObjectToJson({
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iw7ccsb7.CampusEvent>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<int> getPendingEventsCount(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'getPendingEventsCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'getPendingEventsCount',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iw7ccsb7.CampusEvent>> getMyEvents(
    _ist.TestSessionBuilder sessionBuilder, {
    String? status,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'event',
            method: 'getMyEvents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'event',
          methodName: 'getMyEvents',
          parameters: _ist.testObjectToJson({'status': status}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iw7ccsb7.CampusEvent>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _InterviewPrepEndpoint {
  _InterviewPrepEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<List<_iq2r5nkx.CampusCompany>> listCompanies(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'interviewPrep',
            method: 'listCompanies',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'interviewPrep',
          methodName: 'listCompanies',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iq2r5nkx.CampusCompany>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iy2qccrj.SeniorExperience>> listSeniorExperiences(
    _ist.TestSessionBuilder sessionBuilder, {
    String? companyName,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'interviewPrep',
            method: 'listSeniorExperiences',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'interviewPrep',
          methodName: 'listSeniorExperiences',
          parameters: _ist.testObjectToJson({'companyName': companyName}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iy2qccrj.SeniorExperience>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i3jujyo2.MockInterviewSlot> requestMockInterview(
    _ist.TestSessionBuilder sessionBuilder, {
    required String targetCompany,
    required String targetRole,
    required String mockRound,
    required DateTime preferredDate,
    String? resumeUrl,
    String? notes,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'interviewPrep',
            method: 'requestMockInterview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'interviewPrep',
          methodName: 'requestMockInterview',
          parameters: _ist.testObjectToJson({
            'targetCompany': targetCompany,
            'targetRole': targetRole,
            'mockRound': mockRound,
            'preferredDate': preferredDate,
            'resumeUrl': resumeUrl,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i3jujyo2.MockInterviewSlot>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i3jujyo2.MockInterviewSlot>> getMyMockInterviewSlots(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'interviewPrep',
            method: 'getMyMockInterviewSlots',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'interviewPrep',
          methodName: 'getMyMockInterviewSlots',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i3jujyo2.MockInterviewSlot>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i3jujyo2.MockInterviewSlot> updateMockInterviewStatus(
    _ist.TestSessionBuilder sessionBuilder, {
    required int slotId,
    required String status,
    String? seniorMentorName,
    String? meetingLink,
    String? feedbackNotes,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'interviewPrep',
            method: 'updateMockInterviewStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'interviewPrep',
          methodName: 'updateMockInterviewStatus',
          parameters: _ist.testObjectToJson({
            'slotId': slotId,
            'status': status,
            'seniorMentorName': seniorMentorName,
            'meetingLink': meetingLink,
            'feedbackNotes': feedbackNotes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i3jujyo2.MockInterviewSlot>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _LeaderboardEndpoint {
  _LeaderboardEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<List<_izc9hvlj.LeaderboardEntry>> getLeaderboard(
    _ist.TestSessionBuilder sessionBuilder, {
    String? subject,
    String? branch,
    int? academicYear,
    required int limit,
    required int offset,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'leaderboard',
            method: 'getLeaderboard',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'leaderboard',
          methodName: 'getLeaderboard',
          parameters: _ist.testObjectToJson({
            'subject': subject,
            'branch': branch,
            'academicYear': academicYear,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_izc9hvlj.LeaderboardEntry>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_izc9hvlj.LeaderboardEntry?> getMyRank(
    _ist.TestSessionBuilder sessionBuilder, {
    String? subject,
    String? branch,
    int? academicYear,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'leaderboard',
            method: 'getMyRank',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'leaderboard',
          methodName: 'getMyRank',
          parameters: _ist.testObjectToJson({
            'subject': subject,
            'branch': branch,
            'academicYear': academicYear,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_izc9hvlj.LeaderboardEntry?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Stream<_iy2ytapw.LeaderboardUpdate> streamLeaderboardUpdates(
    _ist.TestSessionBuilder sessionBuilder,
  ) {
    var _localTestStreamManager =
        _ist.TestStreamManager<_iy2ytapw.LeaderboardUpdate>();
    _ist.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
              endpoint: 'leaderboard',
              method: 'streamLeaderboardUpdates',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'leaderboard',
              methodName: 'streamLeaderboardUpdates',
              arguments: {},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }
}

class _LibraryEndpoint {
  _LibraryEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<Map<String, dynamic>> getStaffProfile(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'library',
            method: 'getStaffProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'library',
          methodName: 'getStaffProfile',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<String>> getAvailableCounters(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'library',
            method: 'getAvailableCounters',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'library',
          methodName: 'getAvailableCounters',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_inb42hn4.PrintRequest>> getLibraryRequests(
    _ist.TestSessionBuilder sessionBuilder, {
    String? counterName,
    String? statusFilter,
    String? searchQuery,
    required int limit,
    required int offset,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'library',
            method: 'getLibraryRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'library',
          methodName: 'getLibraryRequests',
          parameters: _ist.testObjectToJson({
            'counterName': counterName,
            'statusFilter': statusFilter,
            'searchQuery': searchQuery,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_inb42hn4.PrintRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_inb42hn4.PrintRequest> updateRequestStatus(
    _ist.TestSessionBuilder sessionBuilder, {
    required int requestId,
    required String targetStatus,
    String? reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'library',
            method: 'updateRequestStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'library',
          methodName: 'updateRequestStatus',
          parameters: _ist.testObjectToJson({
            'requestId': requestId,
            'targetStatus': targetStatus,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_inb42hn4.PrintRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_inb42hn4.PrintRequest> verifyCollection(
    _ist.TestSessionBuilder sessionBuilder, {
    required String collectionCodeOrToken,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'library',
            method: 'verifyCollection',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'library',
          methodName: 'verifyCollection',
          parameters: _ist.testObjectToJson({
            'collectionCodeOrToken': collectionCodeOrToken,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_inb42hn4.PrintRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_inb42hn4.PrintRequest>> getStudentPrintRequests(
    _ist.TestSessionBuilder sessionBuilder, {
    String? paymentStatusFilter,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'library',
            method: 'getStudentPrintRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'library',
          methodName: 'getStudentPrintRequests',
          parameters: _ist.testObjectToJson({
            'paymentStatusFilter': paymentStatusFilter,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_inb42hn4.PrintRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_inb42hn4.PrintRequest> createPrintRequest(
    _ist.TestSessionBuilder sessionBuilder, {
    required String fileName,
    required String fileUrl,
    int? fileSizeBytes,
    required int pageCount,
    required int copies,
    required String printType,
    required String paperSize,
    required String printSide,
    required String binding,
    required String deliveryMode,
    required String counterName,
    required int pointsToRedeem,
    required bool simulatePaymentFailure,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'library',
            method: 'createPrintRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'library',
          methodName: 'createPrintRequest',
          parameters: _ist.testObjectToJson({
            'fileName': fileName,
            'fileUrl': fileUrl,
            'fileSizeBytes': fileSizeBytes,
            'pageCount': pageCount,
            'copies': copies,
            'printType': printType,
            'paperSize': paperSize,
            'printSide': printSide,
            'binding': binding,
            'deliveryMode': deliveryMode,
            'counterName': counterName,
            'pointsToRedeem': pointsToRedeem,
            'simulatePaymentFailure': simulatePaymentFailure,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_inb42hn4.PrintRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_inb42hn4.PrintRequest> retryPrintPayment(
    _ist.TestSessionBuilder sessionBuilder, {
    required int requestId,
    required bool simulatePaymentFailure,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'library',
            method: 'retryPrintPayment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'library',
          methodName: 'retryPrintPayment',
          parameters: _ist.testObjectToJson({
            'requestId': requestId,
            'simulatePaymentFailure': simulatePaymentFailure,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_inb42hn4.PrintRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_imjfxwqg.PrintPointWallet> getStudentPointWallet(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'library',
            method: 'getStudentPointWallet',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'library',
          methodName: 'getStudentPointWallet',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_imjfxwqg.PrintPointWallet>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i3a0j8k2.PrintPointTransaction>> getPointTransactions(
    _ist.TestSessionBuilder sessionBuilder, {
    required int limit,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'library',
            method: 'getPointTransactions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'library',
          methodName: 'getPointTransactions',
          parameters: _ist.testObjectToJson({'limit': limit}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i3a0j8k2.PrintPointTransaction>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _MomEndpoint {
  _MomEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iecchb3j.MinutesOfMeeting> createMom(
    _ist.TestSessionBuilder sessionBuilder, {
    required String title,
    required DateTime meetingDate,
    required String organizerName,
    required List<String> attendeeNames,
    required String agenda,
    required List<String> discussionPoints,
    required List<String> decisions,
    required List<String> actionItems,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'mom',
            method: 'createMom',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'mom',
          methodName: 'createMom',
          parameters: _ist.testObjectToJson({
            'title': title,
            'meetingDate': meetingDate,
            'organizerName': organizerName,
            'attendeeNames': attendeeNames,
            'agenda': agenda,
            'discussionPoints': discussionPoints,
            'decisions': decisions,
            'actionItems': actionItems,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iecchb3j.MinutesOfMeeting>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iecchb3j.MinutesOfMeeting>> listMoms(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'mom',
            method: 'listMoms',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'mom',
          methodName: 'listMoms',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iecchb3j.MinutesOfMeeting>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iecchb3j.MinutesOfMeeting?> getMomDetail(
    _ist.TestSessionBuilder sessionBuilder,
    int momId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'mom',
            method: 'getMomDetail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'mom',
          methodName: 'getMomDetail',
          parameters: _ist.testObjectToJson({'momId': momId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iecchb3j.MinutesOfMeeting?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _NotificationEndpoint {
  _NotificationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<List<_if8eiets.CampusNotification>> getMyNotifications(
    _ist.TestSessionBuilder sessionBuilder, {
    bool? unreadOnly,
    String? type,
    required int limit,
    required int offset,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'getMyNotifications',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'getMyNotifications',
          parameters: _ist.testObjectToJson({
            'unreadOnly': unreadOnly,
            'type': type,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_if8eiets.CampusNotification>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<int> getUnreadCount(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'getUnreadCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'getUnreadCount',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> markAsRead(
    _ist.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'markAsRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'markAsRead',
          parameters: _ist.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> markAllAsRead(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'markAllAsRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'markAllAsRead',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Stream<_if8eiets.CampusNotification> streamMyNotifications(
    _ist.TestSessionBuilder sessionBuilder,
  ) {
    var _localTestStreamManager =
        _ist.TestStreamManager<_if8eiets.CampusNotification>();
    _ist.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
              endpoint: 'notification',
              method: 'streamMyNotifications',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'notification',
              methodName: 'streamMyNotifications',
              arguments: {},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }
}

class _PointsEndpoint {
  _PointsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<Map<String, dynamic>> checkInWithQrToken(
    _ist.TestSessionBuilder sessionBuilder, {
    required int eventId,
    required String qrToken,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'points',
            method: 'checkInWithQrToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'points',
          methodName: 'checkInWithQrToken',
          parameters: _ist.testObjectToJson({
            'eventId': eventId,
            'qrToken': qrToken,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<Map<String, int>> getMyPointsAndStreak(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'points',
            method: 'getMyPointsAndStreak',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'points',
          methodName: 'getMyPointsAndStreak',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<Map<String, int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i5apij9o.RewardPerk>> listRewards(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'points',
            method: 'listRewards',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'points',
          methodName: 'listRewards',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i5apij9o.RewardPerk>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i5apij9o.RewardPerk> addRewardPerk(
    _ist.TestSessionBuilder sessionBuilder, {
    required String title,
    required String category,
    required String description,
    required int costPoints,
    required int stockRemaining,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'points',
            method: 'addRewardPerk',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'points',
          methodName: 'addRewardPerk',
          parameters: _ist.testObjectToJson({
            'title': title,
            'category': category,
            'description': description,
            'costPoints': costPoints,
            'stockRemaining': stockRemaining,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i5apij9o.RewardPerk>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i5apij9o.RewardPerk>> listAllRewards(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'points',
            method: 'listAllRewards',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'points',
          methodName: 'listAllRewards',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i5apij9o.RewardPerk>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i5apij9o.RewardPerk> updateRewardPerk(
    _ist.TestSessionBuilder sessionBuilder,
    _i5apij9o.RewardPerk perk,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'points',
            method: 'updateRewardPerk',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'points',
          methodName: 'updateRewardPerk',
          parameters: _ist.testObjectToJson({'perk': perk}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i5apij9o.RewardPerk>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> deleteRewardPerk(
    _ist.TestSessionBuilder sessionBuilder,
    int perkId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'points',
            method: 'deleteRewardPerk',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'points',
          methodName: 'deleteRewardPerk',
          parameters: _ist.testObjectToJson({'perkId': perkId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i966awo3.PointsLedger>> listRedemptions(
    _ist.TestSessionBuilder sessionBuilder, {
    required int limit,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'points',
            method: 'listRedemptions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'points',
          methodName: 'listRedemptions',
          parameters: _ist.testObjectToJson({'limit': limit}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i966awo3.PointsLedger>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> redeemReward(
    _ist.TestSessionBuilder sessionBuilder,
    int perkId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'points',
            method: 'redeemReward',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'points',
          methodName: 'redeemReward',
          parameters: _ist.testObjectToJson({'perkId': perkId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _QuizEndpoint {
  _QuizEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<List<_izqbs8j4.QuizQuestionView>> getQuestionsForSubject(
    _ist.TestSessionBuilder sessionBuilder,
    String subject, {
    required int limit,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'quiz',
            method: 'getQuestionsForSubject',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'quiz',
          methodName: 'getQuestionsForSubject',
          parameters: _ist.testObjectToJson({
            'subject': subject,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_izqbs8j4.QuizQuestionView>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iff6nh57.QuizResultSummary> submitQuiz(
    _ist.TestSessionBuilder sessionBuilder,
    _ikt4w0rg.QuizSubmission submission,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'quiz',
            method: 'submitQuiz',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'quiz',
          methodName: 'submitQuiz',
          parameters: _ist.testObjectToJson({'submission': submission}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iff6nh57.QuizResultSummary>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<String>> getRecommendedQuizSubjects(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'quiz',
            method: 'getRecommendedQuizSubjects',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'quiz',
          methodName: 'getRecommendedQuizSubjects',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ii6cu1i5.QuizAttempt>> getMyAttempts(
    _ist.TestSessionBuilder sessionBuilder, {
    String? subject,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'quiz',
            method: 'getMyAttempts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'quiz',
          methodName: 'getMyAttempts',
          parameters: _ist.testObjectToJson({'subject': subject}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ii6cu1i5.QuizAttempt>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SearchEndpoint {
  _SearchEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ia40hk63.SearchResponse> search(
    _ist.TestSessionBuilder sessionBuilder,
    String query, {
    required int limit,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'search',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'search',
          parameters: _ist.testObjectToJson({
            'query': query,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ia40hk63.SearchResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> submitContact(
    _ist.TestSessionBuilder sessionBuilder, {
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'submitContact',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'submitContact',
          parameters: _ist.testObjectToJson({
            'name': name,
            'email': email,
            'subject': subject,
            'message': message,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SeedEndpoint {
  _SeedEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<bool> seedData(_ist.TestSessionBuilder sessionBuilder) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'seed',
            method: 'seedData',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'seed',
          methodName: 'seedData',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _StudentEndpoint {
  _StudentEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iacs.AuthSuccess> loginDemo(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'student',
            method: 'loginDemo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'student',
          methodName: 'loginDemo',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iacs.AuthSuccess> loginDemoStudent2(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'student',
            method: 'loginDemoStudent2',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'student',
          methodName: 'loginDemoStudent2',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iacs.AuthSuccess> registerStudent(
    _ist.TestSessionBuilder sessionBuilder, {
    required String fullName,
    required String email,
    required String password,
    required String branch,
    required int academicYear,
    required String hostelOrArea,
    String? bio,
    required List<String> subjectInterests,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'student',
            method: 'registerStudent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'student',
          methodName: 'registerStudent',
          parameters: _ist.testObjectToJson({
            'fullName': fullName,
            'email': email,
            'password': password,
            'branch': branch,
            'academicYear': academicYear,
            'hostelOrArea': hostelOrArea,
            'bio': bio,
            'subjectInterests': subjectInterests,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iyr83ylc.StudentProfile?> getProfile(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'student',
            method: 'getProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'student',
          methodName: 'getProfile',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iyr83ylc.StudentProfile?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iyr83ylc.StudentProfile> updateProfile(
    _ist.TestSessionBuilder sessionBuilder, {
    required String fullName,
    String? email,
    required String branch,
    required int academicYear,
    required String hostelOrArea,
    String? bio,
    required List<String> subjectInterests,
    List<String>? eventInterests,
    List<String>? preferredQuizSubjects,
    List<String>? preferredQuizTypes,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'student',
            method: 'updateProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'student',
          methodName: 'updateProfile',
          parameters: _ist.testObjectToJson({
            'fullName': fullName,
            'email': email,
            'branch': branch,
            'academicYear': academicYear,
            'hostelOrArea': hostelOrArea,
            'bio': bio,
            'subjectInterests': subjectInterests,
            'eventInterests': eventInterests,
            'preferredQuizSubjects': preferredQuizSubjects,
            'preferredQuizTypes': preferredQuizTypes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iyr83ylc.StudentProfile>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iyr83ylc.StudentProfile> updatePreferences(
    _ist.TestSessionBuilder sessionBuilder, {
    List<String>? eventInterests,
    List<String>? preferredQuizSubjects,
    List<String>? preferredQuizTypes,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'student',
            method: 'updatePreferences',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'student',
          methodName: 'updatePreferences',
          parameters: _ist.testObjectToJson({
            'eventInterests': eventInterests,
            'preferredQuizSubjects': preferredQuizSubjects,
            'preferredQuizTypes': preferredQuizTypes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iyr83ylc.StudentProfile>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iyr83ylc.StudentProfile?> getPublicProfile(
    _ist.TestSessionBuilder sessionBuilder,
    _is.UuidValue authUserId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'student',
            method: 'getPublicProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'student',
          methodName: 'getPublicProfile',
          parameters: _ist.testObjectToJson({'authUserId': authUserId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iyr83ylc.StudentProfile?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iyr83ylc.StudentProfile>> discoverStudents(
    _ist.TestSessionBuilder sessionBuilder, {
    String? branch,
    int? academicYear,
    String? subject,
    String? hostelOrArea,
    required int limit,
    required int offset,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'student',
            method: 'discoverStudents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'student',
          methodName: 'discoverStudents',
          parameters: _ist.testObjectToJson({
            'branch': branch,
            'academicYear': academicYear,
            'subject': subject,
            'hostelOrArea': hostelOrArea,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iyr83ylc.StudentProfile>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _StudyRequestEndpoint {
  _StudyRequestEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_i7nx4e5a.StudyRequest> sendRequest(
    _ist.TestSessionBuilder sessionBuilder, {
    required _is.UuidValue recipientAuthUserId,
    required String subject,
    required String message,
    required String urgency,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyRequest',
            method: 'sendRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyRequest',
          methodName: 'sendRequest',
          parameters: _ist.testObjectToJson({
            'recipientAuthUserId': recipientAuthUserId,
            'subject': subject,
            'message': message,
            'urgency': urgency,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i7nx4e5a.StudyRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i7nx4e5a.StudyRequest>> getMyIncomingRequests(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyRequest',
            method: 'getMyIncomingRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyRequest',
          methodName: 'getMyIncomingRequests',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i7nx4e5a.StudyRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i7nx4e5a.StudyRequest>> getMyOutgoingRequests(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyRequest',
            method: 'getMyOutgoingRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyRequest',
          methodName: 'getMyOutgoingRequests',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i7nx4e5a.StudyRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i7nx4e5a.StudyRequest> updateRequestStatus(
    _ist.TestSessionBuilder sessionBuilder, {
    required int requestId,
    required String newStatus,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyRequest',
            method: 'updateRequestStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyRequest',
          methodName: 'updateRequestStatus',
          parameters: _ist.testObjectToJson({
            'requestId': requestId,
            'newStatus': newStatus,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i7nx4e5a.StudyRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _TimetableEndpoint {
  _TimetableEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_i6o9odyo.SectionTimetable> addSectionTimetable(
    _ist.TestSessionBuilder sessionBuilder, {
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
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timetable',
            method: 'addSectionTimetable',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timetable',
          methodName: 'addSectionTimetable',
          parameters: _ist.testObjectToJson({
            'branch': branch,
            'academicYear': academicYear,
            'semester': semester,
            'section': section,
            'dayOfWeek': dayOfWeek,
            'startTime': startTime,
            'endTime': endTime,
            'subject': subject,
            'room': room,
            'faculty': faculty,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i6o9odyo.SectionTimetable>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i6o9odyo.SectionTimetable> updateSectionTimetable(
    _ist.TestSessionBuilder sessionBuilder,
    _i6o9odyo.SectionTimetable entry,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timetable',
            method: 'updateSectionTimetable',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timetable',
          methodName: 'updateSectionTimetable',
          parameters: _ist.testObjectToJson({'entry': entry}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i6o9odyo.SectionTimetable>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> deleteSectionTimetable(
    _ist.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timetable',
            method: 'deleteSectionTimetable',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timetable',
          methodName: 'deleteSectionTimetable',
          parameters: _ist.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i6o9odyo.SectionTimetable>> listAllTimetables(
    _ist.TestSessionBuilder sessionBuilder, {
    String? branch,
    int? semester,
    String? section,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timetable',
            method: 'listAllTimetables',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timetable',
          methodName: 'listAllTimetables',
          parameters: _ist.testObjectToJson({
            'branch': branch,
            'semester': semester,
            'section': section,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i6o9odyo.SectionTimetable>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i6o9odyo.SectionTimetable>> getSectionTimetable(
    _ist.TestSessionBuilder sessionBuilder, {
    required String branch,
    required int semester,
    required String section,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timetable',
            method: 'getSectionTimetable',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timetable',
          methodName: 'getSectionTimetable',
          parameters: _ist.testObjectToJson({
            'branch': branch,
            'semester': semester,
            'section': section,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i6o9odyo.SectionTimetable>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iegmdz27.StudentFreeSlot>> getMyFreeSlots(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timetable',
            method: 'getMyFreeSlots',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timetable',
          methodName: 'getMyFreeSlots',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iegmdz27.StudentFreeSlot>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iegmdz27.StudentFreeSlot> updateFreeSlot(
    _ist.TestSessionBuilder sessionBuilder, {
    required String dayOfWeek,
    required String slotLabel,
    required String startTime,
    required String endTime,
    required bool isFree,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timetable',
            method: 'updateFreeSlot',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timetable',
          methodName: 'updateFreeSlot',
          parameters: _ist.testObjectToJson({
            'dayOfWeek': dayOfWeek,
            'slotLabel': slotLabel,
            'startTime': startTime,
            'endTime': endTime,
            'isFree': isFree,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iegmdz27.StudentFreeSlot>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> clearFreeSlot(
    _ist.TestSessionBuilder sessionBuilder, {
    required String dayOfWeek,
    required String slotLabel,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timetable',
            method: 'clearFreeSlot',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timetable',
          methodName: 'clearFreeSlot',
          parameters: _ist.testObjectToJson({
            'dayOfWeek': dayOfWeek,
            'slotLabel': slotLabel,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<Map<String, dynamic>>> findTimetableStudyMatches(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timetable',
            method: 'findTimetableStudyMatches',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timetable',
          methodName: 'findTimetableStudyMatches',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<Map<String, dynamic>>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _GreetingEndpoint {
  _GreetingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iwzyf8be.Greeting> hello(
    _ist.TestSessionBuilder sessionBuilder,
    String name,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'greeting',
            method: 'hello',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'greeting',
          methodName: 'hello',
          parameters: _ist.testObjectToJson({'name': name}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iwzyf8be.Greeting>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}
