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

abstract class AttendanceRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AttendanceRecord._({
    this.id,
    required this.eventId,
    required this.authUserId,
    required this.studentName,
    required this.status,
    this.checkInCode,
    this.markedByUserId,
    DateTime? markedAt,
    this.notes,
  }) : markedAt = markedAt ?? DateTime.now();

  factory AttendanceRecord({
    int? id,
    required int eventId,
    required _isc.UuidValue authUserId,
    required String studentName,
    required String status,
    String? checkInCode,
    _isc.UuidValue? markedByUserId,
    DateTime? markedAt,
    String? notes,
  }) = _AttendanceRecordImpl;

  factory AttendanceRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return AttendanceRecord(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      status: jsonSerialization['status'] as String,
      checkInCode: jsonSerialization['checkInCode'] as String?,
      markedByUserId: jsonSerialization['markedByUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['markedByUserId'],
            ),
      markedAt: jsonSerialization['markedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['markedAt']),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int eventId;

  _isc.UuidValue authUserId;

  String studentName;

  String status;

  String? checkInCode;

  _isc.UuidValue? markedByUserId;

  DateTime markedAt;

  String? notes;

  /// Returns a shallow copy of this [AttendanceRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AttendanceRecord copyWith({
    int? id,
    int? eventId,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? status,
    String? checkInCode,
    _isc.UuidValue? markedByUserId,
    DateTime? markedAt,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttendanceRecord',
      if (id != null) 'id': id,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'status': status,
      if (checkInCode != null) 'checkInCode': checkInCode,
      if (markedByUserId != null) 'markedByUserId': markedByUserId?.toJson(),
      'markedAt': markedAt.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AttendanceRecord',
      if (id != null) 'id': id,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'status': status,
      if (checkInCode != null) 'checkInCode': checkInCode,
      if (markedByUserId != null) 'markedByUserId': markedByUserId?.toJson(),
      'markedAt': markedAt.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttendanceRecordImpl extends AttendanceRecord {
  _AttendanceRecordImpl({
    int? id,
    required int eventId,
    required _isc.UuidValue authUserId,
    required String studentName,
    required String status,
    String? checkInCode,
    _isc.UuidValue? markedByUserId,
    DateTime? markedAt,
    String? notes,
  }) : super._(
         id: id,
         eventId: eventId,
         authUserId: authUserId,
         studentName: studentName,
         status: status,
         checkInCode: checkInCode,
         markedByUserId: markedByUserId,
         markedAt: markedAt,
         notes: notes,
       );

  /// Returns a shallow copy of this [AttendanceRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AttendanceRecord copyWith({
    Object? id = _Undefined,
    int? eventId,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? status,
    Object? checkInCode = _Undefined,
    Object? markedByUserId = _Undefined,
    DateTime? markedAt,
    Object? notes = _Undefined,
  }) {
    return AttendanceRecord(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      status: status ?? this.status,
      checkInCode: checkInCode is String? ? checkInCode : this.checkInCode,
      markedByUserId: markedByUserId is _isc.UuidValue?
          ? markedByUserId
          : this.markedByUserId,
      markedAt: markedAt ?? this.markedAt,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
