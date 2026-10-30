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

abstract class SyllabusNode
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SyllabusNode._({
    this.id,
    required this.university,
    required this.course,
    required this.branch,
    required this.semester,
    required this.subjectCode,
    required this.subjectName,
    required this.unitNumber,
    required this.unitTitle,
    required this.topics,
    required this.academicYear,
    required this.version,
  });

  factory SyllabusNode({
    int? id,
    required String university,
    required String course,
    required String branch,
    required int semester,
    required String subjectCode,
    required String subjectName,
    required int unitNumber,
    required String unitTitle,
    required List<String> topics,
    required int academicYear,
    required String version,
  }) = _SyllabusNodeImpl;

  factory SyllabusNode.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyllabusNode(
      id: jsonSerialization['id'] as int?,
      university: jsonSerialization['university'] as String,
      course: jsonSerialization['course'] as String,
      branch: jsonSerialization['branch'] as String,
      semester: jsonSerialization['semester'] as int,
      subjectCode: jsonSerialization['subjectCode'] as String,
      subjectName: jsonSerialization['subjectName'] as String,
      unitNumber: jsonSerialization['unitNumber'] as int,
      unitTitle: jsonSerialization['unitTitle'] as String,
      topics: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['topics'],
      ),
      academicYear: jsonSerialization['academicYear'] as int,
      version: jsonSerialization['version'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String university;

  String course;

  String branch;

  int semester;

  String subjectCode;

  String subjectName;

  int unitNumber;

  String unitTitle;

  List<String> topics;

  int academicYear;

  String version;

  /// Returns a shallow copy of this [SyllabusNode]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SyllabusNode copyWith({
    int? id,
    String? university,
    String? course,
    String? branch,
    int? semester,
    String? subjectCode,
    String? subjectName,
    int? unitNumber,
    String? unitTitle,
    List<String>? topics,
    int? academicYear,
    String? version,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyllabusNode',
      if (id != null) 'id': id,
      'university': university,
      'course': course,
      'branch': branch,
      'semester': semester,
      'subjectCode': subjectCode,
      'subjectName': subjectName,
      'unitNumber': unitNumber,
      'unitTitle': unitTitle,
      'topics': topics.toJson(),
      'academicYear': academicYear,
      'version': version,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyllabusNode',
      if (id != null) 'id': id,
      'university': university,
      'course': course,
      'branch': branch,
      'semester': semester,
      'subjectCode': subjectCode,
      'subjectName': subjectName,
      'unitNumber': unitNumber,
      'unitTitle': unitTitle,
      'topics': topics.toJson(),
      'academicYear': academicYear,
      'version': version,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyllabusNodeImpl extends SyllabusNode {
  _SyllabusNodeImpl({
    int? id,
    required String university,
    required String course,
    required String branch,
    required int semester,
    required String subjectCode,
    required String subjectName,
    required int unitNumber,
    required String unitTitle,
    required List<String> topics,
    required int academicYear,
    required String version,
  }) : super._(
         id: id,
         university: university,
         course: course,
         branch: branch,
         semester: semester,
         subjectCode: subjectCode,
         subjectName: subjectName,
         unitNumber: unitNumber,
         unitTitle: unitTitle,
         topics: topics,
         academicYear: academicYear,
         version: version,
       );

  /// Returns a shallow copy of this [SyllabusNode]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SyllabusNode copyWith({
    Object? id = _Undefined,
    String? university,
    String? course,
    String? branch,
    int? semester,
    String? subjectCode,
    String? subjectName,
    int? unitNumber,
    String? unitTitle,
    List<String>? topics,
    int? academicYear,
    String? version,
  }) {
    return SyllabusNode(
      id: id is int? ? id : this.id,
      university: university ?? this.university,
      course: course ?? this.course,
      branch: branch ?? this.branch,
      semester: semester ?? this.semester,
      subjectCode: subjectCode ?? this.subjectCode,
      subjectName: subjectName ?? this.subjectName,
      unitNumber: unitNumber ?? this.unitNumber,
      unitTitle: unitTitle ?? this.unitTitle,
      topics: topics ?? this.topics.map((e0) => e0).toList(),
      academicYear: academicYear ?? this.academicYear,
      version: version ?? this.version,
    );
  }
}
