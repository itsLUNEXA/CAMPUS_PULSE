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

abstract class MockInterviewSlot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MockInterviewSlot._({
    this.id,
    required this.studentAuthUserId,
    required this.studentName,
    required this.studentEmail,
    required this.targetCompany,
    required this.targetRole,
    required this.mockRound,
    required this.preferredDate,
    this.resumeUrl,
    this.notes,
    String? status,
    this.seniorMentorName,
    this.meetingLink,
    this.feedbackNotes,
    DateTime? createdAt,
  }) : status = status ?? 'REQUESTED',
       createdAt = createdAt ?? DateTime.now();

  factory MockInterviewSlot({
    int? id,
    required _isc.UuidValue studentAuthUserId,
    required String studentName,
    required String studentEmail,
    required String targetCompany,
    required String targetRole,
    required String mockRound,
    required DateTime preferredDate,
    String? resumeUrl,
    String? notes,
    String? status,
    String? seniorMentorName,
    String? meetingLink,
    String? feedbackNotes,
    DateTime? createdAt,
  }) = _MockInterviewSlotImpl;

  factory MockInterviewSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return MockInterviewSlot(
      id: jsonSerialization['id'] as int?,
      studentAuthUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['studentAuthUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      studentEmail: jsonSerialization['studentEmail'] as String,
      targetCompany: jsonSerialization['targetCompany'] as String,
      targetRole: jsonSerialization['targetRole'] as String,
      mockRound: jsonSerialization['mockRound'] as String,
      preferredDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['preferredDate'],
      ),
      resumeUrl: jsonSerialization['resumeUrl'] as String?,
      notes: jsonSerialization['notes'] as String?,
      status: jsonSerialization['status'] as String?,
      seniorMentorName: jsonSerialization['seniorMentorName'] as String?,
      meetingLink: jsonSerialization['meetingLink'] as String?,
      feedbackNotes: jsonSerialization['feedbackNotes'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue studentAuthUserId;

  String studentName;

  String studentEmail;

  String targetCompany;

  String targetRole;

  String mockRound;

  DateTime preferredDate;

  String? resumeUrl;

  String? notes;

  String status;

  String? seniorMentorName;

  String? meetingLink;

  String? feedbackNotes;

  DateTime createdAt;

  /// Returns a shallow copy of this [MockInterviewSlot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MockInterviewSlot copyWith({
    int? id,
    _isc.UuidValue? studentAuthUserId,
    String? studentName,
    String? studentEmail,
    String? targetCompany,
    String? targetRole,
    String? mockRound,
    DateTime? preferredDate,
    String? resumeUrl,
    String? notes,
    String? status,
    String? seniorMentorName,
    String? meetingLink,
    String? feedbackNotes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MockInterviewSlot',
      if (id != null) 'id': id,
      'studentAuthUserId': studentAuthUserId.toJson(),
      'studentName': studentName,
      'studentEmail': studentEmail,
      'targetCompany': targetCompany,
      'targetRole': targetRole,
      'mockRound': mockRound,
      'preferredDate': preferredDate.toJson(),
      if (resumeUrl != null) 'resumeUrl': resumeUrl,
      if (notes != null) 'notes': notes,
      'status': status,
      if (seniorMentorName != null) 'seniorMentorName': seniorMentorName,
      if (meetingLink != null) 'meetingLink': meetingLink,
      if (feedbackNotes != null) 'feedbackNotes': feedbackNotes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MockInterviewSlot',
      if (id != null) 'id': id,
      'studentAuthUserId': studentAuthUserId.toJson(),
      'studentName': studentName,
      'studentEmail': studentEmail,
      'targetCompany': targetCompany,
      'targetRole': targetRole,
      'mockRound': mockRound,
      'preferredDate': preferredDate.toJson(),
      if (resumeUrl != null) 'resumeUrl': resumeUrl,
      if (notes != null) 'notes': notes,
      'status': status,
      if (seniorMentorName != null) 'seniorMentorName': seniorMentorName,
      if (meetingLink != null) 'meetingLink': meetingLink,
      if (feedbackNotes != null) 'feedbackNotes': feedbackNotes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MockInterviewSlotImpl extends MockInterviewSlot {
  _MockInterviewSlotImpl({
    int? id,
    required _isc.UuidValue studentAuthUserId,
    required String studentName,
    required String studentEmail,
    required String targetCompany,
    required String targetRole,
    required String mockRound,
    required DateTime preferredDate,
    String? resumeUrl,
    String? notes,
    String? status,
    String? seniorMentorName,
    String? meetingLink,
    String? feedbackNotes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         studentAuthUserId: studentAuthUserId,
         studentName: studentName,
         studentEmail: studentEmail,
         targetCompany: targetCompany,
         targetRole: targetRole,
         mockRound: mockRound,
         preferredDate: preferredDate,
         resumeUrl: resumeUrl,
         notes: notes,
         status: status,
         seniorMentorName: seniorMentorName,
         meetingLink: meetingLink,
         feedbackNotes: feedbackNotes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MockInterviewSlot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MockInterviewSlot copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? studentAuthUserId,
    String? studentName,
    String? studentEmail,
    String? targetCompany,
    String? targetRole,
    String? mockRound,
    DateTime? preferredDate,
    Object? resumeUrl = _Undefined,
    Object? notes = _Undefined,
    String? status,
    Object? seniorMentorName = _Undefined,
    Object? meetingLink = _Undefined,
    Object? feedbackNotes = _Undefined,
    DateTime? createdAt,
  }) {
    return MockInterviewSlot(
      id: id is int? ? id : this.id,
      studentAuthUserId: studentAuthUserId ?? this.studentAuthUserId,
      studentName: studentName ?? this.studentName,
      studentEmail: studentEmail ?? this.studentEmail,
      targetCompany: targetCompany ?? this.targetCompany,
      targetRole: targetRole ?? this.targetRole,
      mockRound: mockRound ?? this.mockRound,
      preferredDate: preferredDate ?? this.preferredDate,
      resumeUrl: resumeUrl is String? ? resumeUrl : this.resumeUrl,
      notes: notes is String? ? notes : this.notes,
      status: status ?? this.status,
      seniorMentorName: seniorMentorName is String?
          ? seniorMentorName
          : this.seniorMentorName,
      meetingLink: meetingLink is String? ? meetingLink : this.meetingLink,
      feedbackNotes: feedbackNotes is String?
          ? feedbackNotes
          : this.feedbackNotes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
