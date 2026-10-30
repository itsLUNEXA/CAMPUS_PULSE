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

abstract class StudyRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudyRequest._({
    this.id,
    required this.senderAuthUserId,
    required this.senderName,
    required this.senderBranch,
    required this.senderYear,
    required this.recipientAuthUserId,
    required this.recipientName,
    required this.subject,
    required this.message,
    required this.status,
    required this.urgency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StudyRequest({
    int? id,
    required _isc.UuidValue senderAuthUserId,
    required String senderName,
    required String senderBranch,
    required int senderYear,
    required _isc.UuidValue recipientAuthUserId,
    required String recipientName,
    required String subject,
    required String message,
    required String status,
    required String urgency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StudyRequestImpl;

  factory StudyRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyRequest(
      id: jsonSerialization['id'] as int?,
      senderAuthUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['senderAuthUserId'],
      ),
      senderName: jsonSerialization['senderName'] as String,
      senderBranch: jsonSerialization['senderBranch'] as String,
      senderYear: jsonSerialization['senderYear'] as int,
      recipientAuthUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['recipientAuthUserId'],
      ),
      recipientName: jsonSerialization['recipientName'] as String,
      subject: jsonSerialization['subject'] as String,
      message: jsonSerialization['message'] as String,
      status: jsonSerialization['status'] as String,
      urgency: jsonSerialization['urgency'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue senderAuthUserId;

  String senderName;

  String senderBranch;

  int senderYear;

  _isc.UuidValue recipientAuthUserId;

  String recipientName;

  String subject;

  String message;

  String status;

  String urgency;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudyRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudyRequest copyWith({
    int? id,
    _isc.UuidValue? senderAuthUserId,
    String? senderName,
    String? senderBranch,
    int? senderYear,
    _isc.UuidValue? recipientAuthUserId,
    String? recipientName,
    String? subject,
    String? message,
    String? status,
    String? urgency,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyRequest',
      if (id != null) 'id': id,
      'senderAuthUserId': senderAuthUserId.toJson(),
      'senderName': senderName,
      'senderBranch': senderBranch,
      'senderYear': senderYear,
      'recipientAuthUserId': recipientAuthUserId.toJson(),
      'recipientName': recipientName,
      'subject': subject,
      'message': message,
      'status': status,
      'urgency': urgency,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyRequest',
      if (id != null) 'id': id,
      'senderAuthUserId': senderAuthUserId.toJson(),
      'senderName': senderName,
      'senderBranch': senderBranch,
      'senderYear': senderYear,
      'recipientAuthUserId': recipientAuthUserId.toJson(),
      'recipientName': recipientName,
      'subject': subject,
      'message': message,
      'status': status,
      'urgency': urgency,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyRequestImpl extends StudyRequest {
  _StudyRequestImpl({
    int? id,
    required _isc.UuidValue senderAuthUserId,
    required String senderName,
    required String senderBranch,
    required int senderYear,
    required _isc.UuidValue recipientAuthUserId,
    required String recipientName,
    required String subject,
    required String message,
    required String status,
    required String urgency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         senderAuthUserId: senderAuthUserId,
         senderName: senderName,
         senderBranch: senderBranch,
         senderYear: senderYear,
         recipientAuthUserId: recipientAuthUserId,
         recipientName: recipientName,
         subject: subject,
         message: message,
         status: status,
         urgency: urgency,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudyRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudyRequest copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? senderAuthUserId,
    String? senderName,
    String? senderBranch,
    int? senderYear,
    _isc.UuidValue? recipientAuthUserId,
    String? recipientName,
    String? subject,
    String? message,
    String? status,
    String? urgency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudyRequest(
      id: id is int? ? id : this.id,
      senderAuthUserId: senderAuthUserId ?? this.senderAuthUserId,
      senderName: senderName ?? this.senderName,
      senderBranch: senderBranch ?? this.senderBranch,
      senderYear: senderYear ?? this.senderYear,
      recipientAuthUserId: recipientAuthUserId ?? this.recipientAuthUserId,
      recipientName: recipientName ?? this.recipientName,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      status: status ?? this.status,
      urgency: urgency ?? this.urgency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
