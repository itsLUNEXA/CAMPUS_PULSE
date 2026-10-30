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

abstract class LeaderboardEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LeaderboardEntry._({
    required this.rank,
    required this.authUserId,
    required this.studentName,
    required this.branch,
    required this.score,
    required this.quizzesTaken,
    required this.accuracy,
  });

  factory LeaderboardEntry({
    required int rank,
    required _isc.UuidValue authUserId,
    required String studentName,
    required String branch,
    required int score,
    required int quizzesTaken,
    required double accuracy,
  }) = _LeaderboardEntryImpl;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaderboardEntry(
      rank: jsonSerialization['rank'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      branch: jsonSerialization['branch'] as String,
      score: jsonSerialization['score'] as int,
      quizzesTaken: jsonSerialization['quizzesTaken'] as int,
      accuracy: (jsonSerialization['accuracy'] as num).toDouble(),
    );
  }

  int rank;

  _isc.UuidValue authUserId;

  String studentName;

  String branch;

  int score;

  int quizzesTaken;

  double accuracy;

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LeaderboardEntry copyWith({
    int? rank,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? branch,
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
      'score': score,
      'quizzesTaken': quizzesTaken,
      'accuracy': accuracy,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LeaderboardEntryImpl extends LeaderboardEntry {
  _LeaderboardEntryImpl({
    required int rank,
    required _isc.UuidValue authUserId,
    required String studentName,
    required String branch,
    required int score,
    required int quizzesTaken,
    required double accuracy,
  }) : super._(
         rank: rank,
         authUserId: authUserId,
         studentName: studentName,
         branch: branch,
         score: score,
         quizzesTaken: quizzesTaken,
         accuracy: accuracy,
       );

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LeaderboardEntry copyWith({
    int? rank,
    _isc.UuidValue? authUserId,
    String? studentName,
    String? branch,
    int? score,
    int? quizzesTaken,
    double? accuracy,
  }) {
    return LeaderboardEntry(
      rank: rank ?? this.rank,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      branch: branch ?? this.branch,
      score: score ?? this.score,
      quizzesTaken: quizzesTaken ?? this.quizzesTaken,
      accuracy: accuracy ?? this.accuracy,
    );
  }
}
