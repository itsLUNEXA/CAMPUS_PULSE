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

abstract class LeaderboardEntry
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LeaderboardEntry._({
    required this.studentName,
    required this.branch,
    required this.year,
    required this.subject,
    required this.score,
    required this.createdAt,
  });

  factory LeaderboardEntry({
    required String studentName,
    required String branch,
    required int year,
    required String subject,
    required int score,
    required DateTime createdAt,
  }) = _LeaderboardEntryImpl;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaderboardEntry(
      studentName: jsonSerialization['studentName'] as String,
      branch: jsonSerialization['branch'] as String,
      year: jsonSerialization['year'] as int,
      subject: jsonSerialization['subject'] as String,
      score: jsonSerialization['score'] as int,
      createdAt:
          _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  String studentName;

  String branch;

  int year;

  String subject;

  int score;

  DateTime createdAt;

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LeaderboardEntry copyWith({
    String? studentName,
    String? branch,
    int? year,
    String? subject,
    int? score,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeaderboardEntry',
      'studentName': studentName,
      'branch': branch,
      'year': year,
      'subject': subject,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeaderboardEntry',
      'studentName': studentName,
      'branch': branch,
      'year': year,
      'subject': subject,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _LeaderboardEntryImpl extends LeaderboardEntry {
  _LeaderboardEntryImpl({
    required String studentName,
    required String branch,
    required int year,
    required String subject,
    required int score,
    required DateTime createdAt,
  }) : super._(
          studentName: studentName,
          branch: branch,
          year: year,
          subject: subject,
          score: score,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LeaderboardEntry copyWith({
    String? studentName,
    String? branch,
    int? year,
    String? subject,
    int? score,
    DateTime? createdAt,
  }) {
    return LeaderboardEntry(
      studentName: studentName ?? this.studentName,
      branch: branch ?? this.branch,
      year: year ?? this.year,
      subject: subject ?? this.subject,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
