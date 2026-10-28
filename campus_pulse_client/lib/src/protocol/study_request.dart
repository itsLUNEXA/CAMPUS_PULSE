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
    required this.studentId,
    this.studentName,
    this.branch,
    required this.subject,
    required this.location,
    String? status,
    required this.createdAt,
  }) : status = status ?? 'open';

  factory StudyRequest({
    int? id,
    required int studentId,
    String? studentName,
    String? branch,
    required String subject,
    required String location,
    String? status,
    required DateTime createdAt,
  }) = _StudyRequestImpl;

  factory StudyRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyRequest(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      studentName: jsonSerialization['studentName'] as String?,
      branch: jsonSerialization['branch'] as String?,
      subject: jsonSerialization['subject'] as String,
      location: jsonSerialization['location'] as String,
      status: jsonSerialization['status'] as String?,
      createdAt:
          _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int studentId;

  String? studentName;

  String? branch;

  String subject;

  String location;

  String status;

  DateTime createdAt;

  /// Returns a shallow copy of this [StudyRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudyRequest copyWith({
    int? id,
    int? studentId,
    String? studentName,
    String? branch,
    String? subject,
    String? location,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyRequest',
      if (id != null) 'id': id,
      'studentId': studentId,
      if (studentName != null) 'studentName': studentName,
      if (branch != null) 'branch': branch,
      'subject': subject,
      'location': location,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyRequest',
      if (id != null) 'id': id,
      'studentId': studentId,
      if (studentName != null) 'studentName': studentName,
      if (branch != null) 'branch': branch,
      'subject': subject,
      'location': location,
      'status': status,
      'createdAt': createdAt.toJson(),
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
    required int studentId,
    String? studentName,
    String? branch,
    required String subject,
    required String location,
    String? status,
    required DateTime createdAt,
  }) : super._(
          id: id,
          studentId: studentId,
          studentName: studentName,
          branch: branch,
          subject: subject,
          location: location,
          status: status,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [StudyRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudyRequest copyWith({
    Object? id = _Undefined,
    int? studentId,
    Object? studentName = _Undefined,
    Object? branch = _Undefined,
    String? subject,
    String? location,
    String? status,
    DateTime? createdAt,
  }) {
    return StudyRequest(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName is String? ? studentName : this.studentName,
      branch: branch is String? ? branch : this.branch,
      subject: subject ?? this.subject,
      location: location ?? this.location,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
