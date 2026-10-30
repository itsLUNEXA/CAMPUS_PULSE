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

abstract class AdminAuditLog
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminAuditLog._({
    this.id,
    required this.actorUserId,
    required this.actorName,
    required this.actionType,
    required this.targetEntity,
    required this.targetId,
    required this.details,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory AdminAuditLog({
    int? id,
    required _isc.UuidValue actorUserId,
    required String actorName,
    required String actionType,
    required String targetEntity,
    required String targetId,
    required String details,
    DateTime? timestamp,
  }) = _AdminAuditLogImpl;

  factory AdminAuditLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAuditLog(
      id: jsonSerialization['id'] as int?,
      actorUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['actorUserId'],
      ),
      actorName: jsonSerialization['actorName'] as String,
      actionType: jsonSerialization['actionType'] as String,
      targetEntity: jsonSerialization['targetEntity'] as String,
      targetId: jsonSerialization['targetId'] as String,
      details: jsonSerialization['details'] as String,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue actorUserId;

  String actorName;

  String actionType;

  String targetEntity;

  String targetId;

  String details;

  DateTime timestamp;

  /// Returns a shallow copy of this [AdminAuditLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminAuditLog copyWith({
    int? id,
    _isc.UuidValue? actorUserId,
    String? actorName,
    String? actionType,
    String? targetEntity,
    String? targetId,
    String? details,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAuditLog',
      if (id != null) 'id': id,
      'actorUserId': actorUserId.toJson(),
      'actorName': actorName,
      'actionType': actionType,
      'targetEntity': targetEntity,
      'targetId': targetId,
      'details': details,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAuditLog',
      if (id != null) 'id': id,
      'actorUserId': actorUserId.toJson(),
      'actorName': actorName,
      'actionType': actionType,
      'targetEntity': targetEntity,
      'targetId': targetId,
      'details': details,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminAuditLogImpl extends AdminAuditLog {
  _AdminAuditLogImpl({
    int? id,
    required _isc.UuidValue actorUserId,
    required String actorName,
    required String actionType,
    required String targetEntity,
    required String targetId,
    required String details,
    DateTime? timestamp,
  }) : super._(
         id: id,
         actorUserId: actorUserId,
         actorName: actorName,
         actionType: actionType,
         targetEntity: targetEntity,
         targetId: targetId,
         details: details,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [AdminAuditLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminAuditLog copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? actorUserId,
    String? actorName,
    String? actionType,
    String? targetEntity,
    String? targetId,
    String? details,
    DateTime? timestamp,
  }) {
    return AdminAuditLog(
      id: id is int? ? id : this.id,
      actorUserId: actorUserId ?? this.actorUserId,
      actorName: actorName ?? this.actorName,
      actionType: actionType ?? this.actionType,
      targetEntity: targetEntity ?? this.targetEntity,
      targetId: targetId ?? this.targetId,
      details: details ?? this.details,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
