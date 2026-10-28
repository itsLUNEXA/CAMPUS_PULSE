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

abstract class Student
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Student._({
    this.id,
    required this.name,
    required this.email,
    this.passwordHash,
    required this.branch,
    required this.year,
    required this.interests,
    required this.hostelArea,
  });

  factory Student({
    int? id,
    required String name,
    required String email,
    String? passwordHash,
    required String branch,
    required int year,
    required List<String> interests,
    required String hostelArea,
  }) = _StudentImpl;

  factory Student.fromJson(Map<String, dynamic> jsonSerialization) {
    return Student(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String?,
      branch: jsonSerialization['branch'] as String,
      year: jsonSerialization['year'] as int,
      interests: _il98xzab.Protocol()
          .deserialize<List<String>>(jsonSerialization['interests']),
      hostelArea: jsonSerialization['hostelArea'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String email;

  String? passwordHash;

  String branch;

  int year;

  List<String> interests;

  String hostelArea;

  /// Returns a shallow copy of this [Student]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Student copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
    String? branch,
    int? year,
    List<String>? interests,
    String? hostelArea,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Student',
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      if (passwordHash != null) 'passwordHash': passwordHash,
      'branch': branch,
      'year': year,
      'interests': interests.toJson(),
      'hostelArea': hostelArea,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Student',
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      if (passwordHash != null) 'passwordHash': passwordHash,
      'branch': branch,
      'year': year,
      'interests': interests.toJson(),
      'hostelArea': hostelArea,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentImpl extends Student {
  _StudentImpl({
    int? id,
    required String name,
    required String email,
    String? passwordHash,
    required String branch,
    required int year,
    required List<String> interests,
    required String hostelArea,
  }) : super._(
          id: id,
          name: name,
          email: email,
          passwordHash: passwordHash,
          branch: branch,
          year: year,
          interests: interests,
          hostelArea: hostelArea,
        );

  /// Returns a shallow copy of this [Student]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Student copyWith({
    Object? id = _Undefined,
    String? name,
    String? email,
    Object? passwordHash = _Undefined,
    String? branch,
    int? year,
    List<String>? interests,
    String? hostelArea,
  }) {
    return Student(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash is String? ? passwordHash : this.passwordHash,
      branch: branch ?? this.branch,
      year: year ?? this.year,
      interests: interests ?? this.interests.map((e0) => e0).toList(),
      hostelArea: hostelArea ?? this.hostelArea,
    );
  }
}
