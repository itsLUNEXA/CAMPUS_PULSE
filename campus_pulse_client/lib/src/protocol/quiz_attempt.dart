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

abstract class QuizAttempt
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizAttempt._({
    this.id,
    this.attemptId,
    required this.authUserId,
    required this.studentName,
    required this.studentBranch,
    required this.subject,
    this.quizId,
    required this.score,
    required this.totalQuestions,
    required this.percentage,
    required this.durationSeconds,
    int? attemptNumber,
    bool? isRetake,
    DateTime? completedAt,
  }) : attemptNumber = attemptNumber ?? 1,
       isRetake = isRetake ?? false,
       completedAt = completedAt ?? DateTime.now();

  factory QuizAttempt({
    int? id,
    String? attemptId,
    required _isc.UuidValue authUserId,
    required String studentName,
    required String studentBranch,
    required String subject,
    String? quizId,
    required int score,
    required int totalQuestions,
    required double percentage,
    required int durationSeconds,
    int? attemptNumber,
    bool? isRetake,
    DateTime? completedAt,
  }) = _QuizAttemptImpl;

  factory QuizAttempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizAttempt(
      id: jsonSerialization['id'] as int?,
      attemptId: jsonSerialization['attemptId'] as String?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      studentBranch: jsonSerialization['studentBranch'] as String,
      subject: jsonSerialization['subject'] as String,
      quizId: jsonSerialization['quizId'] as String?,
      score: jsonSerialization['score'] as int,
      totalQuestions: jsonSerialization['totalQuestions'] as int,
      percentage: (jsonSerialization['percentage'] as num).toDouble(),
      durationSeconds: jsonSerialization['durationSeconds'] as int,
      attemptNumber: jsonSerialization['attemptNumber'] as int?,
      isRetake: jsonSerialization['isRetake'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isRetake']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? attemptId;

  _isc.UuidValue authUserId;

  String studentName;

  String studentBranch;

  String subject;

  String? quizId;

  int score;

  int totalQuestions;

  double percentage;

  int durationSeconds;

  int attemptNumber;

  bool isRetake;

  DateTime completedAt;

  /// Returns a shallow copy of this [QuizAttempt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizAttempt copyWith({
    int? id,
    String? attemptId,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? studentBranch,
    String? subject,
    String? quizId,
    int? score,
    int? totalQuestions,
    double? percentage,
    int? durationSeconds,
    int? attemptNumber,
    bool? isRetake,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizAttempt',
      if (id != null) 'id': id,
      if (attemptId != null) 'attemptId': attemptId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'studentBranch': studentBranch,
      'subject': subject,
      if (quizId != null) 'quizId': quizId,
      'score': score,
      'totalQuestions': totalQuestions,
      'percentage': percentage,
      'durationSeconds': durationSeconds,
      'attemptNumber': attemptNumber,
      'isRetake': isRetake,
      'completedAt': completedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizAttempt',
      if (id != null) 'id': id,
      if (attemptId != null) 'attemptId': attemptId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'studentBranch': studentBranch,
      'subject': subject,
      if (quizId != null) 'quizId': quizId,
      'score': score,
      'totalQuestions': totalQuestions,
      'percentage': percentage,
      'durationSeconds': durationSeconds,
      'attemptNumber': attemptNumber,
      'isRetake': isRetake,
      'completedAt': completedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizAttemptImpl extends QuizAttempt {
  _QuizAttemptImpl({
    int? id,
    String? attemptId,
    required _isc.UuidValue authUserId,
    required String studentName,
    required String studentBranch,
    required String subject,
    String? quizId,
    required int score,
    required int totalQuestions,
    required double percentage,
    required int durationSeconds,
    int? attemptNumber,
    bool? isRetake,
    DateTime? completedAt,
  }) : super._(
         id: id,
         attemptId: attemptId,
         authUserId: authUserId,
         studentName: studentName,
         studentBranch: studentBranch,
         subject: subject,
         quizId: quizId,
         score: score,
         totalQuestions: totalQuestions,
         percentage: percentage,
         durationSeconds: durationSeconds,
         attemptNumber: attemptNumber,
         isRetake: isRetake,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [QuizAttempt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizAttempt copyWith({
    Object? id = _Undefined,
    Object? attemptId = _Undefined,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? studentBranch,
    String? subject,
    Object? quizId = _Undefined,
    int? score,
    int? totalQuestions,
    double? percentage,
    int? durationSeconds,
    int? attemptNumber,
    bool? isRetake,
    DateTime? completedAt,
  }) {
    return QuizAttempt(
      id: id is int? ? id : this.id,
      attemptId: attemptId is String? ? attemptId : this.attemptId,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      studentBranch: studentBranch ?? this.studentBranch,
      subject: subject ?? this.subject,
      quizId: quizId is String? ? quizId : this.quizId,
      score: score ?? this.score,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      percentage: percentage ?? this.percentage,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      isRetake: isRetake ?? this.isRetake,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
