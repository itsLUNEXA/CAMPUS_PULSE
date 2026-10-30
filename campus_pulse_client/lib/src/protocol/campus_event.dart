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

abstract class CampusEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CampusEvent._({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.startTime,
    this.endTime,
    required this.venue,
    this.bannerUrl,
    required this.organizerAuthUserId,
    required this.organizerName,
    int? rsvpCount,
    String? approvalStatus,
    this.rejectionReason,
    this.registrationDeadline,
    bool? isTeamEvent,
    int? minTeamSize,
    int? maxTeamSize,
    int? submissionVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : rsvpCount = rsvpCount ?? 0,
       approvalStatus = approvalStatus ?? 'approved',
       isTeamEvent = isTeamEvent ?? false,
       minTeamSize = minTeamSize ?? 1,
       maxTeamSize = maxTeamSize ?? 1,
       submissionVersion = submissionVersion ?? 1,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory CampusEvent({
    int? id,
    required String title,
    required String description,
    required String category,
    required DateTime startTime,
    DateTime? endTime,
    required String venue,
    String? bannerUrl,
    required _isc.UuidValue organizerAuthUserId,
    required String organizerName,
    int? rsvpCount,
    String? approvalStatus,
    String? rejectionReason,
    DateTime? registrationDeadline,
    bool? isTeamEvent,
    int? minTeamSize,
    int? maxTeamSize,
    int? submissionVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CampusEventImpl;

  factory CampusEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusEvent(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: jsonSerialization['category'] as String,
      startTime: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startTime'],
      ),
      endTime: jsonSerialization['endTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      venue: jsonSerialization['venue'] as String,
      bannerUrl: jsonSerialization['bannerUrl'] as String?,
      organizerAuthUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizerAuthUserId'],
      ),
      organizerName: jsonSerialization['organizerName'] as String,
      rsvpCount: jsonSerialization['rsvpCount'] as int?,
      approvalStatus: jsonSerialization['approvalStatus'] as String?,
      rejectionReason: jsonSerialization['rejectionReason'] as String?,
      registrationDeadline: jsonSerialization['registrationDeadline'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['registrationDeadline'],
            ),
      isTeamEvent: jsonSerialization['isTeamEvent'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isTeamEvent']),
      minTeamSize: jsonSerialization['minTeamSize'] as int?,
      maxTeamSize: jsonSerialization['maxTeamSize'] as int?,
      submissionVersion: jsonSerialization['submissionVersion'] as int?,
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

  String title;

  String description;

  String category;

  DateTime startTime;

  DateTime? endTime;

  String venue;

  String? bannerUrl;

  _isc.UuidValue organizerAuthUserId;

  String organizerName;

  int rsvpCount;

  String approvalStatus;

  String? rejectionReason;

  DateTime? registrationDeadline;

  bool isTeamEvent;

  int minTeamSize;

  int maxTeamSize;

  int submissionVersion;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CampusEvent copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    DateTime? startTime,
    DateTime? endTime,
    String? venue,
    String? bannerUrl,
    _isc.UuidValue? organizerAuthUserId,
    String? organizerName,
    int? rsvpCount,
    String? approvalStatus,
    String? rejectionReason,
    DateTime? registrationDeadline,
    bool? isTeamEvent,
    int? minTeamSize,
    int? maxTeamSize,
    int? submissionVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusEvent',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'category': category,
      'startTime': startTime.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      'venue': venue,
      if (bannerUrl != null) 'bannerUrl': bannerUrl,
      'organizerAuthUserId': organizerAuthUserId.toJson(),
      'organizerName': organizerName,
      'rsvpCount': rsvpCount,
      'approvalStatus': approvalStatus,
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      if (registrationDeadline != null)
        'registrationDeadline': registrationDeadline?.toJson(),
      'isTeamEvent': isTeamEvent,
      'minTeamSize': minTeamSize,
      'maxTeamSize': maxTeamSize,
      'submissionVersion': submissionVersion,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusEvent',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'category': category,
      'startTime': startTime.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      'venue': venue,
      if (bannerUrl != null) 'bannerUrl': bannerUrl,
      'organizerAuthUserId': organizerAuthUserId.toJson(),
      'organizerName': organizerName,
      'rsvpCount': rsvpCount,
      'approvalStatus': approvalStatus,
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      if (registrationDeadline != null)
        'registrationDeadline': registrationDeadline?.toJson(),
      'isTeamEvent': isTeamEvent,
      'minTeamSize': minTeamSize,
      'maxTeamSize': maxTeamSize,
      'submissionVersion': submissionVersion,
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

class _CampusEventImpl extends CampusEvent {
  _CampusEventImpl({
    int? id,
    required String title,
    required String description,
    required String category,
    required DateTime startTime,
    DateTime? endTime,
    required String venue,
    String? bannerUrl,
    required _isc.UuidValue organizerAuthUserId,
    required String organizerName,
    int? rsvpCount,
    String? approvalStatus,
    String? rejectionReason,
    DateTime? registrationDeadline,
    bool? isTeamEvent,
    int? minTeamSize,
    int? maxTeamSize,
    int? submissionVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         title: title,
         description: description,
         category: category,
         startTime: startTime,
         endTime: endTime,
         venue: venue,
         bannerUrl: bannerUrl,
         organizerAuthUserId: organizerAuthUserId,
         organizerName: organizerName,
         rsvpCount: rsvpCount,
         approvalStatus: approvalStatus,
         rejectionReason: rejectionReason,
         registrationDeadline: registrationDeadline,
         isTeamEvent: isTeamEvent,
         minTeamSize: minTeamSize,
         maxTeamSize: maxTeamSize,
         submissionVersion: submissionVersion,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CampusEvent copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    String? category,
    DateTime? startTime,
    Object? endTime = _Undefined,
    String? venue,
    Object? bannerUrl = _Undefined,
    _isc.UuidValue? organizerAuthUserId,
    String? organizerName,
    int? rsvpCount,
    String? approvalStatus,
    Object? rejectionReason = _Undefined,
    Object? registrationDeadline = _Undefined,
    bool? isTeamEvent,
    int? minTeamSize,
    int? maxTeamSize,
    int? submissionVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CampusEvent(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      startTime: startTime ?? this.startTime,
      endTime: endTime is DateTime? ? endTime : this.endTime,
      venue: venue ?? this.venue,
      bannerUrl: bannerUrl is String? ? bannerUrl : this.bannerUrl,
      organizerAuthUserId: organizerAuthUserId ?? this.organizerAuthUserId,
      organizerName: organizerName ?? this.organizerName,
      rsvpCount: rsvpCount ?? this.rsvpCount,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      rejectionReason: rejectionReason is String?
          ? rejectionReason
          : this.rejectionReason,
      registrationDeadline: registrationDeadline is DateTime?
          ? registrationDeadline
          : this.registrationDeadline,
      isTeamEvent: isTeamEvent ?? this.isTeamEvent,
      minTeamSize: minTeamSize ?? this.minTeamSize,
      maxTeamSize: maxTeamSize ?? this.maxTeamSize,
      submissionVersion: submissionVersion ?? this.submissionVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
