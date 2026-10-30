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
import 'quiz_answer_submission.dart' as _icbmbpey;

abstract class QuizSubmission
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizSubmission._({
    this.attemptId,
    required this.subject,
    this.quizId,
    required this.answers,
    required this.durationSeconds,
  });

  factory QuizSubmission({
    String? attemptId,
    required String subject,
    String? quizId,
    required List<_icbmbpey.QuizAnswerSubmission> answers,
    required int durationSeconds,
  }) = _QuizSubmissionImpl;

  factory QuizSubmission.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizSubmission(
      attemptId: jsonSerialization['attemptId'] as String?,
      subject: jsonSerialization['subject'] as String,
      quizId: jsonSerialization['quizId'] as String?,
      answers: _il98xzab.Protocol()
          .deserialize<List<_icbmbpey.QuizAnswerSubmission>>(
            jsonSerialization['answers'],
          ),
      durationSeconds: jsonSerialization['durationSeconds'] as int,
    );
  }

  String? attemptId;

  String subject;

  String? quizId;

  List<_icbmbpey.QuizAnswerSubmission> answers;

  int durationSeconds;

  /// Returns a shallow copy of this [QuizSubmission]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizSubmission copyWith({
    String? attemptId,
    String? subject,
    String? quizId,
    List<_icbmbpey.QuizAnswerSubmission>? answers,
    int? durationSeconds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizSubmission',
      if (attemptId != null) 'attemptId': attemptId,
      'subject': subject,
      if (quizId != null) 'quizId': quizId,
      'answers': answers.toJson(valueToJson: (v) => v.toJson()),
      'durationSeconds': durationSeconds,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizSubmission',
      if (attemptId != null) 'attemptId': attemptId,
      'subject': subject,
      if (quizId != null) 'quizId': quizId,
      'answers': answers.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'durationSeconds': durationSeconds,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizSubmissionImpl extends QuizSubmission {
  _QuizSubmissionImpl({
    String? attemptId,
    required String subject,
    String? quizId,
    required List<_icbmbpey.QuizAnswerSubmission> answers,
    required int durationSeconds,
  }) : super._(
         attemptId: attemptId,
         subject: subject,
         quizId: quizId,
         answers: answers,
         durationSeconds: durationSeconds,
       );

  /// Returns a shallow copy of this [QuizSubmission]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizSubmission copyWith({
    Object? attemptId = _Undefined,
    String? subject,
    Object? quizId = _Undefined,
    List<_icbmbpey.QuizAnswerSubmission>? answers,
    int? durationSeconds,
  }) {
    return QuizSubmission(
      attemptId: attemptId is String? ? attemptId : this.attemptId,
      subject: subject ?? this.subject,
      quizId: quizId is String? ? quizId : this.quizId,
      answers: answers ?? this.answers.map((e0) => e0.copyWith()).toList(),
      durationSeconds: durationSeconds ?? this.durationSeconds,
    );
  }
}
