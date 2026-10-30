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

abstract class SeniorExperience
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SeniorExperience._({
    this.id,
    required this.companyName,
    required this.seniorName,
    required this.seniorBranch,
    required this.batchYear,
    required this.placedRole,
    this.packageOffered,
    int? difficultyRating,
    required this.interviewQuestions,
    required this.experienceReview,
    required this.tipsForJuniors,
    this.contactHandle,
    bool? verified,
    DateTime? createdAt,
  }) : difficultyRating = difficultyRating ?? 3,
       verified = verified ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory SeniorExperience({
    int? id,
    required String companyName,
    required String seniorName,
    required String seniorBranch,
    required int batchYear,
    required String placedRole,
    String? packageOffered,
    int? difficultyRating,
    required List<String> interviewQuestions,
    required String experienceReview,
    required String tipsForJuniors,
    String? contactHandle,
    bool? verified,
    DateTime? createdAt,
  }) = _SeniorExperienceImpl;

  factory SeniorExperience.fromJson(Map<String, dynamic> jsonSerialization) {
    return SeniorExperience(
      id: jsonSerialization['id'] as int?,
      companyName: jsonSerialization['companyName'] as String,
      seniorName: jsonSerialization['seniorName'] as String,
      seniorBranch: jsonSerialization['seniorBranch'] as String,
      batchYear: jsonSerialization['batchYear'] as int,
      placedRole: jsonSerialization['placedRole'] as String,
      packageOffered: jsonSerialization['packageOffered'] as String?,
      difficultyRating: jsonSerialization['difficultyRating'] as int?,
      interviewQuestions: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['interviewQuestions'],
      ),
      experienceReview: jsonSerialization['experienceReview'] as String,
      tipsForJuniors: jsonSerialization['tipsForJuniors'] as String,
      contactHandle: jsonSerialization['contactHandle'] as String?,
      verified: jsonSerialization['verified'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['verified']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String companyName;

  String seniorName;

  String seniorBranch;

  int batchYear;

  String placedRole;

  String? packageOffered;

  int difficultyRating;

  List<String> interviewQuestions;

  String experienceReview;

  String tipsForJuniors;

  String? contactHandle;

  bool verified;

  DateTime createdAt;

  /// Returns a shallow copy of this [SeniorExperience]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SeniorExperience copyWith({
    int? id,
    String? companyName,
    String? seniorName,
    String? seniorBranch,
    int? batchYear,
    String? placedRole,
    String? packageOffered,
    int? difficultyRating,
    List<String>? interviewQuestions,
    String? experienceReview,
    String? tipsForJuniors,
    String? contactHandle,
    bool? verified,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SeniorExperience',
      if (id != null) 'id': id,
      'companyName': companyName,
      'seniorName': seniorName,
      'seniorBranch': seniorBranch,
      'batchYear': batchYear,
      'placedRole': placedRole,
      if (packageOffered != null) 'packageOffered': packageOffered,
      'difficultyRating': difficultyRating,
      'interviewQuestions': interviewQuestions.toJson(),
      'experienceReview': experienceReview,
      'tipsForJuniors': tipsForJuniors,
      if (contactHandle != null) 'contactHandle': contactHandle,
      'verified': verified,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SeniorExperience',
      if (id != null) 'id': id,
      'companyName': companyName,
      'seniorName': seniorName,
      'seniorBranch': seniorBranch,
      'batchYear': batchYear,
      'placedRole': placedRole,
      if (packageOffered != null) 'packageOffered': packageOffered,
      'difficultyRating': difficultyRating,
      'interviewQuestions': interviewQuestions.toJson(),
      'experienceReview': experienceReview,
      'tipsForJuniors': tipsForJuniors,
      if (contactHandle != null) 'contactHandle': contactHandle,
      'verified': verified,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeniorExperienceImpl extends SeniorExperience {
  _SeniorExperienceImpl({
    int? id,
    required String companyName,
    required String seniorName,
    required String seniorBranch,
    required int batchYear,
    required String placedRole,
    String? packageOffered,
    int? difficultyRating,
    required List<String> interviewQuestions,
    required String experienceReview,
    required String tipsForJuniors,
    String? contactHandle,
    bool? verified,
    DateTime? createdAt,
  }) : super._(
         id: id,
         companyName: companyName,
         seniorName: seniorName,
         seniorBranch: seniorBranch,
         batchYear: batchYear,
         placedRole: placedRole,
         packageOffered: packageOffered,
         difficultyRating: difficultyRating,
         interviewQuestions: interviewQuestions,
         experienceReview: experienceReview,
         tipsForJuniors: tipsForJuniors,
         contactHandle: contactHandle,
         verified: verified,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SeniorExperience]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SeniorExperience copyWith({
    Object? id = _Undefined,
    String? companyName,
    String? seniorName,
    String? seniorBranch,
    int? batchYear,
    String? placedRole,
    Object? packageOffered = _Undefined,
    int? difficultyRating,
    List<String>? interviewQuestions,
    String? experienceReview,
    String? tipsForJuniors,
    Object? contactHandle = _Undefined,
    bool? verified,
    DateTime? createdAt,
  }) {
    return SeniorExperience(
      id: id is int? ? id : this.id,
      companyName: companyName ?? this.companyName,
      seniorName: seniorName ?? this.seniorName,
      seniorBranch: seniorBranch ?? this.seniorBranch,
      batchYear: batchYear ?? this.batchYear,
      placedRole: placedRole ?? this.placedRole,
      packageOffered: packageOffered is String?
          ? packageOffered
          : this.packageOffered,
      difficultyRating: difficultyRating ?? this.difficultyRating,
      interviewQuestions:
          interviewQuestions ??
          this.interviewQuestions.map((e0) => e0).toList(),
      experienceReview: experienceReview ?? this.experienceReview,
      tipsForJuniors: tipsForJuniors ?? this.tipsForJuniors,
      contactHandle: contactHandle is String?
          ? contactHandle
          : this.contactHandle,
      verified: verified ?? this.verified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
