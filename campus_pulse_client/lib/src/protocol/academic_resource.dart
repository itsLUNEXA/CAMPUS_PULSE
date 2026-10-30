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

abstract class AcademicResource
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AcademicResource._({
    this.id,
    required this.title,
    this.description,
    required this.university,
    required this.course,
    required this.branch,
    required this.academicYear,
    required this.semester,
    required this.subjectCode,
    required this.subjectName,
    this.unitNumber,
    required this.resourceType,
    required this.fileUrl,
    this.fileSize,
    required this.uploadedByUserId,
    required this.uploaderName,
    bool? isApproved,
    this.approvedByUserId,
    DateTime? createdAt,
    int? downloadCount,
  }) : isApproved = isApproved ?? false,
       createdAt = createdAt ?? DateTime.now(),
       downloadCount = downloadCount ?? 0;

  factory AcademicResource({
    int? id,
    required String title,
    String? description,
    required String university,
    required String course,
    required String branch,
    required int academicYear,
    required int semester,
    required String subjectCode,
    required String subjectName,
    int? unitNumber,
    required String resourceType,
    required String fileUrl,
    int? fileSize,
    required _isc.UuidValue uploadedByUserId,
    required String uploaderName,
    bool? isApproved,
    _isc.UuidValue? approvedByUserId,
    DateTime? createdAt,
    int? downloadCount,
  }) = _AcademicResourceImpl;

  factory AcademicResource.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcademicResource(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      university: jsonSerialization['university'] as String,
      course: jsonSerialization['course'] as String,
      branch: jsonSerialization['branch'] as String,
      academicYear: jsonSerialization['academicYear'] as int,
      semester: jsonSerialization['semester'] as int,
      subjectCode: jsonSerialization['subjectCode'] as String,
      subjectName: jsonSerialization['subjectName'] as String,
      unitNumber: jsonSerialization['unitNumber'] as int?,
      resourceType: jsonSerialization['resourceType'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      fileSize: jsonSerialization['fileSize'] as int?,
      uploadedByUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['uploadedByUserId'],
      ),
      uploaderName: jsonSerialization['uploaderName'] as String,
      isApproved: jsonSerialization['isApproved'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isApproved']),
      approvedByUserId: jsonSerialization['approvedByUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['approvedByUserId'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      downloadCount: jsonSerialization['downloadCount'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String? description;

  String university;

  String course;

  String branch;

  int academicYear;

  int semester;

  String subjectCode;

  String subjectName;

  int? unitNumber;

  String resourceType;

  String fileUrl;

  int? fileSize;

  _isc.UuidValue uploadedByUserId;

  String uploaderName;

  bool isApproved;

  _isc.UuidValue? approvedByUserId;

  DateTime createdAt;

  int downloadCount;

  /// Returns a shallow copy of this [AcademicResource]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AcademicResource copyWith({
    int? id,
    String? title,
    String? description,
    String? university,
    String? course,
    String? branch,
    int? academicYear,
    int? semester,
    String? subjectCode,
    String? subjectName,
    int? unitNumber,
    String? resourceType,
    String? fileUrl,
    int? fileSize,
    _isc.UuidValue? uploadedByUserId,
    String? uploaderName,
    bool? isApproved,
    _isc.UuidValue? approvedByUserId,
    DateTime? createdAt,
    int? downloadCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AcademicResource',
      if (id != null) 'id': id,
      'title': title,
      if (description != null) 'description': description,
      'university': university,
      'course': course,
      'branch': branch,
      'academicYear': academicYear,
      'semester': semester,
      'subjectCode': subjectCode,
      'subjectName': subjectName,
      if (unitNumber != null) 'unitNumber': unitNumber,
      'resourceType': resourceType,
      'fileUrl': fileUrl,
      if (fileSize != null) 'fileSize': fileSize,
      'uploadedByUserId': uploadedByUserId.toJson(),
      'uploaderName': uploaderName,
      'isApproved': isApproved,
      if (approvedByUserId != null)
        'approvedByUserId': approvedByUserId?.toJson(),
      'createdAt': createdAt.toJson(),
      'downloadCount': downloadCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AcademicResource',
      if (id != null) 'id': id,
      'title': title,
      if (description != null) 'description': description,
      'university': university,
      'course': course,
      'branch': branch,
      'academicYear': academicYear,
      'semester': semester,
      'subjectCode': subjectCode,
      'subjectName': subjectName,
      if (unitNumber != null) 'unitNumber': unitNumber,
      'resourceType': resourceType,
      'fileUrl': fileUrl,
      if (fileSize != null) 'fileSize': fileSize,
      'uploadedByUserId': uploadedByUserId.toJson(),
      'uploaderName': uploaderName,
      'isApproved': isApproved,
      if (approvedByUserId != null)
        'approvedByUserId': approvedByUserId?.toJson(),
      'createdAt': createdAt.toJson(),
      'downloadCount': downloadCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AcademicResourceImpl extends AcademicResource {
  _AcademicResourceImpl({
    int? id,
    required String title,
    String? description,
    required String university,
    required String course,
    required String branch,
    required int academicYear,
    required int semester,
    required String subjectCode,
    required String subjectName,
    int? unitNumber,
    required String resourceType,
    required String fileUrl,
    int? fileSize,
    required _isc.UuidValue uploadedByUserId,
    required String uploaderName,
    bool? isApproved,
    _isc.UuidValue? approvedByUserId,
    DateTime? createdAt,
    int? downloadCount,
  }) : super._(
         id: id,
         title: title,
         description: description,
         university: university,
         course: course,
         branch: branch,
         academicYear: academicYear,
         semester: semester,
         subjectCode: subjectCode,
         subjectName: subjectName,
         unitNumber: unitNumber,
         resourceType: resourceType,
         fileUrl: fileUrl,
         fileSize: fileSize,
         uploadedByUserId: uploadedByUserId,
         uploaderName: uploaderName,
         isApproved: isApproved,
         approvedByUserId: approvedByUserId,
         createdAt: createdAt,
         downloadCount: downloadCount,
       );

  /// Returns a shallow copy of this [AcademicResource]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AcademicResource copyWith({
    Object? id = _Undefined,
    String? title,
    Object? description = _Undefined,
    String? university,
    String? course,
    String? branch,
    int? academicYear,
    int? semester,
    String? subjectCode,
    String? subjectName,
    Object? unitNumber = _Undefined,
    String? resourceType,
    String? fileUrl,
    Object? fileSize = _Undefined,
    _isc.UuidValue? uploadedByUserId,
    String? uploaderName,
    bool? isApproved,
    Object? approvedByUserId = _Undefined,
    DateTime? createdAt,
    int? downloadCount,
  }) {
    return AcademicResource(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      university: university ?? this.university,
      course: course ?? this.course,
      branch: branch ?? this.branch,
      academicYear: academicYear ?? this.academicYear,
      semester: semester ?? this.semester,
      subjectCode: subjectCode ?? this.subjectCode,
      subjectName: subjectName ?? this.subjectName,
      unitNumber: unitNumber is int? ? unitNumber : this.unitNumber,
      resourceType: resourceType ?? this.resourceType,
      fileUrl: fileUrl ?? this.fileUrl,
      fileSize: fileSize is int? ? fileSize : this.fileSize,
      uploadedByUserId: uploadedByUserId ?? this.uploadedByUserId,
      uploaderName: uploaderName ?? this.uploaderName,
      isApproved: isApproved ?? this.isApproved,
      approvedByUserId: approvedByUserId is _isc.UuidValue?
          ? approvedByUserId
          : this.approvedByUserId,
      createdAt: createdAt ?? this.createdAt,
      downloadCount: downloadCount ?? this.downloadCount,
    );
  }
}
