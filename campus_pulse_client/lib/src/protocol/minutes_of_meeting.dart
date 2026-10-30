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

abstract class MinutesOfMeeting
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MinutesOfMeeting._({
    this.id,
    required this.title,
    required this.meetingDate,
    required this.organizerUserId,
    required this.organizerName,
    required this.attendeeNames,
    required this.agenda,
    required this.discussionPoints,
    required this.decisions,
    required this.actionItems,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory MinutesOfMeeting({
    int? id,
    required String title,
    required DateTime meetingDate,
    required _isc.UuidValue organizerUserId,
    required String organizerName,
    required List<String> attendeeNames,
    required String agenda,
    required List<String> discussionPoints,
    required List<String> decisions,
    required List<String> actionItems,
    DateTime? createdAt,
  }) = _MinutesOfMeetingImpl;

  factory MinutesOfMeeting.fromJson(Map<String, dynamic> jsonSerialization) {
    return MinutesOfMeeting(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      meetingDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['meetingDate'],
      ),
      organizerUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizerUserId'],
      ),
      organizerName: jsonSerialization['organizerName'] as String,
      attendeeNames: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['attendeeNames'],
      ),
      agenda: jsonSerialization['agenda'] as String,
      discussionPoints: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['discussionPoints'],
      ),
      decisions: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['decisions'],
      ),
      actionItems: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['actionItems'],
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

  String title;

  DateTime meetingDate;

  _isc.UuidValue organizerUserId;

  String organizerName;

  List<String> attendeeNames;

  String agenda;

  List<String> discussionPoints;

  List<String> decisions;

  List<String> actionItems;

  DateTime createdAt;

  /// Returns a shallow copy of this [MinutesOfMeeting]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MinutesOfMeeting copyWith({
    int? id,
    String? title,
    DateTime? meetingDate,
    _isc.UuidValue? organizerUserId,
    String? organizerName,
    List<String>? attendeeNames,
    String? agenda,
    List<String>? discussionPoints,
    List<String>? decisions,
    List<String>? actionItems,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MinutesOfMeeting',
      if (id != null) 'id': id,
      'title': title,
      'meetingDate': meetingDate.toJson(),
      'organizerUserId': organizerUserId.toJson(),
      'organizerName': organizerName,
      'attendeeNames': attendeeNames.toJson(),
      'agenda': agenda,
      'discussionPoints': discussionPoints.toJson(),
      'decisions': decisions.toJson(),
      'actionItems': actionItems.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MinutesOfMeeting',
      if (id != null) 'id': id,
      'title': title,
      'meetingDate': meetingDate.toJson(),
      'organizerUserId': organizerUserId.toJson(),
      'organizerName': organizerName,
      'attendeeNames': attendeeNames.toJson(),
      'agenda': agenda,
      'discussionPoints': discussionPoints.toJson(),
      'decisions': decisions.toJson(),
      'actionItems': actionItems.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MinutesOfMeetingImpl extends MinutesOfMeeting {
  _MinutesOfMeetingImpl({
    int? id,
    required String title,
    required DateTime meetingDate,
    required _isc.UuidValue organizerUserId,
    required String organizerName,
    required List<String> attendeeNames,
    required String agenda,
    required List<String> discussionPoints,
    required List<String> decisions,
    required List<String> actionItems,
    DateTime? createdAt,
  }) : super._(
         id: id,
         title: title,
         meetingDate: meetingDate,
         organizerUserId: organizerUserId,
         organizerName: organizerName,
         attendeeNames: attendeeNames,
         agenda: agenda,
         discussionPoints: discussionPoints,
         decisions: decisions,
         actionItems: actionItems,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MinutesOfMeeting]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MinutesOfMeeting copyWith({
    Object? id = _Undefined,
    String? title,
    DateTime? meetingDate,
    _isc.UuidValue? organizerUserId,
    String? organizerName,
    List<String>? attendeeNames,
    String? agenda,
    List<String>? discussionPoints,
    List<String>? decisions,
    List<String>? actionItems,
    DateTime? createdAt,
  }) {
    return MinutesOfMeeting(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      meetingDate: meetingDate ?? this.meetingDate,
      organizerUserId: organizerUserId ?? this.organizerUserId,
      organizerName: organizerName ?? this.organizerName,
      attendeeNames:
          attendeeNames ?? this.attendeeNames.map((e0) => e0).toList(),
      agenda: agenda ?? this.agenda,
      discussionPoints:
          discussionPoints ?? this.discussionPoints.map((e0) => e0).toList(),
      decisions: decisions ?? this.decisions.map((e0) => e0).toList(),
      actionItems: actionItems ?? this.actionItems.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
