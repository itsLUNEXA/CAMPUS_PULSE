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

abstract class ChatMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChatMessage._({
    this.id,
    required this.roomId,
    required this.senderUserId,
    required this.senderName,
    required this.content,
    this.attachmentUrl,
    this.attachmentType,
    bool? isRead,
    DateTime? createdAt,
    bool? isEdited,
  }) : isRead = isRead ?? false,
       createdAt = createdAt ?? DateTime.now(),
       isEdited = isEdited ?? false;

  factory ChatMessage({
    int? id,
    required int roomId,
    required _isc.UuidValue senderUserId,
    required String senderName,
    required String content,
    String? attachmentUrl,
    String? attachmentType,
    bool? isRead,
    DateTime? createdAt,
    bool? isEdited,
  }) = _ChatMessageImpl;

  factory ChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatMessage(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      senderUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['senderUserId'],
      ),
      senderName: jsonSerialization['senderName'] as String,
      content: jsonSerialization['content'] as String,
      attachmentUrl: jsonSerialization['attachmentUrl'] as String?,
      attachmentType: jsonSerialization['attachmentType'] as String?,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      isEdited: jsonSerialization['isEdited'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isEdited']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  _isc.UuidValue senderUserId;

  String senderName;

  String content;

  String? attachmentUrl;

  String? attachmentType;

  bool isRead;

  DateTime createdAt;

  bool isEdited;

  /// Returns a shallow copy of this [ChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChatMessage copyWith({
    int? id,
    int? roomId,
    _isc.UuidValue? senderUserId,
    String? senderName,
    String? content,
    String? attachmentUrl,
    String? attachmentType,
    bool? isRead,
    DateTime? createdAt,
    bool? isEdited,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatMessage',
      if (id != null) 'id': id,
      'roomId': roomId,
      'senderUserId': senderUserId.toJson(),
      'senderName': senderName,
      'content': content,
      if (attachmentUrl != null) 'attachmentUrl': attachmentUrl,
      if (attachmentType != null) 'attachmentType': attachmentType,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
      'isEdited': isEdited,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatMessage',
      if (id != null) 'id': id,
      'roomId': roomId,
      'senderUserId': senderUserId.toJson(),
      'senderName': senderName,
      'content': content,
      if (attachmentUrl != null) 'attachmentUrl': attachmentUrl,
      if (attachmentType != null) 'attachmentType': attachmentType,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
      'isEdited': isEdited,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatMessageImpl extends ChatMessage {
  _ChatMessageImpl({
    int? id,
    required int roomId,
    required _isc.UuidValue senderUserId,
    required String senderName,
    required String content,
    String? attachmentUrl,
    String? attachmentType,
    bool? isRead,
    DateTime? createdAt,
    bool? isEdited,
  }) : super._(
         id: id,
         roomId: roomId,
         senderUserId: senderUserId,
         senderName: senderName,
         content: content,
         attachmentUrl: attachmentUrl,
         attachmentType: attachmentType,
         isRead: isRead,
         createdAt: createdAt,
         isEdited: isEdited,
       );

  /// Returns a shallow copy of this [ChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChatMessage copyWith({
    Object? id = _Undefined,
    int? roomId,
    _isc.UuidValue? senderUserId,
    String? senderName,
    String? content,
    Object? attachmentUrl = _Undefined,
    Object? attachmentType = _Undefined,
    bool? isRead,
    DateTime? createdAt,
    bool? isEdited,
  }) {
    return ChatMessage(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      senderUserId: senderUserId ?? this.senderUserId,
      senderName: senderName ?? this.senderName,
      content: content ?? this.content,
      attachmentUrl: attachmentUrl is String?
          ? attachmentUrl
          : this.attachmentUrl,
      attachmentType: attachmentType is String?
          ? attachmentType
          : this.attachmentType,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      isEdited: isEdited ?? this.isEdited,
    );
  }
}
