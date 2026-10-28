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
import 'package:campus_pulse_server/src/generated/campus_event.dart'
    as _iw7ccsb7;
import 'package:campus_pulse_server/src/generated/study_request.dart'
    as _i7nx4e5a;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i1n3uhu0;
import '../endpoints/auth_endpoint.dart' as _iyggisn2;
import '../endpoints/buddy_endpoint.dart' as _ij8zf0ju;
import '../endpoints/event_endpoint.dart' as _icw8lb6p;
import '../endpoints/quiz_endpoint.dart' as _i7z0uw2a;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'auth': _iyggisn2.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'buddy': _ij8zf0ju.BuddyEndpoint()
        ..initialize(
          server,
          'buddy',
          null,
        ),
      'event': _icw8lb6p.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'quiz': _i7z0uw2a.QuizEndpoint()
        ..initialize(
          server,
          'quiz',
          null,
        ),
    };
    connectors['auth'] = _is.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'signup': _is.MethodConnector(
          name: 'signup',
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
            'year': _is.ParameterDescription(
              name: 'year',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'interests': _is.ParameterDescription(
              name: 'interests',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'hostelArea': _is.ParameterDescription(
              name: 'hostelArea',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _iyggisn2.AuthEndpoint).signup(
            session,
            name: params['name'],
            email: params['email'],
            password: params['password'],
            branch: params['branch'],
            year: params['year'],
            interests: params['interests'],
            hostelArea: params['hostelArea'],
          ),
        ),
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
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _iyggisn2.AuthEndpoint).login(
            session,
            email: params['email'],
            password: params['password'],
          ),
        ),
        'getProfile': _is.MethodConnector(
          name: 'getProfile',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _iyggisn2.AuthEndpoint).getProfile(
            session,
            params['studentId'],
          ),
        ),
      },
    );
    connectors['buddy'] = _is.EndpointConnector(
      name: 'buddy',
      endpoint: endpoints['buddy']!,
      methodConnectors: {
        'findBuddies': _is.MethodConnector(
          name: 'findBuddies',
          params: {
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'location': _is.ParameterDescription(
              name: 'location',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['buddy'] as _ij8zf0ju.BuddyEndpoint).findBuddies(
            session,
            subject: params['subject'],
            location: params['location'],
          ),
        ),
        'createRequest': _is.MethodConnector(
          name: 'createRequest',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i7nx4e5a.StudyRequest>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['buddy'] as _ij8zf0ju.BuddyEndpoint).createRequest(
            session,
            params['request'],
          ),
        ),
        'getRequests': _is.MethodConnector(
          name: 'getRequests',
          params: {
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String?>(),
              nullable: true,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['buddy'] as _ij8zf0ju.BuddyEndpoint).getRequests(
            session,
            subject: params['subject'],
          ),
        ),
      },
    );
    connectors['event'] = _is.EndpointConnector(
      name: 'event',
      endpoint: endpoints['event']!,
      methodConnectors: {
        'getFeed': _is.MethodConnector(
          name: 'getFeed',
          params: {
            'categoryFilter': _is.ParameterDescription(
              name: 'categoryFilter',
              type: _is.getType<String?>(),
              nullable: true,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['event'] as _icw8lb6p.EventEndpoint).getFeed(
            session,
            categoryFilter: params['categoryFilter'],
          ),
        ),
        'createEvent': _is.MethodConnector(
          name: 'createEvent',
          params: {
            'event': _is.ParameterDescription(
              name: 'event',
              type: _is.getType<_iw7ccsb7.CampusEvent>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['event'] as _icw8lb6p.EventEndpoint).createEvent(
            session,
            params['event'],
          ),
        ),
        'rsvp': _is.MethodConnector(
          name: 'rsvp',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['event'] as _icw8lb6p.EventEndpoint).rsvp(
            session,
            eventId: params['eventId'],
            studentId: params['studentId'],
          ),
        ),
      },
    );
    connectors['quiz'] = _is.EndpointConnector(
      name: 'quiz',
      endpoint: endpoints['quiz']!,
      methodConnectors: {
        'getQuestions': _is.MethodConnector(
          name: 'getQuestions',
          params: {
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quiz'] as _i7z0uw2a.QuizEndpoint).getQuestions(
            session,
            subject: params['subject'],
          ),
        ),
        'submitScore': _is.MethodConnector(
          name: 'submitScore',
          params: {
            'studentId': _is.ParameterDescription(
              name: 'studentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'score': _is.ParameterDescription(
              name: 'score',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quiz'] as _i7z0uw2a.QuizEndpoint).submitScore(
            session,
            studentId: params['studentId'],
            subject: params['subject'],
            score: params['score'],
          ),
        ),
        'getLeaderboard': _is.MethodConnector(
          name: 'getLeaderboard',
          params: {
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String?>(),
              nullable: true,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quiz'] as _i7z0uw2a.QuizEndpoint).getLeaderboard(
            session,
            subject: params['subject'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i1n3uhu0.Endpoints()
      ..initializeEndpoints(server);
  }
}
