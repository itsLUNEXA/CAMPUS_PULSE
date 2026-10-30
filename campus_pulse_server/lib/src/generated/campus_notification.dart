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

abstract class CampusNotification
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CampusNotification._({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
  });

  factory CampusNotification({
    required String id,
    required String title,
    required String message,
    required String type,
    required DateTime timestamp,
  }) = _CampusNotificationImpl;

  factory CampusNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusNotification(
      id: jsonSerialization['id'] as String,
      title: jsonSerialization['title'] as String,
      message: jsonSerialization['message'] as String,
      type: jsonSerialization['type'] as String,
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  String id;

  String title;

  String message;

  String type;

  DateTime timestamp;

  /// Returns a shallow copy of this [CampusNotification]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CampusNotification copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusNotification',
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusNotification',
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CampusNotificationImpl extends CampusNotification {
  _CampusNotificationImpl({
    required String id,
    required String title,
    required String message,
    required String type,
    required DateTime timestamp,
  }) : super._(
         id: id,
         title: title,
         message: message,
         type: type,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [CampusNotification]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CampusNotification copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    DateTime? timestamp,
  }) {
    return CampusNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
