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

abstract class QuizQuestionView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizQuestionView._({
    required this.id,
    required this.subject,
    required this.question,
    required this.options,
  });

  factory QuizQuestionView({
    required int id,
    required String subject,
    required String question,
    required List<String> options,
  }) = _QuizQuestionViewImpl;

  factory QuizQuestionView.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizQuestionView(
      id: jsonSerialization['id'] as int,
      subject: jsonSerialization['subject'] as String,
      question: jsonSerialization['question'] as String,
      options: _il98xzab.Protocol().deserialize<List<String>>(
        jsonSerialization['options'],
      ),
    );
  }

  int id;

  String subject;

  String question;

  List<String> options;

  /// Returns a shallow copy of this [QuizQuestionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizQuestionView copyWith({
    int? id,
    String? subject,
    String? question,
    List<String>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizQuestionView',
      'id': id,
      'subject': subject,
      'question': question,
      'options': options.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizQuestionView',
      'id': id,
      'subject': subject,
      'question': question,
      'options': options.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _QuizQuestionViewImpl extends QuizQuestionView {
  _QuizQuestionViewImpl({
    required int id,
    required String subject,
    required String question,
    required List<String> options,
  }) : super._(
         id: id,
         subject: subject,
         question: question,
         options: options,
       );

  /// Returns a shallow copy of this [QuizQuestionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizQuestionView copyWith({
    int? id,
    String? subject,
    String? question,
    List<String>? options,
  }) {
    return QuizQuestionView(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      question: question ?? this.question,
      options: options ?? this.options.map((e0) => e0).toList(),
    );
  }
}
