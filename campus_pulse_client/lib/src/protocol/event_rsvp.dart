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
import 'package:campus_pulse_client/src/protocol/protocol.dart' as _il98xzab;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class EventRsvp
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EventRsvp._({
    this.id,
    required this.eventId,
    required this.authUserId,
    required this.studentName,
    this.teamName,
    this.teamMemberNames,
    this.teamMemberEmails,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory EventRsvp({
    int? id,
    required int eventId,
    required _isc.UuidValue authUserId,
    required String studentName,
    String? teamName,
    List<String>? teamMemberNames,
    List<String>? teamMemberEmails,
    DateTime? createdAt,
  }) = _EventRsvpImpl;

  factory EventRsvp.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventRsvp(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      teamName: jsonSerialization['teamName'] as String?,
      teamMemberNames: jsonSerialization['teamMemberNames'] == null
          ? null
          : _il98xzab.Protocol().deserialize<List<String>>(
              jsonSerialization['teamMemberNames'],
            ),
      teamMemberEmails: jsonSerialization['teamMemberEmails'] == null
          ? null
          : _il98xzab.Protocol().deserialize<List<String>>(
              jsonSerialization['teamMemberEmails'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int eventId;

  _isc.UuidValue authUserId;

  String studentName;

  String? teamName;

  List<String>? teamMemberNames;

  List<String>? teamMemberEmails;

  DateTime createdAt;

  /// Returns a shallow copy of this [EventRsvp]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EventRsvp copyWith({
    int? id,
    int? eventId,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? teamName,
    List<String>? teamMemberNames,
    List<String>? teamMemberEmails,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventRsvp',
      if (id != null) 'id': id,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      if (teamName != null) 'teamName': teamName,
      if (teamMemberNames != null) 'teamMemberNames': teamMemberNames?.toJson(),
      if (teamMemberEmails != null)
        'teamMemberEmails': teamMemberEmails?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventRsvp',
      if (id != null) 'id': id,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      if (teamName != null) 'teamName': teamName,
      if (teamMemberNames != null) 'teamMemberNames': teamMemberNames?.toJson(),
      if (teamMemberEmails != null)
        'teamMemberEmails': teamMemberEmails?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventRsvpImpl extends EventRsvp {
  _EventRsvpImpl({
    int? id,
    required int eventId,
    required _isc.UuidValue authUserId,
    required String studentName,
    String? teamName,
    List<String>? teamMemberNames,
    List<String>? teamMemberEmails,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         authUserId: authUserId,
         studentName: studentName,
         teamName: teamName,
         teamMemberNames: teamMemberNames,
         teamMemberEmails: teamMemberEmails,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EventRsvp]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EventRsvp copyWith({
    Object? id = _Undefined,
    int? eventId,
    _isc.UuidValue? authUserId,
    String? studentName,
    Object? teamName = _Undefined,
    Object? teamMemberNames = _Undefined,
    Object? teamMemberEmails = _Undefined,
    DateTime? createdAt,
  }) {
    return EventRsvp(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      teamName: teamName is String? ? teamName : this.teamName,
      teamMemberNames: teamMemberNames is List<String>?
          ? teamMemberNames
          : this.teamMemberNames?.map((e0) => e0).toList(),
      teamMemberEmails: teamMemberEmails is List<String>?
          ? teamMemberEmails
          : this.teamMemberEmails?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
