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

abstract class ChatRoom
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChatRoom._({
    this.id,
    required this.roomType,
    this.referenceId,
    required this.name,
    this.description,
    this.topic,
    this.creatorAuthUserId,
    required this.participantIds,
    this.allowedBranch,
    this.allowedAcademicYear,
    DateTime? createdAt,
    this.lastMessageText,
    this.lastMessageAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ChatRoom({
    int? id,
    required String roomType,
    String? referenceId,
    required String name,
    String? description,
    String? topic,
    _isc.UuidValue? creatorAuthUserId,
    required List<_isc.UuidValue> participantIds,
    String? allowedBranch,
    int? allowedAcademicYear,
    DateTime? createdAt,
    String? lastMessageText,
    DateTime? lastMessageAt,
  }) = _ChatRoomImpl;

  factory ChatRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatRoom(
      id: jsonSerialization['id'] as int?,
      roomType: jsonSerialization['roomType'] as String,
      referenceId: jsonSerialization['referenceId'] as String?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      topic: jsonSerialization['topic'] as String?,
      creatorAuthUserId: jsonSerialization['creatorAuthUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['creatorAuthUserId'],
            ),
      participantIds: _il98xzab.Protocol().deserialize<List<_isc.UuidValue>>(
        jsonSerialization['participantIds'],
      ),
      allowedBranch: jsonSerialization['allowedBranch'] as String?,
      allowedAcademicYear: jsonSerialization['allowedAcademicYear'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastMessageText: jsonSerialization['lastMessageText'] as String?,
      lastMessageAt: jsonSerialization['lastMessageAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastMessageAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String roomType;

  String? referenceId;

  String name;

  String? description;

  String? topic;

  _isc.UuidValue? creatorAuthUserId;

  List<_isc.UuidValue> participantIds;

  String? allowedBranch;

  int? allowedAcademicYear;

  DateTime createdAt;

  String? lastMessageText;

  DateTime? lastMessageAt;

  /// Returns a shallow copy of this [ChatRoom]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChatRoom copyWith({
    int? id,
    String? roomType,
    String? referenceId,
    String? name,
    String? description,
    String? topic,
    _isc.UuidValue? creatorAuthUserId,
    List<_isc.UuidValue>? participantIds,
    String? allowedBranch,
    int? allowedAcademicYear,
    DateTime? createdAt,
    String? lastMessageText,
    DateTime? lastMessageAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatRoom',
      if (id != null) 'id': id,
      'roomType': roomType,
      if (referenceId != null) 'referenceId': referenceId,
      'name': name,
      if (description != null) 'description': description,
      if (topic != null) 'topic': topic,
      if (creatorAuthUserId != null)
        'creatorAuthUserId': creatorAuthUserId?.toJson(),
      'participantIds': participantIds.toJson(valueToJson: (v) => v.toJson()),
      if (allowedBranch != null) 'allowedBranch': allowedBranch,
      if (allowedAcademicYear != null)
        'allowedAcademicYear': allowedAcademicYear,
      'createdAt': createdAt.toJson(),
      if (lastMessageText != null) 'lastMessageText': lastMessageText,
      if (lastMessageAt != null) 'lastMessageAt': lastMessageAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatRoom',
      if (id != null) 'id': id,
      'roomType': roomType,
      if (referenceId != null) 'referenceId': referenceId,
      'name': name,
      if (description != null) 'description': description,
      if (topic != null) 'topic': topic,
      if (creatorAuthUserId != null)
        'creatorAuthUserId': creatorAuthUserId?.toJson(),
      'participantIds': participantIds.toJson(valueToJson: (v) => v.toJson()),
      if (allowedBranch != null) 'allowedBranch': allowedBranch,
      if (allowedAcademicYear != null)
        'allowedAcademicYear': allowedAcademicYear,
      'createdAt': createdAt.toJson(),
      if (lastMessageText != null) 'lastMessageText': lastMessageText,
      if (lastMessageAt != null) 'lastMessageAt': lastMessageAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatRoomImpl extends ChatRoom {
  _ChatRoomImpl({
    int? id,
    required String roomType,
    String? referenceId,
    required String name,
    String? description,
    String? topic,
    _isc.UuidValue? creatorAuthUserId,
    required List<_isc.UuidValue> participantIds,
    String? allowedBranch,
    int? allowedAcademicYear,
    DateTime? createdAt,
    String? lastMessageText,
    DateTime? lastMessageAt,
  }) : super._(
         id: id,
         roomType: roomType,
         referenceId: referenceId,
         name: name,
         description: description,
         topic: topic,
         creatorAuthUserId: creatorAuthUserId,
         participantIds: participantIds,
         allowedBranch: allowedBranch,
         allowedAcademicYear: allowedAcademicYear,
         createdAt: createdAt,
         lastMessageText: lastMessageText,
         lastMessageAt: lastMessageAt,
       );

  /// Returns a shallow copy of this [ChatRoom]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChatRoom copyWith({
    Object? id = _Undefined,
    String? roomType,
    Object? referenceId = _Undefined,
    String? name,
    Object? description = _Undefined,
    Object? topic = _Undefined,
    Object? creatorAuthUserId = _Undefined,
    List<_isc.UuidValue>? participantIds,
    Object? allowedBranch = _Undefined,
    Object? allowedAcademicYear = _Undefined,
    DateTime? createdAt,
    Object? lastMessageText = _Undefined,
    Object? lastMessageAt = _Undefined,
  }) {
    return ChatRoom(
      id: id is int? ? id : this.id,
      roomType: roomType ?? this.roomType,
      referenceId: referenceId is String? ? referenceId : this.referenceId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      topic: topic is String? ? topic : this.topic,
      creatorAuthUserId: creatorAuthUserId is _isc.UuidValue?
          ? creatorAuthUserId
          : this.creatorAuthUserId,
      participantIds:
          participantIds ?? this.participantIds.map((e0) => e0).toList(),
      allowedBranch: allowedBranch is String?
          ? allowedBranch
          : this.allowedBranch,
      allowedAcademicYear: allowedAcademicYear is int?
          ? allowedAcademicYear
          : this.allowedAcademicYear,
      createdAt: createdAt ?? this.createdAt,
      lastMessageText: lastMessageText is String?
          ? lastMessageText
          : this.lastMessageText,
      lastMessageAt: lastMessageAt is DateTime?
          ? lastMessageAt
          : this.lastMessageAt,
    );
  }
}
