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

abstract class ClubQueryRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ClubQueryRequest._({
    this.id,
    required this.clubId,
    required this.clubName,
    required this.targetTeam,
    required this.senderAuthUserId,
    required this.senderName,
    required this.senderEmail,
    required this.senderBranch,
    required this.senderYear,
    required this.category,
    required this.subject,
    required this.message,
    String? status,
    this.responseMessage,
    this.responderName,
    DateTime? createdAt,
    this.respondedAt,
  }) : status = status ?? 'PENDING',
       createdAt = createdAt ?? DateTime.now();

  factory ClubQueryRequest({
    int? id,
    required int clubId,
    required String clubName,
    required String targetTeam,
    required _isc.UuidValue senderAuthUserId,
    required String senderName,
    required String senderEmail,
    required String senderBranch,
    required int senderYear,
    required String category,
    required String subject,
    required String message,
    String? status,
    String? responseMessage,
    String? responderName,
    DateTime? createdAt,
    DateTime? respondedAt,
  }) = _ClubQueryRequestImpl;

  factory ClubQueryRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClubQueryRequest(
      id: jsonSerialization['id'] as int?,
      clubId: jsonSerialization['clubId'] as int,
      clubName: jsonSerialization['clubName'] as String,
      targetTeam: jsonSerialization['targetTeam'] as String,
      senderAuthUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['senderAuthUserId'],
      ),
      senderName: jsonSerialization['senderName'] as String,
      senderEmail: jsonSerialization['senderEmail'] as String,
      senderBranch: jsonSerialization['senderBranch'] as String,
      senderYear: jsonSerialization['senderYear'] as int,
      category: jsonSerialization['category'] as String,
      subject: jsonSerialization['subject'] as String,
      message: jsonSerialization['message'] as String,
      status: jsonSerialization['status'] as String?,
      responseMessage: jsonSerialization['responseMessage'] as String?,
      responderName: jsonSerialization['responderName'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      respondedAt: jsonSerialization['respondedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['respondedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int clubId;

  String clubName;

  String targetTeam;

  _isc.UuidValue senderAuthUserId;

  String senderName;

  String senderEmail;

  String senderBranch;

  int senderYear;

  String category;

  String subject;

  String message;

  String status;

  String? responseMessage;

  String? responderName;

  DateTime createdAt;

  DateTime? respondedAt;

  /// Returns a shallow copy of this [ClubQueryRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClubQueryRequest copyWith({
    int? id,
    int? clubId,
    String? clubName,
    String? targetTeam,
    _isc.UuidValue? senderAuthUserId,
    String? senderName,
    String? senderEmail,
    String? senderBranch,
    int? senderYear,
    String? category,
    String? subject,
    String? message,
    String? status,
    String? responseMessage,
    String? responderName,
    DateTime? createdAt,
    DateTime? respondedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClubQueryRequest',
      if (id != null) 'id': id,
      'clubId': clubId,
      'clubName': clubName,
      'targetTeam': targetTeam,
      'senderAuthUserId': senderAuthUserId.toJson(),
      'senderName': senderName,
      'senderEmail': senderEmail,
      'senderBranch': senderBranch,
      'senderYear': senderYear,
      'category': category,
      'subject': subject,
      'message': message,
      'status': status,
      if (responseMessage != null) 'responseMessage': responseMessage,
      if (responderName != null) 'responderName': responderName,
      'createdAt': createdAt.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClubQueryRequest',
      if (id != null) 'id': id,
      'clubId': clubId,
      'clubName': clubName,
      'targetTeam': targetTeam,
      'senderAuthUserId': senderAuthUserId.toJson(),
      'senderName': senderName,
      'senderEmail': senderEmail,
      'senderBranch': senderBranch,
      'senderYear': senderYear,
      'category': category,
      'subject': subject,
      'message': message,
      'status': status,
      if (responseMessage != null) 'responseMessage': responseMessage,
      if (responderName != null) 'responderName': responderName,
      'createdAt': createdAt.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClubQueryRequestImpl extends ClubQueryRequest {
  _ClubQueryRequestImpl({
    int? id,
    required int clubId,
    required String clubName,
    required String targetTeam,
    required _isc.UuidValue senderAuthUserId,
    required String senderName,
    required String senderEmail,
    required String senderBranch,
    required int senderYear,
    required String category,
    required String subject,
    required String message,
    String? status,
    String? responseMessage,
    String? responderName,
    DateTime? createdAt,
    DateTime? respondedAt,
  }) : super._(
         id: id,
         clubId: clubId,
         clubName: clubName,
         targetTeam: targetTeam,
         senderAuthUserId: senderAuthUserId,
         senderName: senderName,
         senderEmail: senderEmail,
         senderBranch: senderBranch,
         senderYear: senderYear,
         category: category,
         subject: subject,
         message: message,
         status: status,
         responseMessage: responseMessage,
         responderName: responderName,
         createdAt: createdAt,
         respondedAt: respondedAt,
       );

  /// Returns a shallow copy of this [ClubQueryRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ClubQueryRequest copyWith({
    Object? id = _Undefined,
    int? clubId,
    String? clubName,
    String? targetTeam,
    _isc.UuidValue? senderAuthUserId,
    String? senderName,
    String? senderEmail,
    String? senderBranch,
    int? senderYear,
    String? category,
    String? subject,
    String? message,
    String? status,
    Object? responseMessage = _Undefined,
    Object? responderName = _Undefined,
    DateTime? createdAt,
    Object? respondedAt = _Undefined,
  }) {
    return ClubQueryRequest(
      id: id is int? ? id : this.id,
      clubId: clubId ?? this.clubId,
      clubName: clubName ?? this.clubName,
      targetTeam: targetTeam ?? this.targetTeam,
      senderAuthUserId: senderAuthUserId ?? this.senderAuthUserId,
      senderName: senderName ?? this.senderName,
      senderEmail: senderEmail ?? this.senderEmail,
      senderBranch: senderBranch ?? this.senderBranch,
      senderYear: senderYear ?? this.senderYear,
      category: category ?? this.category,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      status: status ?? this.status,
      responseMessage: responseMessage is String?
          ? responseMessage
          : this.responseMessage,
      responderName: responderName is String?
          ? responderName
          : this.responderName,
      createdAt: createdAt ?? this.createdAt,
      respondedAt: respondedAt is DateTime? ? respondedAt : this.respondedAt,
    );
  }
}
