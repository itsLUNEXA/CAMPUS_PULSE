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
import 'package:campus_pulse_client/src/protocol/protocol.dart' as _il98xzab;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class StudentProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudentProfile._({
    this.id,
    required this.authUserId,
    required this.fullName,
    required this.email,
    required this.branch,
    required this.academicYear,
    required this.hostelOrArea,
    this.bio,
    required this.subjectInterests,
    this.eventInterests,
    this.preferredQuizSubjects,
    this.preferredQuizTypes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StudentProfile({
    int? id,
    required _isc.UuidValue authUserId,
    required String fullName,
    required String email,
    required String branch,
    required int academicYear,
    required String hostelOrArea,
    String? bio,
    required List<String> subjectInterests,
    List<String>? eventInterests,
    List<String>? preferredQuizSubjects,
    List<String>? preferredQuizTypes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StudentProfileImpl;

  factory StudentProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      fullName: jsonSerialization['fullName'] as String,
      email: jsonSerialization['email'] as String,
      branch: jsonSerialization['branch'] as String,
      academicYear: jsonSerialization['academicYear'] as int,
      hostelOrArea: jsonSerialization['hostelOrArea'] as String,
      bio: jsonSerialization['bio'] as String?,
      subjectInterests: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['subjectInterests'],
      ),
      eventInterests: jsonSerialization['eventInterests'] == null
          ? null
          : _il98xzab.Protocol().deserialize<List<String>>(
              jsonSerialization['eventInterests'],
            ),
      preferredQuizSubjects: jsonSerialization['preferredQuizSubjects'] == null
          ? null
          : _il98xzab.Protocol().deserialize<List<String>>(
              jsonSerialization['preferredQuizSubjects'],
            ),
      preferredQuizTypes: jsonSerialization['preferredQuizTypes'] == null
          ? null
          : _il98xzab.Protocol().deserialize<List<String>>(
              jsonSerialization['preferredQuizTypes'],
            ),
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

  _isc.UuidValue authUserId;

  String fullName;

  String email;

  String branch;

  int academicYear;

  String hostelOrArea;

  String? bio;

  List<String> subjectInterests;

  List<String>? eventInterests;

  List<String>? preferredQuizSubjects;

  List<String>? preferredQuizTypes;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudentProfile copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? fullName,
    String? email,
    String? branch,
    int? academicYear,
    String? hostelOrArea,
    String? bio,
    List<String>? subjectInterests,
    List<String>? eventInterests,
    List<String>? preferredQuizSubjects,
    List<String>? preferredQuizTypes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'fullName': fullName,
      'email': email,
      'branch': branch,
      'academicYear': academicYear,
      'hostelOrArea': hostelOrArea,
      if (bio != null) 'bio': bio,
      'subjectInterests': subjectInterests.toJson(),
      if (eventInterests != null) 'eventInterests': eventInterests?.toJson(),
      if (preferredQuizSubjects != null)
        'preferredQuizSubjects': preferredQuizSubjects?.toJson(),
      if (preferredQuizTypes != null)
        'preferredQuizTypes': preferredQuizTypes?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'fullName': fullName,
      'email': email,
      'branch': branch,
      'academicYear': academicYear,
      'hostelOrArea': hostelOrArea,
      if (bio != null) 'bio': bio,
      'subjectInterests': subjectInterests.toJson(),
      if (eventInterests != null) 'eventInterests': eventInterests?.toJson(),
      if (preferredQuizSubjects != null)
        'preferredQuizSubjects': preferredQuizSubjects?.toJson(),
      if (preferredQuizTypes != null)
        'preferredQuizTypes': preferredQuizTypes?.toJson(),
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

class _StudentProfileImpl extends StudentProfile {
  _StudentProfileImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String fullName,
    required String email,
    required String branch,
    required int academicYear,
    required String hostelOrArea,
    String? bio,
    required List<String> subjectInterests,
    List<String>? eventInterests,
    List<String>? preferredQuizSubjects,
    List<String>? preferredQuizTypes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         fullName: fullName,
         email: email,
         branch: branch,
         academicYear: academicYear,
         hostelOrArea: hostelOrArea,
         bio: bio,
         subjectInterests: subjectInterests,
         eventInterests: eventInterests,
         preferredQuizSubjects: preferredQuizSubjects,
         preferredQuizTypes: preferredQuizTypes,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudentProfile copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? fullName,
    String? email,
    String? branch,
    int? academicYear,
    String? hostelOrArea,
    Object? bio = _Undefined,
    List<String>? subjectInterests,
    Object? eventInterests = _Undefined,
    Object? preferredQuizSubjects = _Undefined,
    Object? preferredQuizTypes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      branch: branch ?? this.branch,
      academicYear: academicYear ?? this.academicYear,
      hostelOrArea: hostelOrArea ?? this.hostelOrArea,
      bio: bio is String? ? bio : this.bio,
      subjectInterests:
          subjectInterests ?? this.subjectInterests.map((e0) => e0).toList(),
      eventInterests: eventInterests is List<String>?
          ? eventInterests
          : this.eventInterests?.map((e0) => e0).toList(),
      preferredQuizSubjects: preferredQuizSubjects is List<String>?
          ? preferredQuizSubjects
          : this.preferredQuizSubjects?.map((e0) => e0).toList(),
      preferredQuizTypes: preferredQuizTypes is List<String>?
          ? preferredQuizTypes
          : this.preferredQuizTypes?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
