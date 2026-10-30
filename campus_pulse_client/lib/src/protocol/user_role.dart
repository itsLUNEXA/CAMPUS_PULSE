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

abstract class UserRole
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserRole._({
    this.id,
    required this.authUserId,
    required this.role,
    this.assignedScope,
    DateTime? grantedAt,
  }) : grantedAt = grantedAt ?? DateTime.now();

  factory UserRole({
    int? id,
    required _isc.UuidValue authUserId,
    required String role,
    String? assignedScope,
    DateTime? grantedAt,
  }) = _UserRoleImpl;

  factory UserRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRole(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      role: jsonSerialization['role'] as String,
      assignedScope: jsonSerialization['assignedScope'] as String?,
      grantedAt: jsonSerialization['grantedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['grantedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String role;

  String? assignedScope;

  DateTime grantedAt;

  /// Returns a shallow copy of this [UserRole]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserRole copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? role,
    String? assignedScope,
    DateTime? grantedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRole',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'role': role,
      if (assignedScope != null) 'assignedScope': assignedScope,
      'grantedAt': grantedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserRole',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'role': role,
      if (assignedScope != null) 'assignedScope': assignedScope,
      'grantedAt': grantedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRoleImpl extends UserRole {
  _UserRoleImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String role,
    String? assignedScope,
    DateTime? grantedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         role: role,
         assignedScope: assignedScope,
         grantedAt: grantedAt,
       );

  /// Returns a shallow copy of this [UserRole]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserRole copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? role,
    Object? assignedScope = _Undefined,
    DateTime? grantedAt,
  }) {
    return UserRole(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      role: role ?? this.role,
      assignedScope: assignedScope is String?
          ? assignedScope
          : this.assignedScope,
      grantedAt: grantedAt ?? this.grantedAt,
    );
  }
}
