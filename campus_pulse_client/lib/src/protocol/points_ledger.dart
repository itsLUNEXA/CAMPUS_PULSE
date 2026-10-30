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

abstract class PointsLedger
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PointsLedger._({
    this.id,
    required this.authUserId,
    required this.studentName,
    required this.source,
    required this.points,
    required this.description,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory PointsLedger({
    int? id,
    required _isc.UuidValue authUserId,
    required String studentName,
    required String source,
    required int points,
    required String description,
    DateTime? timestamp,
  }) = _PointsLedgerImpl;

  factory PointsLedger.fromJson(Map<String, dynamic> jsonSerialization) {
    return PointsLedger(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      source: jsonSerialization['source'] as String,
      points: jsonSerialization['points'] as int,
      description: jsonSerialization['description'] as String,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String studentName;

  String source;

  int points;

  String description;

  DateTime timestamp;

  /// Returns a shallow copy of this [PointsLedger]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PointsLedger copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? source,
    int? points,
    String? description,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PointsLedger',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'source': source,
      'points': points,
      'description': description,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PointsLedger',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'source': source,
      'points': points,
      'description': description,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PointsLedgerImpl extends PointsLedger {
  _PointsLedgerImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String studentName,
    required String source,
    required int points,
    required String description,
    DateTime? timestamp,
  }) : super._(
         id: id,
         authUserId: authUserId,
         studentName: studentName,
         source: source,
         points: points,
         description: description,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [PointsLedger]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PointsLedger copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? source,
    int? points,
    String? description,
    DateTime? timestamp,
  }) {
    return PointsLedger(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      source: source ?? this.source,
      points: points ?? this.points,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
