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
    required this.rank,
    required this.authUserId,
    required this.studentName,
    required this.branch,
    this.academicYear,
    required this.score,
    required this.quizzesTaken,
    required this.accuracy,
  });

  factory LeaderboardEntry({
    required int rank,
    required _is.UuidValue authUserId,
    required String studentName,
    required String branch,
    int? academicYear,
    required int score,
    required int quizzesTaken,
    required double accuracy,
  }) = _LeaderboardEntryImpl;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaderboardEntry(
      rank: jsonSerialization['rank'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      branch: jsonSerialization['branch'] as String,
      academicYear: jsonSerialization['academicYear'] as int?,
      score: jsonSerialization['score'] as int,
      quizzesTaken: jsonSerialization['quizzesTaken'] as int,
      accuracy: (jsonSerialization['accuracy'] as num).toDouble(),
    );
  }

  int rank;

  _is.UuidValue authUserId;

  String studentName;

  String branch;

  int? academicYear;

  int score;

  int quizzesTaken;

  double accuracy;

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LeaderboardEntry copyWith({
    int? rank,
    _is.UuidValue? authUserId,
    String? studentName,
    String? branch,
    int? academicYear,
    int? score,
    int? quizzesTaken,
    double? accuracy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeaderboardEntry',
      'rank': rank,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'branch': branch,
      if (academicYear != null) 'academicYear': academicYear,
      'score': score,
      'quizzesTaken': quizzesTaken,
      'accuracy': accuracy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeaderboardEntry',
      'rank': rank,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'branch': branch,
      if (academicYear != null) 'academicYear': academicYear,
      'score': score,
      'quizzesTaken': quizzesTaken,
      'accuracy': accuracy,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeaderboardEntryImpl extends LeaderboardEntry {
  _LeaderboardEntryImpl({
    required int rank,
    required _is.UuidValue authUserId,
    required String studentName,
    required String branch,
    int? academicYear,
    required int score,
    required int quizzesTaken,
    required double accuracy,
  }) : super._(
         rank: rank,
         authUserId: authUserId,
         studentName: studentName,
         branch: branch,
         academicYear: academicYear,
         score: score,
         quizzesTaken: quizzesTaken,
         accuracy: accuracy,
       );

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LeaderboardEntry copyWith({
    int? rank,
    _is.UuidValue? authUserId,
    String? studentName,
    String? branch,
    Object? academicYear = _Undefined,
    int? score,
    int? quizzesTaken,
    double? accuracy,
  }) {
    return LeaderboardEntry(
      rank: rank ?? this.rank,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      branch: branch ?? this.branch,
      academicYear: academicYear is int? ? academicYear : this.academicYear,
      score: score ?? this.score,
      quizzesTaken: quizzesTaken ?? this.quizzesTaken,
      accuracy: accuracy ?? this.accuracy,
    );
  }
}
