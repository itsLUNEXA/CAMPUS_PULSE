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

abstract class SectionTimetable
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SectionTimetable._({
    this.id,
    required this.branch,
    required this.academicYear,
    required this.semester,
    required this.section,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.room,
    this.faculty,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory SectionTimetable({
    int? id,
    required String branch,
    required int academicYear,
    required int semester,
    required String section,
    required String dayOfWeek,
    required String startTime,
    required String endTime,
    required String subject,
    required String room,
    String? faculty,
    DateTime? createdAt,
  }) = _SectionTimetableImpl;

  factory SectionTimetable.fromJson(Map<String, dynamic> jsonSerialization) {
    return SectionTimetable(
      id: jsonSerialization['id'] as int?,
      branch: jsonSerialization['branch'] as String,
      academicYear: jsonSerialization['academicYear'] as int,
      semester: jsonSerialization['semester'] as int,
      section: jsonSerialization['section'] as String,
      dayOfWeek: jsonSerialization['dayOfWeek'] as String,
      startTime: jsonSerialization['startTime'] as String,
      endTime: jsonSerialization['endTime'] as String,
      subject: jsonSerialization['subject'] as String,
      room: jsonSerialization['room'] as String,
      faculty: jsonSerialization['faculty'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String branch;

  int academicYear;

  int semester;

  String section;

  String dayOfWeek;

  String startTime;

  String endTime;

  String subject;

  String room;

  String? faculty;

  DateTime createdAt;

  /// Returns a shallow copy of this [SectionTimetable]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SectionTimetable copyWith({
    int? id,
    String? branch,
    int? academicYear,
    int? semester,
    String? section,
    String? dayOfWeek,
    String? startTime,
    String? endTime,
    String? subject,
    String? room,
    String? faculty,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SectionTimetable',
      if (id != null) 'id': id,
      'branch': branch,
      'academicYear': academicYear,
      'semester': semester,
      'section': section,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'subject': subject,
      'room': room,
      if (faculty != null) 'faculty': faculty,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SectionTimetable',
      if (id != null) 'id': id,
      'branch': branch,
      'academicYear': academicYear,
      'semester': semester,
      'section': section,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'subject': subject,
      'room': room,
      if (faculty != null) 'faculty': faculty,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SectionTimetableImpl extends SectionTimetable {
  _SectionTimetableImpl({
    int? id,
    required String branch,
    required int academicYear,
    required int semester,
    required String section,
    required String dayOfWeek,
    required String startTime,
    required String endTime,
    required String subject,
    required String room,
    String? faculty,
    DateTime? createdAt,
  }) : super._(
         id: id,
         branch: branch,
         academicYear: academicYear,
         semester: semester,
         section: section,
         dayOfWeek: dayOfWeek,
         startTime: startTime,
         endTime: endTime,
         subject: subject,
         room: room,
         faculty: faculty,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SectionTimetable]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SectionTimetable copyWith({
    Object? id = _Undefined,
    String? branch,
    int? academicYear,
    int? semester,
    String? section,
    String? dayOfWeek,
    String? startTime,
    String? endTime,
    String? subject,
    String? room,
    Object? faculty = _Undefined,
    DateTime? createdAt,
  }) {
    return SectionTimetable(
      id: id is int? ? id : this.id,
      branch: branch ?? this.branch,
      academicYear: academicYear ?? this.academicYear,
      semester: semester ?? this.semester,
      section: section ?? this.section,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      subject: subject ?? this.subject,
      room: room ?? this.room,
      faculty: faculty is String? ? faculty : this.faculty,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
