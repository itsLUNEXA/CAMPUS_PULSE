/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:campus_pulse_server/src/generated/campus_event.dart'
    as _iw7ccsb7;
import 'package:campus_pulse_server/src/generated/leaderboard_entry.dart'
    as _izc9hvlj;
import 'package:campus_pulse_server/src/generated/quiz_question.dart'
    as _i1r5tjyq;
import 'package:campus_pulse_server/src/generated/student.dart' as _icykbxw6;
import 'package:campus_pulse_server/src/generated/study_request.dart'
    as _i7nx4e5a;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i1n3uhu0;
import 'auth_response.dart' as _iuyz7l8a;
import 'campus_event.dart' as _ieh998j0;
import 'leaderboard_entry.dart' as _ikawkn1p;
import 'quiz_question.dart' as _i6b38qpb;
import 'quiz_score.dart' as _i1zsnnvu;
import 'rsvp.dart' as _ix8ad6lg;
import 'rsvp_update.dart' as _i9l2hi6q;
import 'student.dart' as _iwzlgl4r;
import 'study_request.dart' as _i2p0wucy;
export 'auth_response.dart';
export 'campus_event.dart';
export 'leaderboard_entry.dart';
export 'quiz_question.dart';
export 'quiz_score.dart';
export 'rsvp.dart';
export 'rsvp_update.dart';
export 'student.dart';
export 'study_request.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
        _isp.TableDefinition(
          name: 'campus_event',
          dartName: 'CampusEvent',
          schema: 'public',
          module: 'campus_pulse',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'title',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'description',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'category',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'venue',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'startTime',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
            _isp.ColumnDefinition(
              name: 'createdBy',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'rsvpCount',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
              columnDefault: '0',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        ),
        _isp.TableDefinition(
          name: 'quiz_question',
          dartName: 'QuizQuestion',
          schema: 'public',
          module: 'campus_pulse',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'subject',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'question',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'options',
              columnType: _isp.ColumnType.json,
              isNullable: false,
              dartType: 'List<String>',
            ),
            _isp.ColumnDefinition(
              name: 'correctIndex',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        ),
        _isp.TableDefinition(
          name: 'quiz_score',
          dartName: 'QuizScore',
          schema: 'public',
          module: 'campus_pulse',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'studentId',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'subject',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'score',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'createdAt',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        ),
        _isp.TableDefinition(
          name: 'rsvp',
          dartName: 'Rsvp',
          schema: 'public',
          module: 'campus_pulse',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'studentId',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'eventId',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
          ],
          foreignKeys: [],
          indexes: [
            _isp.IndexDefinition(
              indexName: 'student_event_unique_idx',
              tableSpace: null,
              elements: [
                _isp.IndexElementDefinition(
                  type: _isp.IndexElementDefinitionType.column,
                  definition: 'studentId',
                ),
                _isp.IndexElementDefinition(
                  type: _isp.IndexElementDefinitionType.column,
                  definition: 'eventId',
                ),
              ],
              type: 'btree',
              isUnique: true,
              isPrimary: false,
            )
          ],
          managed: true,
        ),
        _isp.TableDefinition(
          name: 'student',
          dartName: 'Student',
          schema: 'public',
          module: 'campus_pulse',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'name',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'email',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'passwordHash',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
            _isp.ColumnDefinition(
              name: 'branch',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'year',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'interests',
              columnType: _isp.ColumnType.json,
              isNullable: false,
              dartType: 'List<String>',
            ),
            _isp.ColumnDefinition(
              name: 'hostelArea',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        ),
        _isp.TableDefinition(
          name: 'study_request',
          dartName: 'StudyRequest',
          schema: 'public',
          module: 'campus_pulse',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'studentId',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int',
            ),
            _isp.ColumnDefinition(
              name: 'studentName',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
            _isp.ColumnDefinition(
              name: 'branch',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
            _isp.ColumnDefinition(
              name: 'subject',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'location',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'status',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
              columnDefault: '\'open\'',
            ),
            _isp.ColumnDefinition(
              name: 'createdAt',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        ),
        ..._i1n3uhu0.Protocol.targetTableDefinitions,
        ..._isp.Protocol.targetTableDefinitions,
      ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iuyz7l8a.AuthResponse) {
      return _iuyz7l8a.AuthResponse.fromJson(data) as T;
    }
    if (t == _ieh998j0.CampusEvent) {
      return _ieh998j0.CampusEvent.fromJson(data) as T;
    }
    if (t == _ikawkn1p.LeaderboardEntry) {
      return _ikawkn1p.LeaderboardEntry.fromJson(data) as T;
    }
    if (t == _i6b38qpb.QuizQuestion) {
      return _i6b38qpb.QuizQuestion.fromJson(data) as T;
    }
    if (t == _i1zsnnvu.QuizScore) {
      return _i1zsnnvu.QuizScore.fromJson(data) as T;
    }
    if (t == _ix8ad6lg.Rsvp) {
      return _ix8ad6lg.Rsvp.fromJson(data) as T;
    }
    if (t == _i9l2hi6q.RsvpUpdate) {
      return _i9l2hi6q.RsvpUpdate.fromJson(data) as T;
    }
    if (t == _iwzlgl4r.Student) {
      return _iwzlgl4r.Student.fromJson(data) as T;
    }
    if (t == _i2p0wucy.StudyRequest) {
      return _i2p0wucy.StudyRequest.fromJson(data) as T;
    }
    if (t == _is.getType<_iuyz7l8a.AuthResponse?>()) {
      return (data != null ? _iuyz7l8a.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ieh998j0.CampusEvent?>()) {
      return (data != null ? _ieh998j0.CampusEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikawkn1p.LeaderboardEntry?>()) {
      return (data != null ? _ikawkn1p.LeaderboardEntry.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6b38qpb.QuizQuestion?>()) {
      return (data != null ? _i6b38qpb.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1zsnnvu.QuizScore?>()) {
      return (data != null ? _i1zsnnvu.QuizScore.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ix8ad6lg.Rsvp?>()) {
      return (data != null ? _ix8ad6lg.Rsvp.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i9l2hi6q.RsvpUpdate?>()) {
      return (data != null ? _i9l2hi6q.RsvpUpdate.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwzlgl4r.Student?>()) {
      return (data != null ? _iwzlgl4r.Student.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2p0wucy.StudyRequest?>()) {
      return (data != null ? _i2p0wucy.StudyRequest.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_icykbxw6.Student>) {
      return (data as List)
          .map((e) => deserialize<_icykbxw6.Student>(e))
          .toList() as T;
    }
    if (t == List<_i7nx4e5a.StudyRequest>) {
      return (data as List)
          .map((e) => deserialize<_i7nx4e5a.StudyRequest>(e))
          .toList() as T;
    }
    if (t == List<_iw7ccsb7.CampusEvent>) {
      return (data as List)
          .map((e) => deserialize<_iw7ccsb7.CampusEvent>(e))
          .toList() as T;
    }
    if (t == List<_i1r5tjyq.QuizQuestion>) {
      return (data as List)
          .map((e) => deserialize<_i1r5tjyq.QuizQuestion>(e))
          .toList() as T;
    }
    if (t == List<_izc9hvlj.LeaderboardEntry>) {
      return (data as List)
          .map((e) => deserialize<_izc9hvlj.LeaderboardEntry>(e))
          .toList() as T;
    }
    try {
      return _i1n3uhu0.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iuyz7l8a.AuthResponse => 'AuthResponse',
      _ieh998j0.CampusEvent => 'CampusEvent',
      _ikawkn1p.LeaderboardEntry => 'LeaderboardEntry',
      _i6b38qpb.QuizQuestion => 'QuizQuestion',
      _i1zsnnvu.QuizScore => 'QuizScore',
      _ix8ad6lg.Rsvp => 'Rsvp',
      _i9l2hi6q.RsvpUpdate => 'RsvpUpdate',
      _iwzlgl4r.Student => 'Student',
      _i2p0wucy.StudyRequest => 'StudyRequest',
      _ => null
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String)
          .replaceFirst('campus_pulse.', '');
    }

    switch (data) {
      case _iuyz7l8a.AuthResponse():
        return 'AuthResponse';
      case _ieh998j0.CampusEvent():
        return 'CampusEvent';
      case _ikawkn1p.LeaderboardEntry():
        return 'LeaderboardEntry';
      case _i6b38qpb.QuizQuestion():
        return 'QuizQuestion';
      case _i1zsnnvu.QuizScore():
        return 'QuizScore';
      case _ix8ad6lg.Rsvp():
        return 'Rsvp';
      case _i9l2hi6q.RsvpUpdate():
        return 'RsvpUpdate';
      case _iwzlgl4r.Student():
        return 'Student';
      case _i2p0wucy.StudyRequest():
        return 'StudyRequest';
    }
    className = _i1n3uhu0.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod_auth.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AuthResponse') {
      return deserialize<_iuyz7l8a.AuthResponse>(data['data']);
    }
    if (dataClassName == 'CampusEvent') {
      return deserialize<_ieh998j0.CampusEvent>(data['data']);
    }
    if (dataClassName == 'LeaderboardEntry') {
      return deserialize<_ikawkn1p.LeaderboardEntry>(data['data']);
    }
    if (dataClassName == 'QuizQuestion') {
      return deserialize<_i6b38qpb.QuizQuestion>(data['data']);
    }
    if (dataClassName == 'QuizScore') {
      return deserialize<_i1zsnnvu.QuizScore>(data['data']);
    }
    if (dataClassName == 'Rsvp') {
      return deserialize<_ix8ad6lg.Rsvp>(data['data']);
    }
    if (dataClassName == 'RsvpUpdate') {
      return deserialize<_i9l2hi6q.RsvpUpdate>(data['data']);
    }
    if (dataClassName == 'Student') {
      return deserialize<_iwzlgl4r.Student>(data['data']);
    }
    if (dataClassName == 'StudyRequest') {
      return deserialize<_i2p0wucy.StudyRequest>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i1n3uhu0.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _i1n3uhu0.Protocol().registerHostProtocol('campus_pulse', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _i1n3uhu0.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ieh998j0.CampusEvent:
        return _ieh998j0.CampusEvent.t;
      case _i6b38qpb.QuizQuestion:
        return _i6b38qpb.QuizQuestion.t;
      case _i1zsnnvu.QuizScore:
        return _i1zsnnvu.QuizScore.t;
      case _ix8ad6lg.Rsvp:
        return _ix8ad6lg.Rsvp.t;
      case _iwzlgl4r.Student:
        return _iwzlgl4r.Student.t;
      case _i2p0wucy.StudyRequest:
        return _i2p0wucy.StudyRequest.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'campus_pulse';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i1n3uhu0.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
