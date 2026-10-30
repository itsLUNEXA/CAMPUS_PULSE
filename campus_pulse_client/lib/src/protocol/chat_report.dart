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

abstract class ChatReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChatReport._({
    this.id,
    required this.messageId,
    required this.roomId,
    required this.reporterUserId,
    required this.reporterName,
    required this.reason,
    String? status,
    this.actionTaken,
    DateTime? createdAt,
    this.reviewedByUserId,
    this.reviewedAt,
  }) : status = status ?? 'pending',
       createdAt = createdAt ?? DateTime.now();

  factory ChatReport({
    int? id,
    required int messageId,
    required int roomId,
    required _isc.UuidValue reporterUserId,
    required String reporterName,
    required String reason,
    String? status,
    String? actionTaken,
    DateTime? createdAt,
    _isc.UuidValue? reviewedByUserId,
    DateTime? reviewedAt,
  }) = _ChatReportImpl;

  factory ChatReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatReport(
      id: jsonSerialization['id'] as int?,
      messageId: jsonSerialization['messageId'] as int,
      roomId: jsonSerialization['roomId'] as int,
      reporterUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['reporterUserId'],
      ),
      reporterName: jsonSerialization['reporterName'] as String,
      reason: jsonSerialization['reason'] as String,
      status: jsonSerialization['status'] as String?,
      actionTaken: jsonSerialization['actionTaken'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      reviewedByUserId: jsonSerialization['reviewedByUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['reviewedByUserId'],
            ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['reviewedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int messageId;

  int roomId;

  _isc.UuidValue reporterUserId;

  String reporterName;

  String reason;

  String status;

  String? actionTaken;

  DateTime createdAt;

  _isc.UuidValue? reviewedByUserId;

  DateTime? reviewedAt;

  /// Returns a shallow copy of this [ChatReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChatReport copyWith({
    int? id,
    int? messageId,
    int? roomId,
    _isc.UuidValue? reporterUserId,
    String? reporterName,
    String? reason,
    String? status,
    String? actionTaken,
    DateTime? createdAt,
    _isc.UuidValue? reviewedByUserId,
    DateTime? reviewedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatReport',
      if (id != null) 'id': id,
      'messageId': messageId,
      'roomId': roomId,
      'reporterUserId': reporterUserId.toJson(),
      'reporterName': reporterName,
      'reason': reason,
      'status': status,
      if (actionTaken != null) 'actionTaken': actionTaken,
      'createdAt': createdAt.toJson(),
      if (reviewedByUserId != null)
        'reviewedByUserId': reviewedByUserId?.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatReport',
      if (id != null) 'id': id,
      'messageId': messageId,
      'roomId': roomId,
      'reporterUserId': reporterUserId.toJson(),
      'reporterName': reporterName,
      'reason': reason,
      'status': status,
      if (actionTaken != null) 'actionTaken': actionTaken,
      'createdAt': createdAt.toJson(),
      if (reviewedByUserId != null)
        'reviewedByUserId': reviewedByUserId?.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatReportImpl extends ChatReport {
  _ChatReportImpl({
    int? id,
    required int messageId,
    required int roomId,
    required _isc.UuidValue reporterUserId,
    required String reporterName,
    required String reason,
    String? status,
    String? actionTaken,
    DateTime? createdAt,
    _isc.UuidValue? reviewedByUserId,
    DateTime? reviewedAt,
  }) : super._(
         id: id,
         messageId: messageId,
         roomId: roomId,
         reporterUserId: reporterUserId,
         reporterName: reporterName,
         reason: reason,
         status: status,
         actionTaken: actionTaken,
         createdAt: createdAt,
         reviewedByUserId: reviewedByUserId,
         reviewedAt: reviewedAt,
       );

  /// Returns a shallow copy of this [ChatReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChatReport copyWith({
    Object? id = _Undefined,
    int? messageId,
    int? roomId,
    _isc.UuidValue? reporterUserId,
    String? reporterName,
    String? reason,
    String? status,
    Object? actionTaken = _Undefined,
    DateTime? createdAt,
    Object? reviewedByUserId = _Undefined,
    Object? reviewedAt = _Undefined,
  }) {
    return ChatReport(
      id: id is int? ? id : this.id,
      messageId: messageId ?? this.messageId,
      roomId: roomId ?? this.roomId,
      reporterUserId: reporterUserId ?? this.reporterUserId,
      reporterName: reporterName ?? this.reporterName,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      actionTaken: actionTaken is String? ? actionTaken : this.actionTaken,
      createdAt: createdAt ?? this.createdAt,
      reviewedByUserId: reviewedByUserId is _isc.UuidValue?
          ? reviewedByUserId
          : this.reviewedByUserId,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
    );
  }
}
