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

abstract class EventCertificate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EventCertificate._({
    this.id,
    required this.certificateId,
    required this.eventId,
    required this.authUserId,
    required this.studentName,
    required this.eventName,
    required this.eventDate,
    DateTime? issuedAt,
    this.issuedByUserId,
    required this.verificationUrl,
    required this.status,
    required this.signatureTitle,
  }) : issuedAt = issuedAt ?? DateTime.now();

  factory EventCertificate({
    int? id,
    required String certificateId,
    required int eventId,
    required _isc.UuidValue authUserId,
    required String studentName,
    required String eventName,
    required DateTime eventDate,
    DateTime? issuedAt,
    _isc.UuidValue? issuedByUserId,
    required String verificationUrl,
    required String status,
    required String signatureTitle,
  }) = _EventCertificateImpl;

  factory EventCertificate.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventCertificate(
      id: jsonSerialization['id'] as int?,
      certificateId: jsonSerialization['certificateId'] as String,
      eventId: jsonSerialization['eventId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      eventName: jsonSerialization['eventName'] as String,
      eventDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['eventDate'],
      ),
      issuedAt: jsonSerialization['issuedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['issuedAt']),
      issuedByUserId: jsonSerialization['issuedByUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['issuedByUserId'],
            ),
      verificationUrl: jsonSerialization['verificationUrl'] as String,
      status: jsonSerialization['status'] as String,
      signatureTitle: jsonSerialization['signatureTitle'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String certificateId;

  int eventId;

  _isc.UuidValue authUserId;

  String studentName;

  String eventName;

  DateTime eventDate;

  DateTime issuedAt;

  _isc.UuidValue? issuedByUserId;

  String verificationUrl;

  String status;

  String signatureTitle;

  /// Returns a shallow copy of this [EventCertificate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EventCertificate copyWith({
    int? id,
    String? certificateId,
    int? eventId,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? eventName,
    DateTime? eventDate,
    DateTime? issuedAt,
    _isc.UuidValue? issuedByUserId,
    String? verificationUrl,
    String? status,
    String? signatureTitle,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventCertificate',
      if (id != null) 'id': id,
      'certificateId': certificateId,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'eventName': eventName,
      'eventDate': eventDate.toJson(),
      'issuedAt': issuedAt.toJson(),
      if (issuedByUserId != null) 'issuedByUserId': issuedByUserId?.toJson(),
      'verificationUrl': verificationUrl,
      'status': status,
      'signatureTitle': signatureTitle,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventCertificate',
      if (id != null) 'id': id,
      'certificateId': certificateId,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'eventName': eventName,
      'eventDate': eventDate.toJson(),
      'issuedAt': issuedAt.toJson(),
      if (issuedByUserId != null) 'issuedByUserId': issuedByUserId?.toJson(),
      'verificationUrl': verificationUrl,
      'status': status,
      'signatureTitle': signatureTitle,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventCertificateImpl extends EventCertificate {
  _EventCertificateImpl({
    int? id,
    required String certificateId,
    required int eventId,
    required _isc.UuidValue authUserId,
    required String studentName,
    required String eventName,
    required DateTime eventDate,
    DateTime? issuedAt,
    _isc.UuidValue? issuedByUserId,
    required String verificationUrl,
    required String status,
    required String signatureTitle,
  }) : super._(
         id: id,
         certificateId: certificateId,
         eventId: eventId,
         authUserId: authUserId,
         studentName: studentName,
         eventName: eventName,
         eventDate: eventDate,
         issuedAt: issuedAt,
         issuedByUserId: issuedByUserId,
         verificationUrl: verificationUrl,
         status: status,
         signatureTitle: signatureTitle,
       );

  /// Returns a shallow copy of this [EventCertificate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EventCertificate copyWith({
    Object? id = _Undefined,
    String? certificateId,
    int? eventId,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? eventName,
    DateTime? eventDate,
    DateTime? issuedAt,
    Object? issuedByUserId = _Undefined,
    String? verificationUrl,
    String? status,
    String? signatureTitle,
  }) {
    return EventCertificate(
      id: id is int? ? id : this.id,
      certificateId: certificateId ?? this.certificateId,
      eventId: eventId ?? this.eventId,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      issuedAt: issuedAt ?? this.issuedAt,
      issuedByUserId: issuedByUserId is _isc.UuidValue?
          ? issuedByUserId
          : this.issuedByUserId,
      verificationUrl: verificationUrl ?? this.verificationUrl,
      status: status ?? this.status,
      signatureTitle: signatureTitle ?? this.signatureTitle,
    );
  }
}
