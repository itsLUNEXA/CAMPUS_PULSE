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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class StudentFreeSlot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudentFreeSlot._({
    this.id,
    required this.authUserId,
    required this.dayOfWeek,
    required this.slotLabel,
    required this.startTime,
    required this.endTime,
    bool? isFree,
    DateTime? updatedAt,
  }) : isFree = isFree ?? true,
       updatedAt = updatedAt ?? DateTime.now();

  factory StudentFreeSlot({
    int? id,
    required _isc.UuidValue authUserId,
    required String dayOfWeek,
    required String slotLabel,
    required String startTime,
    required String endTime,
    bool? isFree,
    DateTime? updatedAt,
  }) = _StudentFreeSlotImpl;

  factory StudentFreeSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentFreeSlot(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      dayOfWeek: jsonSerialization['dayOfWeek'] as String,
      slotLabel: jsonSerialization['slotLabel'] as String,
      startTime: jsonSerialization['startTime'] as String,
      endTime: jsonSerialization['endTime'] as String,
      isFree: jsonSerialization['isFree'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isFree']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String dayOfWeek;

  String slotLabel;

  String startTime;

  String endTime;

  bool isFree;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudentFreeSlot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudentFreeSlot copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? dayOfWeek,
    String? slotLabel,
    String? startTime,
    String? endTime,
    bool? isFree,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentFreeSlot',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'dayOfWeek': dayOfWeek,
      'slotLabel': slotLabel,
      'startTime': startTime,
      'endTime': endTime,
      'isFree': isFree,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentFreeSlot',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'dayOfWeek': dayOfWeek,
      'slotLabel': slotLabel,
      'startTime': startTime,
      'endTime': endTime,
      'isFree': isFree,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentFreeSlotImpl extends StudentFreeSlot {
  _StudentFreeSlotImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String dayOfWeek,
    required String slotLabel,
    required String startTime,
    required String endTime,
    bool? isFree,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         dayOfWeek: dayOfWeek,
         slotLabel: slotLabel,
         startTime: startTime,
         endTime: endTime,
         isFree: isFree,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentFreeSlot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudentFreeSlot copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? dayOfWeek,
    String? slotLabel,
    String? startTime,
    String? endTime,
    bool? isFree,
    DateTime? updatedAt,
  }) {
    return StudentFreeSlot(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      slotLabel: slotLabel ?? this.slotLabel,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isFree: isFree ?? this.isFree,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
