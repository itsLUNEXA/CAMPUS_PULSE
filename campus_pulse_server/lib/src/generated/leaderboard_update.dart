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

abstract class LeaderboardUpdate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LeaderboardUpdate._({
    required this.subject,
    required this.studentName,
    required this.score,
    required this.updatedAt,
  });

  factory LeaderboardUpdate({
    required String subject,
    required String studentName,
    required int score,
    required DateTime updatedAt,
  }) = _LeaderboardUpdateImpl;

  factory LeaderboardUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaderboardUpdate(
      subject: jsonSerialization['subject'] as String,
      studentName: jsonSerialization['studentName'] as String,
      score: jsonSerialization['score'] as int,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  String subject;

  String studentName;

  int score;

  DateTime updatedAt;

  /// Returns a shallow copy of this [LeaderboardUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LeaderboardUpdate copyWith({
    String? subject,
    String? studentName,
    int? score,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeaderboardUpdate',
      'subject': subject,
      'studentName': studentName,
      'score': score,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeaderboardUpdate',
      'subject': subject,
      'studentName': studentName,
      'score': score,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _LeaderboardUpdateImpl extends LeaderboardUpdate {
  _LeaderboardUpdateImpl({
    required String subject,
    required String studentName,
    required int score,
    required DateTime updatedAt,
  }) : super._(
         subject: subject,
         studentName: studentName,
         score: score,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [LeaderboardUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LeaderboardUpdate copyWith({
    String? subject,
    String? studentName,
    int? score,
    DateTime? updatedAt,
  }) {
    return LeaderboardUpdate(
      subject: subject ?? this.subject,
      studentName: studentName ?? this.studentName,
      score: score ?? this.score,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
