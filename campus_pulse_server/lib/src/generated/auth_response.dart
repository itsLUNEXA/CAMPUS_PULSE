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
import 'student.dart' as _iwzlgl4r;

abstract class AuthResponse
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AuthResponse._({
    required this.success,
    this.message,
    this.token,
    this.student,
  });

  factory AuthResponse({
    required bool success,
    String? message,
    String? token,
    _iwzlgl4r.Student? student,
  }) = _AuthResponseImpl;

  factory AuthResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthResponse(
      success: _is.BoolJsonExtension.fromJson(jsonSerialization['success']),
      message: jsonSerialization['message'] as String?,
      token: jsonSerialization['token'] as String?,
      student: jsonSerialization['student'] == null
          ? null
          : _i2t5n14n.Protocol()
              .deserialize<_iwzlgl4r.Student>(jsonSerialization['student']),
    );
  }

  bool success;

  String? message;

  String? token;

  _iwzlgl4r.Student? student;

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AuthResponse copyWith({
    bool? success,
    String? message,
    String? token,
    _iwzlgl4r.Student? student,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuthResponse',
      'success': success,
      if (message != null) 'message': message,
      if (token != null) 'token': token,
      if (student != null) 'student': student?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuthResponse',
      'success': success,
      if (message != null) 'message': message,
      if (token != null) 'token': token,
      if (student != null) 'student': student?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthResponseImpl extends AuthResponse {
  _AuthResponseImpl({
    required bool success,
    String? message,
    String? token,
    _iwzlgl4r.Student? student,
  }) : super._(
          success: success,
          message: message,
          token: token,
          student: student,
        );

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AuthResponse copyWith({
    bool? success,
    Object? message = _Undefined,
    Object? token = _Undefined,
    Object? student = _Undefined,
  }) {
    return AuthResponse(
      success: success ?? this.success,
      message: message is String? ? message : this.message,
      token: token is String? ? token : this.token,
      student:
          student is _iwzlgl4r.Student? ? student : this.student?.copyWith(),
    );
  }
}
