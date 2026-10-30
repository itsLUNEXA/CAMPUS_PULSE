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
import 'package:serverpod/serverpod.dart' as _is;

abstract class QuizAnswerSubmission
    implements _is.SerializableModel, _is.ProtocolSerialization {
  QuizAnswerSubmission._({
    required this.questionId,
    required this.selectedOptionIndex,
  });

  factory QuizAnswerSubmission({
    required int questionId,
    required int selectedOptionIndex,
  }) = _QuizAnswerSubmissionImpl;

  factory QuizAnswerSubmission.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return QuizAnswerSubmission(
      questionId: jsonSerialization['questionId'] as int,
      selectedOptionIndex: jsonSerialization['selectedOptionIndex'] as int,
    );
  }

  int questionId;

  int selectedOptionIndex;

  /// Returns a shallow copy of this [QuizAnswerSubmission]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuizAnswerSubmission copyWith({
    int? questionId,
    int? selectedOptionIndex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizAnswerSubmission',
      'questionId': questionId,
      'selectedOptionIndex': selectedOptionIndex,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizAnswerSubmission',
      'questionId': questionId,
      'selectedOptionIndex': selectedOptionIndex,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _QuizAnswerSubmissionImpl extends QuizAnswerSubmission {
  _QuizAnswerSubmissionImpl({
    required int questionId,
    required int selectedOptionIndex,
  }) : super._(
         questionId: questionId,
         selectedOptionIndex: selectedOptionIndex,
       );

  /// Returns a shallow copy of this [QuizAnswerSubmission]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuizAnswerSubmission copyWith({
    int? questionId,
    int? selectedOptionIndex,
  }) {
    return QuizAnswerSubmission(
      questionId: questionId ?? this.questionId,
      selectedOptionIndex: selectedOptionIndex ?? this.selectedOptionIndex,
    );
  }
}
