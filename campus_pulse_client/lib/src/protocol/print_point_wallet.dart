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

abstract class PrintPointWallet
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PrintPointWallet._({
    this.id,
    required this.authUserId,
    required this.studentName,
    required this.balance,
    required this.lifetimeEarned,
    required this.lifetimeRedeemed,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory PrintPointWallet({
    int? id,
    required _isc.UuidValue authUserId,
    required String studentName,
    required int balance,
    required int lifetimeEarned,
    required int lifetimeRedeemed,
    DateTime? updatedAt,
  }) = _PrintPointWalletImpl;

  factory PrintPointWallet.fromJson(Map<String, dynamic> jsonSerialization) {
    return PrintPointWallet(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      balance: jsonSerialization['balance'] as int,
      lifetimeEarned: jsonSerialization['lifetimeEarned'] as int,
      lifetimeRedeemed: jsonSerialization['lifetimeRedeemed'] as int,
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

  String studentName;

  int balance;

  int lifetimeEarned;

  int lifetimeRedeemed;

  DateTime updatedAt;

  /// Returns a shallow copy of this [PrintPointWallet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PrintPointWallet copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? studentName,
    int? balance,
    int? lifetimeEarned,
    int? lifetimeRedeemed,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PrintPointWallet',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'balance': balance,
      'lifetimeEarned': lifetimeEarned,
      'lifetimeRedeemed': lifetimeRedeemed,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PrintPointWallet',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'balance': balance,
      'lifetimeEarned': lifetimeEarned,
      'lifetimeRedeemed': lifetimeRedeemed,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrintPointWalletImpl extends PrintPointWallet {
  _PrintPointWalletImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String studentName,
    required int balance,
    required int lifetimeEarned,
    required int lifetimeRedeemed,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         studentName: studentName,
         balance: balance,
         lifetimeEarned: lifetimeEarned,
         lifetimeRedeemed: lifetimeRedeemed,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PrintPointWallet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PrintPointWallet copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? studentName,
    int? balance,
    int? lifetimeEarned,
    int? lifetimeRedeemed,
    DateTime? updatedAt,
  }) {
    return PrintPointWallet(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      balance: balance ?? this.balance,
      lifetimeEarned: lifetimeEarned ?? this.lifetimeEarned,
      lifetimeRedeemed: lifetimeRedeemed ?? this.lifetimeRedeemed,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
