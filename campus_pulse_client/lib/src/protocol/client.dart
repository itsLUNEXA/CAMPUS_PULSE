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
import 'package:campus_pulse_client/src/protocol/auth_response.dart'
    as _izd9c06b;
import 'package:campus_pulse_client/src/protocol/campus_event.dart'
    as _ip4v6fvs;
import 'package:campus_pulse_client/src/protocol/leaderboard_entry.dart'
    as _ipx1rsvs;
import 'package:campus_pulse_client/src/protocol/quiz_question.dart'
    as _ivshswis;
import 'package:campus_pulse_client/src/protocol/quiz_score.dart' as _i0xrn3ib;
import 'package:campus_pulse_client/src/protocol/rsvp_update.dart' as _i2m6gzec;
import 'package:campus_pulse_client/src/protocol/student.dart' as _it3wm15m;
import 'package:campus_pulse_client/src/protocol/study_request.dart'
    as _i18m6utc;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i312scxx;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointAuth extends _isc.EndpointRef {
  EndpointAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _ida.Future<_izd9c06b.AuthResponse> signup({
    required String name,
    required String email,
    required String password,
    required String branch,
    required int year,
    required List<String> interests,
    required String hostelArea,
  }) =>
      caller.callServerEndpoint<_izd9c06b.AuthResponse>(
        'auth',
        'signup',
        {
          'name': name,
          'email': email,
          'password': password,
          'branch': branch,
          'year': year,
          'interests': interests,
          'hostelArea': hostelArea,
        },
      );

  _ida.Future<_izd9c06b.AuthResponse> login({
    required String email,
    required String password,
  }) =>
      caller.callServerEndpoint<_izd9c06b.AuthResponse>(
        'auth',
        'login',
        {
          'email': email,
          'password': password,
        },
      );

  _ida.Future<_it3wm15m.Student?> getProfile(int studentId) =>
      caller.callServerEndpoint<_it3wm15m.Student?>(
        'auth',
        'getProfile',
        {'studentId': studentId},
      );
}

/// {@category Endpoint}
class EndpointBuddy extends _isc.EndpointRef {
  EndpointBuddy(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'buddy';

  _ida.Future<List<_it3wm15m.Student>> findBuddies({
    required String subject,
    required String location,
  }) =>
      caller.callServerEndpoint<List<_it3wm15m.Student>>(
        'buddy',
        'findBuddies',
        {
          'subject': subject,
          'location': location,
        },
      );

  _ida.Future<_i18m6utc.StudyRequest> createRequest(
          _i18m6utc.StudyRequest request) =>
      caller.callServerEndpoint<_i18m6utc.StudyRequest>(
        'buddy',
        'createRequest',
        {'request': request},
      );

  _ida.Future<List<_i18m6utc.StudyRequest>> getRequests({String? subject}) =>
      caller.callServerEndpoint<List<_i18m6utc.StudyRequest>>(
        'buddy',
        'getRequests',
        {'subject': subject},
      );
}

/// {@category Endpoint}
class EndpointEvent extends _isc.EndpointRef {
  EndpointEvent(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'event';

  _ida.Future<List<_ip4v6fvs.CampusEvent>> getFeed({String? categoryFilter}) =>
      caller.callServerEndpoint<List<_ip4v6fvs.CampusEvent>>(
        'event',
        'getFeed',
        {'categoryFilter': categoryFilter},
      );

  _ida.Future<_ip4v6fvs.CampusEvent> createEvent(_ip4v6fvs.CampusEvent event) =>
      caller.callServerEndpoint<_ip4v6fvs.CampusEvent>(
        'event',
        'createEvent',
        {'event': event},
      );

  _ida.Future<_i2m6gzec.RsvpUpdate> rsvp({
    required int eventId,
    required int studentId,
  }) =>
      caller.callServerEndpoint<_i2m6gzec.RsvpUpdate>(
        'event',
        'rsvp',
        {
          'eventId': eventId,
          'studentId': studentId,
        },
      );
}

/// {@category Endpoint}
class EndpointQuiz extends _isc.EndpointRef {
  EndpointQuiz(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'quiz';

  _ida.Future<List<_ivshswis.QuizQuestion>> getQuestions(
          {required String subject}) =>
      caller.callServerEndpoint<List<_ivshswis.QuizQuestion>>(
        'quiz',
        'getQuestions',
        {'subject': subject},
      );

  _ida.Future<_i0xrn3ib.QuizScore> submitScore({
    required int studentId,
    required String subject,
    required int score,
  }) =>
      caller.callServerEndpoint<_i0xrn3ib.QuizScore>(
        'quiz',
        'submitScore',
        {
          'studentId': studentId,
          'subject': subject,
          'score': score,
        },
      );

  _ida.Future<List<_ipx1rsvs.LeaderboardEntry>> getLeaderboard(
          {String? subject}) =>
      caller.callServerEndpoint<List<_ipx1rsvs.LeaderboardEntry>>(
        'quiz',
        'getLeaderboard',
        {'subject': subject},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i312scxx.Caller(client);
  }

  late final _i312scxx.Caller auth;
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
    )? onFailedCall,
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
    auth = EndpointAuth(this);
    buddy = EndpointBuddy(this);
    event = EndpointEvent(this);
    quiz = EndpointQuiz(this);
    modules = Modules(this);
  }

  late final EndpointAuth auth;

  late final EndpointBuddy buddy;

  late final EndpointEvent event;

  late final EndpointQuiz quiz;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'buddy': buddy,
        'event': event,
        'quiz': quiz,
      };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
