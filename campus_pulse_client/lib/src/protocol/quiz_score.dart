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

abstract class QuizScore
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuizScore._({
    this.id,
    required this.studentId,
    required this.subject,
    required this.score,
    required this.createdAt,
  });

  factory QuizScore({
    int? id,
    required int studentId,
    required String subject,
    required int score,
    required DateTime createdAt,
  }) = _QuizScoreImpl;

  factory QuizScore.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizScore(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      subject: jsonSerialization['subject'] as String,
      score: jsonSerialization['score'] as int,
      createdAt:
          _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int studentId;

  String subject;

  int score;

  DateTime createdAt;

  /// Returns a shallow copy of this [QuizScore]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuizScore copyWith({
    int? id,
    int? studentId,
    String? subject,
    int? score,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizScore',
      if (id != null) 'id': id,
      'studentId': studentId,
      'subject': subject,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizScore',
      if (id != null) 'id': id,
      'studentId': studentId,
      'subject': subject,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizScoreImpl extends QuizScore {
  _QuizScoreImpl({
    int? id,
    required int studentId,
    required String subject,
    required int score,
    required DateTime createdAt,
  }) : super._(
          id: id,
          studentId: studentId,
          subject: subject,
          score: score,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [QuizScore]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuizScore copyWith({
    Object? id = _Undefined,
    int? studentId,
    String? subject,
    int? score,
    DateTime? createdAt,
  }) {
    return QuizScore(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      subject: subject ?? this.subject,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
