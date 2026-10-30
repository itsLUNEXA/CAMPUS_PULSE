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
import 'package:campus_pulse_server/src/generated/protocol.dart' as _i2t5n14n;
import 'package:serverpod/serverpod.dart' as _is;
import 'quiz_result_item.dart' as _i1u2fv9w;

abstract class QuizResultSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  QuizResultSummary._({
    required this.attemptId,
    required this.subject,
    required this.score,
    required this.totalQuestions,
    required this.percentage,
    required this.durationSeconds,
    required this.completedAt,
    required this.items,
  });

  factory QuizResultSummary({
    required int attemptId,
    required String subject,
    required int score,
    required int totalQuestions,
    required double percentage,
    required int durationSeconds,
    required DateTime completedAt,
    required List<_i1u2fv9w.QuizResultItem> items,
  }) = _QuizResultSummaryImpl;

  factory QuizResultSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizResultSummary(
      attemptId: jsonSerialization['attemptId'] as int,
      subject: jsonSerialization['subject'] as String,
      score: jsonSerialization['score'] as int,
      totalQuestions: jsonSerialization['totalQuestions'] as int,
      percentage: (jsonSerialization['percentage'] as num).toDouble(),
      durationSeconds: jsonSerialization['durationSeconds'] as int,
      completedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
      items: _i2t5n14n.Protocol().deserialize<List<_i1u2fv9w.QuizResultItem>>(
        jsonSerialization['items'],
      ),
    );
  }

  int attemptId;

  String subject;

  int score;

  int totalQuestions;

  double percentage;

  int durationSeconds;

  DateTime completedAt;

  List<_i1u2fv9w.QuizResultItem> items;

  /// Returns a shallow copy of this [QuizResultSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuizResultSummary copyWith({
    int? attemptId,
    String? subject,
    int? score,
    int? totalQuestions,
    double? percentage,
    int? durationSeconds,
    DateTime? completedAt,
    List<_i1u2fv9w.QuizResultItem>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizResultSummary',
      'attemptId': attemptId,
      'subject': subject,
      'score': score,
      'totalQuestions': totalQuestions,
      'percentage': percentage,
      'durationSeconds': durationSeconds,
      'completedAt': completedAt.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizResultSummary',
      'attemptId': attemptId,
      'subject': subject,
      'score': score,
      'totalQuestions': totalQuestions,
      'percentage': percentage,
      'durationSeconds': durationSeconds,
      'completedAt': completedAt.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _QuizResultSummaryImpl extends QuizResultSummary {
  _QuizResultSummaryImpl({
    required int attemptId,
    required String subject,
    required int score,
    required int totalQuestions,
    required double percentage,
    required int durationSeconds,
    required DateTime completedAt,
    required List<_i1u2fv9w.QuizResultItem> items,
  }) : super._(
         attemptId: attemptId,
         subject: subject,
         score: score,
         totalQuestions: totalQuestions,
         percentage: percentage,
         durationSeconds: durationSeconds,
         completedAt: completedAt,
         items: items,
       );

  /// Returns a shallow copy of this [QuizResultSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuizResultSummary copyWith({
    int? attemptId,
    String? subject,
    int? score,
    int? totalQuestions,
    double? percentage,
    int? durationSeconds,
    DateTime? completedAt,
    List<_i1u2fv9w.QuizResultItem>? items,
  }) {
    return QuizResultSummary(
      attemptId: attemptId ?? this.attemptId,
      subject: subject ?? this.subject,
      score: score ?? this.score,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      percentage: percentage ?? this.percentage,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      completedAt: completedAt ?? this.completedAt,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
