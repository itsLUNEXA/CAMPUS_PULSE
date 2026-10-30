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

abstract class QuizResultItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizResultItem._({
    required this.questionId,
    required this.question,
    required this.options,
    required this.selectedOptionIndex,
    required this.correctOptionIndex,
    required this.isCorrect,
    required this.explanation,
  });

  factory QuizResultItem({
    required int questionId,
    required String question,
    required List<String> options,
    required int selectedOptionIndex,
    required int correctOptionIndex,
    required bool isCorrect,
    required String explanation,
  }) = _QuizResultItemImpl;

  factory QuizResultItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizResultItem(
      questionId: jsonSerialization['questionId'] as int,
      question: jsonSerialization['question'] as String,
      options: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['options'],
      ),
      selectedOptionIndex: jsonSerialization['selectedOptionIndex'] as int,
      correctOptionIndex: jsonSerialization['correctOptionIndex'] as int,
      isCorrect: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isCorrect'],
      ),
      explanation: jsonSerialization['explanation'] as String,
    );
  }

  int questionId;

  String question;

  List<String> options;

  int selectedOptionIndex;

  int correctOptionIndex;

  bool isCorrect;

  String explanation;

  /// Returns a shallow copy of this [QuizResultItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizResultItem copyWith({
    int? questionId,
    String? question,
    List<String>? options,
    int? selectedOptionIndex,
    int? correctOptionIndex,
    bool? isCorrect,
    String? explanation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizResultItem',
      'questionId': questionId,
      'question': question,
      'options': options.toJson(),
      'selectedOptionIndex': selectedOptionIndex,
      'correctOptionIndex': correctOptionIndex,
      'isCorrect': isCorrect,
      'explanation': explanation,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizResultItem',
      'questionId': questionId,
      'question': question,
      'options': options.toJson(),
      'selectedOptionIndex': selectedOptionIndex,
      'correctOptionIndex': correctOptionIndex,
      'isCorrect': isCorrect,
      'explanation': explanation,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _QuizResultItemImpl extends QuizResultItem {
  _QuizResultItemImpl({
    required int questionId,
    required String question,
    required List<String> options,
    required int selectedOptionIndex,
    required int correctOptionIndex,
    required bool isCorrect,
    required String explanation,
  }) : super._(
         questionId: questionId,
         question: question,
         options: options,
         selectedOptionIndex: selectedOptionIndex,
         correctOptionIndex: correctOptionIndex,
         isCorrect: isCorrect,
         explanation: explanation,
       );

  /// Returns a shallow copy of this [QuizResultItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizResultItem copyWith({
    int? questionId,
    String? question,
    List<String>? options,
    int? selectedOptionIndex,
    int? correctOptionIndex,
    bool? isCorrect,
    String? explanation,
  }) {
    return QuizResultItem(
      questionId: questionId ?? this.questionId,
      question: question ?? this.question,
      options: options ?? this.options.map((e0) => e0).toList(),
      selectedOptionIndex: selectedOptionIndex ?? this.selectedOptionIndex,
      correctOptionIndex: correctOptionIndex ?? this.correctOptionIndex,
      isCorrect: isCorrect ?? this.isCorrect,
      explanation: explanation ?? this.explanation,
    );
  }
}
