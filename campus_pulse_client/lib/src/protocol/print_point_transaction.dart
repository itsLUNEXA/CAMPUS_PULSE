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

abstract class PrintPointTransaction
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PrintPointTransaction._({
    this.id,
    required this.authUserId,
    this.printRequestId,
    required this.type,
    required this.points,
    required this.balanceAfter,
    required this.description,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory PrintPointTransaction({
    int? id,
    required _isc.UuidValue authUserId,
    int? printRequestId,
    required String type,
    required int points,
    required int balanceAfter,
    required String description,
    DateTime? createdAt,
  }) = _PrintPointTransactionImpl;

  factory PrintPointTransaction.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PrintPointTransaction(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      printRequestId: jsonSerialization['printRequestId'] as int?,
      type: jsonSerialization['type'] as String,
      points: jsonSerialization['points'] as int,
      balanceAfter: jsonSerialization['balanceAfter'] as int,
      description: jsonSerialization['description'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  int? printRequestId;

  String type;

  int points;

  int balanceAfter;

  String description;

  DateTime createdAt;

  /// Returns a shallow copy of this [PrintPointTransaction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PrintPointTransaction copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    int? printRequestId,
    String? type,
    int? points,
    int? balanceAfter,
    String? description,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PrintPointTransaction',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (printRequestId != null) 'printRequestId': printRequestId,
      'type': type,
      'points': points,
      'balanceAfter': balanceAfter,
      'description': description,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PrintPointTransaction',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (printRequestId != null) 'printRequestId': printRequestId,
      'type': type,
      'points': points,
      'balanceAfter': balanceAfter,
      'description': description,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrintPointTransactionImpl extends PrintPointTransaction {
  _PrintPointTransactionImpl({
    int? id,
    required _isc.UuidValue authUserId,
    int? printRequestId,
    required String type,
    required int points,
    required int balanceAfter,
    required String description,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         printRequestId: printRequestId,
         type: type,
         points: points,
         balanceAfter: balanceAfter,
         description: description,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PrintPointTransaction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PrintPointTransaction copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? printRequestId = _Undefined,
    String? type,
    int? points,
    int? balanceAfter,
    String? description,
    DateTime? createdAt,
  }) {
    return PrintPointTransaction(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      printRequestId: printRequestId is int?
          ? printRequestId
          : this.printRequestId,
      type: type ?? this.type,
      points: points ?? this.points,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
