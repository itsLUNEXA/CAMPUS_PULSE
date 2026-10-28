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

abstract class QuizQuestion
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizQuestion._({
    this.id,
    required this.subject,
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  factory QuizQuestion({
    int? id,
    required String subject,
    required String question,
    required List<String> options,
    required int correctIndex,
  }) = _QuizQuestionImpl;

  factory QuizQuestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizQuestion(
      id: jsonSerialization['id'] as int?,
      subject: jsonSerialization['subject'] as String,
      question: jsonSerialization['question'] as String,
      options: _il98xzab.Protocol()
          .deserialize<List<String>>(jsonSerialization['options']),
      correctIndex: jsonSerialization['correctIndex'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String subject;

  String question;

  List<String> options;

  int correctIndex;

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizQuestion copyWith({
    int? id,
    String? subject,
    String? question,
    List<String>? options,
    int? correctIndex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizQuestion',
      if (id != null) 'id': id,
      'subject': subject,
      'question': question,
      'options': options.toJson(),
      'correctIndex': correctIndex,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizQuestion',
      if (id != null) 'id': id,
      'subject': subject,
      'question': question,
      'options': options.toJson(),
      'correctIndex': correctIndex,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizQuestionImpl extends QuizQuestion {
  _QuizQuestionImpl({
    int? id,
    required String subject,
    required String question,
    required List<String> options,
    required int correctIndex,
  }) : super._(
          id: id,
          subject: subject,
          question: question,
          options: options,
          correctIndex: correctIndex,
        );

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizQuestion copyWith({
    Object? id = _Undefined,
    String? subject,
    String? question,
    List<String>? options,
    int? correctIndex,
  }) {
    return QuizQuestion(
      id: id is int? ? id : this.id,
      subject: subject ?? this.subject,
      question: question ?? this.question,
      options: options ?? this.options.map((e0) => e0).toList(),
      correctIndex: correctIndex ?? this.correctIndex,
    );
  }
}
