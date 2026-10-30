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

abstract class ContactMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ContactMessage._({
    this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ContactMessage({
    int? id,
    required String name,
    required String email,
    required String subject,
    required String message,
    DateTime? createdAt,
  }) = _ContactMessageImpl;

  factory ContactMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContactMessage(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      subject: jsonSerialization['subject'] as String,
      message: jsonSerialization['message'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String email;

  String subject;

  String message;

  DateTime createdAt;

  /// Returns a shallow copy of this [ContactMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ContactMessage copyWith({
    int? id,
    String? name,
    String? email,
    String? subject,
    String? message,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContactMessage',
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ContactMessage',
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContactMessageImpl extends ContactMessage {
  _ContactMessageImpl({
    int? id,
    required String name,
    required String email,
    required String subject,
    required String message,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         email: email,
         subject: subject,
         message: message,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ContactMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ContactMessage copyWith({
    Object? id = _Undefined,
    String? name,
    String? email,
    String? subject,
    String? message,
    DateTime? createdAt,
  }) {
    return ContactMessage(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
