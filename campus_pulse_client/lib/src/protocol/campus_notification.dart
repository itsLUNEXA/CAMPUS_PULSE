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

abstract class CampusNotification
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CampusNotification._({
    this.id,
    required this.authUserId,
    required this.title,
    required this.message,
    required this.type,
    this.targetRoute,
    this.targetId,
    bool? isRead,
    DateTime? createdAt,
    this.eventIdTag,
  }) : isRead = isRead ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory CampusNotification({
    int? id,
    required _isc.UuidValue authUserId,
    required String title,
    required String message,
    required String type,
    String? targetRoute,
    String? targetId,
    bool? isRead,
    DateTime? createdAt,
    String? eventIdTag,
  }) = _CampusNotificationImpl;

  factory CampusNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusNotification(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      title: jsonSerialization['title'] as String,
      message: jsonSerialization['message'] as String,
      type: jsonSerialization['type'] as String,
      targetRoute: jsonSerialization['targetRoute'] as String?,
      targetId: jsonSerialization['targetId'] as String?,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      eventIdTag: jsonSerialization['eventIdTag'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String title;

  String message;

  String type;

  String? targetRoute;

  String? targetId;

  bool isRead;

  DateTime createdAt;

  String? eventIdTag;

  /// Returns a shallow copy of this [CampusNotification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CampusNotification copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? title,
    String? message,
    String? type,
    String? targetRoute,
    String? targetId,
    bool? isRead,
    DateTime? createdAt,
    String? eventIdTag,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusNotification',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'title': title,
      'message': message,
      'type': type,
      if (targetRoute != null) 'targetRoute': targetRoute,
      if (targetId != null) 'targetId': targetId,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
      if (eventIdTag != null) 'eventIdTag': eventIdTag,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusNotification',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'title': title,
      'message': message,
      'type': type,
      if (targetRoute != null) 'targetRoute': targetRoute,
      if (targetId != null) 'targetId': targetId,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
      if (eventIdTag != null) 'eventIdTag': eventIdTag,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusNotificationImpl extends CampusNotification {
  _CampusNotificationImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String title,
    required String message,
    required String type,
    String? targetRoute,
    String? targetId,
    bool? isRead,
    DateTime? createdAt,
    String? eventIdTag,
  }) : super._(
         id: id,
         authUserId: authUserId,
         title: title,
         message: message,
         type: type,
         targetRoute: targetRoute,
         targetId: targetId,
         isRead: isRead,
         createdAt: createdAt,
         eventIdTag: eventIdTag,
       );

  /// Returns a shallow copy of this [CampusNotification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CampusNotification copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? title,
    String? message,
    String? type,
    Object? targetRoute = _Undefined,
    Object? targetId = _Undefined,
    bool? isRead,
    DateTime? createdAt,
    Object? eventIdTag = _Undefined,
  }) {
    return CampusNotification(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      targetRoute: targetRoute is String? ? targetRoute : this.targetRoute,
      targetId: targetId is String? ? targetId : this.targetId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      eventIdTag: eventIdTag is String? ? eventIdTag : this.eventIdTag,
    );
  }
}
