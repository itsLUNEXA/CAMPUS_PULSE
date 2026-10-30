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

abstract class ChatRoom
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ChatRoom._({
    this.id,
    required this.roomType,
    this.referenceId,
    required this.name,
    this.description,
    this.topic,
    this.creatorAuthUserId,
    required this.participantIds,
    this.allowedBranch,
    this.allowedAcademicYear,
    DateTime? createdAt,
    this.lastMessageText,
    this.lastMessageAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ChatRoom({
    int? id,
    required String roomType,
    String? referenceId,
    required String name,
    String? description,
    String? topic,
    _is.UuidValue? creatorAuthUserId,
    required List<_is.UuidValue> participantIds,
    String? allowedBranch,
    int? allowedAcademicYear,
    DateTime? createdAt,
    String? lastMessageText,
    DateTime? lastMessageAt,
  }) = _ChatRoomImpl;

  factory ChatRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatRoom(
      id: jsonSerialization['id'] as int?,
      roomType: jsonSerialization['roomType'] as String,
      referenceId: jsonSerialization['referenceId'] as String?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      topic: jsonSerialization['topic'] as String?,
      creatorAuthUserId: jsonSerialization['creatorAuthUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['creatorAuthUserId'],
            ),
      participantIds: _i2t5n14n.Protocol().deserialize<List<_is.UuidValue>>(
        jsonSerialization['participantIds'],
      ),
      allowedBranch: jsonSerialization['allowedBranch'] as String?,
      allowedAcademicYear: jsonSerialization['allowedAcademicYear'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastMessageText: jsonSerialization['lastMessageText'] as String?,
      lastMessageAt: jsonSerialization['lastMessageAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastMessageAt'],
            ),
    );
  }

  static final t = ChatRoomTable();

  static const db = ChatRoomRepository._();

  @override
  int? id;

  String roomType;

  String? referenceId;

  String name;

  String? description;

  String? topic;

  _is.UuidValue? creatorAuthUserId;

  List<_is.UuidValue> participantIds;

  String? allowedBranch;

  int? allowedAcademicYear;

  DateTime createdAt;

  String? lastMessageText;

  DateTime? lastMessageAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChatRoom]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChatRoom copyWith({
    int? id,
    String? roomType,
    String? referenceId,
    String? name,
    String? description,
    String? topic,
    _is.UuidValue? creatorAuthUserId,
    List<_is.UuidValue>? participantIds,
    String? allowedBranch,
    int? allowedAcademicYear,
    DateTime? createdAt,
    String? lastMessageText,
    DateTime? lastMessageAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatRoom',
      if (id != null) 'id': id,
      'roomType': roomType,
      if (referenceId != null) 'referenceId': referenceId,
      'name': name,
      if (description != null) 'description': description,
      if (topic != null) 'topic': topic,
      if (creatorAuthUserId != null)
        'creatorAuthUserId': creatorAuthUserId?.toJson(),
      'participantIds': participantIds.toJson(valueToJson: (v) => v.toJson()),
      if (allowedBranch != null) 'allowedBranch': allowedBranch,
      if (allowedAcademicYear != null)
        'allowedAcademicYear': allowedAcademicYear,
      'createdAt': createdAt.toJson(),
      if (lastMessageText != null) 'lastMessageText': lastMessageText,
      if (lastMessageAt != null) 'lastMessageAt': lastMessageAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatRoom',
      if (id != null) 'id': id,
      'roomType': roomType,
      if (referenceId != null) 'referenceId': referenceId,
      'name': name,
      if (description != null) 'description': description,
      if (topic != null) 'topic': topic,
      if (creatorAuthUserId != null)
        'creatorAuthUserId': creatorAuthUserId?.toJson(),
      'participantIds': participantIds.toJson(valueToJson: (v) => v.toJson()),
      if (allowedBranch != null) 'allowedBranch': allowedBranch,
      if (allowedAcademicYear != null)
        'allowedAcademicYear': allowedAcademicYear,
      'createdAt': createdAt.toJson(),
      if (lastMessageText != null) 'lastMessageText': lastMessageText,
      if (lastMessageAt != null) 'lastMessageAt': lastMessageAt?.toJson(),
    };
  }

  static ChatRoomInclude include() {
    return ChatRoomInclude._();
  }

  static ChatRoomIncludeList includeList({
    _is.WhereExpressionBuilder<ChatRoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatRoomTable>? orderBy,
    _is.OrderByListBuilder<ChatRoomTable>? orderByList,
    ChatRoomInclude? include,
  }) {
    return ChatRoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatRoom.t),
      orderByList: orderByList?.call(ChatRoom.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatRoomImpl extends ChatRoom {
  _ChatRoomImpl({
    int? id,
    required String roomType,
    String? referenceId,
    required String name,
    String? description,
    String? topic,
    _is.UuidValue? creatorAuthUserId,
    required List<_is.UuidValue> participantIds,
    String? allowedBranch,
    int? allowedAcademicYear,
    DateTime? createdAt,
    String? lastMessageText,
    DateTime? lastMessageAt,
  }) : super._(
         id: id,
         roomType: roomType,
         referenceId: referenceId,
         name: name,
         description: description,
         topic: topic,
         creatorAuthUserId: creatorAuthUserId,
         participantIds: participantIds,
         allowedBranch: allowedBranch,
         allowedAcademicYear: allowedAcademicYear,
         createdAt: createdAt,
         lastMessageText: lastMessageText,
         lastMessageAt: lastMessageAt,
       );

  /// Returns a shallow copy of this [ChatRoom]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChatRoom copyWith({
    Object? id = _Undefined,
    String? roomType,
    Object? referenceId = _Undefined,
    String? name,
    Object? description = _Undefined,
    Object? topic = _Undefined,
    Object? creatorAuthUserId = _Undefined,
    List<_is.UuidValue>? participantIds,
    Object? allowedBranch = _Undefined,
    Object? allowedAcademicYear = _Undefined,
    DateTime? createdAt,
    Object? lastMessageText = _Undefined,
    Object? lastMessageAt = _Undefined,
  }) {
    return ChatRoom(
      id: id is int? ? id : this.id,
      roomType: roomType ?? this.roomType,
      referenceId: referenceId is String? ? referenceId : this.referenceId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      topic: topic is String? ? topic : this.topic,
      creatorAuthUserId: creatorAuthUserId is _is.UuidValue?
          ? creatorAuthUserId
          : this.creatorAuthUserId,
      participantIds:
          participantIds ?? this.participantIds.map((e0) => e0).toList(),
      allowedBranch: allowedBranch is String?
          ? allowedBranch
          : this.allowedBranch,
      allowedAcademicYear: allowedAcademicYear is int?
          ? allowedAcademicYear
          : this.allowedAcademicYear,
      createdAt: createdAt ?? this.createdAt,
      lastMessageText: lastMessageText is String?
          ? lastMessageText
          : this.lastMessageText,
      lastMessageAt: lastMessageAt is DateTime?
          ? lastMessageAt
          : this.lastMessageAt,
    );
  }
}

class ChatRoomUpdateTable extends _is.UpdateTable<ChatRoomTable> {
  ChatRoomUpdateTable(super.table);

  _is.ColumnValue<String, String> roomType(String value) => _is.ColumnValue(
    table.roomType,
    value,
  );

  _is.ColumnValue<String, String> referenceId(String? value) => _is.ColumnValue(
    table.referenceId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> topic(String? value) => _is.ColumnValue(
    table.topic,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> creatorAuthUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.creatorAuthUserId,
    value,
  );

  _is.ColumnValue<List<_is.UuidValue>, List<_is.UuidValue>> participantIds(
    List<_is.UuidValue> value,
  ) => _is.ColumnValue(
    table.participantIds,
    value,
  );

  _is.ColumnValue<String, String> allowedBranch(String? value) =>
      _is.ColumnValue(
        table.allowedBranch,
        value,
      );

  _is.ColumnValue<int, int> allowedAcademicYear(int? value) => _is.ColumnValue(
    table.allowedAcademicYear,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<String, String> lastMessageText(String? value) =>
      _is.ColumnValue(
        table.lastMessageText,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastMessageAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastMessageAt,
        value,
      );
}

class ChatRoomTable extends _is.Table<int?> {
  ChatRoomTable({super.tableRelation}) : super(tableName: 'chat_room') {
    updateTable = ChatRoomUpdateTable(this);
    roomType = _is.ColumnString(
      'roomType',
      this,
    );
    referenceId = _is.ColumnString(
      'referenceId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    topic = _is.ColumnString(
      'topic',
      this,
    );
    creatorAuthUserId = _is.ColumnUuid(
      'creatorAuthUserId',
      this,
    );
    participantIds = _is.ColumnSerializable<List<_is.UuidValue>>(
      'participantIds',
      this,
    );
    allowedBranch = _is.ColumnString(
      'allowedBranch',
      this,
    );
    allowedAcademicYear = _is.ColumnInt(
      'allowedAcademicYear',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    lastMessageText = _is.ColumnString(
      'lastMessageText',
      this,
    );
    lastMessageAt = _is.ColumnDateTime(
      'lastMessageAt',
      this,
    );
  }

  late final ChatRoomUpdateTable updateTable;

  late final _is.ColumnString roomType;

  late final _is.ColumnString referenceId;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString topic;

  late final _is.ColumnUuid creatorAuthUserId;

  late final _is.ColumnSerializable<List<_is.UuidValue>> participantIds;

  late final _is.ColumnString allowedBranch;

  late final _is.ColumnInt allowedAcademicYear;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnString lastMessageText;

  late final _is.ColumnDateTime lastMessageAt;

  @override
  List<_is.Column> get columns => [
    id,
    roomType,
    referenceId,
    name,
    description,
    topic,
    creatorAuthUserId,
    participantIds,
    allowedBranch,
    allowedAcademicYear,
    createdAt,
    lastMessageText,
    lastMessageAt,
  ];
}

class ChatRoomInclude extends _is.IncludeObject {
  ChatRoomInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ChatRoom.t;
}

class ChatRoomIncludeList extends _is.IncludeList {
  ChatRoomIncludeList._({
    _is.WhereExpressionBuilder<ChatRoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChatRoom.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ChatRoom.t;
}

class ChatRoomRepository {
  const ChatRoomRepository._();

  /// Returns a list of [ChatRoom]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ChatRoom>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatRoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatRoomTable>? orderBy,
    _is.OrderByListBuilder<ChatRoomTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChatRoom>(
      where: where?.call(ChatRoom.t),
      orderBy: orderBy?.call(ChatRoom.t),
      orderByList: orderByList?.call(ChatRoom.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChatRoom] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ChatRoom?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatRoomTable>? where,
    int? offset,
    _is.OrderByBuilder<ChatRoomTable>? orderBy,
    _is.OrderByListBuilder<ChatRoomTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChatRoom>(
      where: where?.call(ChatRoom.t),
      orderBy: orderBy?.call(ChatRoom.t),
      orderByList: orderByList?.call(ChatRoom.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChatRoom] by its [id] or null if no such row exists.
  Future<ChatRoom?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChatRoom>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChatRoom]s in the list and returns the inserted rows.
  ///
  /// The returned [ChatRoom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatRoom>> insert(
    _is.DatabaseSession session,
    List<ChatRoom> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ChatRoom>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ChatRoom] and returns the inserted row.
  ///
  /// The returned [ChatRoom] will have its `id` field set.
  Future<ChatRoom> insertRow(
    _is.DatabaseSession session,
    ChatRoom row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChatRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ChatRoom]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [ChatRoom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatRoom>> upsert(
    _is.DatabaseSession session,
    List<ChatRoom> rows, {
    required _is.ColumnSelections<ChatRoomTable> conflictColumns,
    _is.ColumnSelections<ChatRoomTable>? updateColumns,
    _is.WhereExpressionBuilder<ChatRoomTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ChatRoom>(
      rows,
      conflictColumns: conflictColumns(ChatRoom.t),
      updateColumns: updateColumns?.call(ChatRoom.t),
      updateWhere: updateWhere?.call(ChatRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ChatRoom] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [ChatRoom] will have its `id` field set.
  Future<ChatRoom?> upsertRow(
    _is.DatabaseSession session,
    ChatRoom row, {
    required _is.ColumnSelections<ChatRoomTable> conflictColumns,
    _is.ColumnSelections<ChatRoomTable>? updateColumns,
    _is.WhereExpressionBuilder<ChatRoomTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ChatRoom>(
      row,
      conflictColumns: conflictColumns(ChatRoom.t),
      updateColumns: updateColumns?.call(ChatRoom.t),
      updateWhere: updateWhere?.call(ChatRoom.t),
      transaction: transaction,
    );
  }

  /// Updates all [ChatRoom]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatRoom>> update(
    _is.DatabaseSession session,
    List<ChatRoom> rows, {
    _is.ColumnSelections<ChatRoomTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ChatRoom>(
      rows,
      columns: columns?.call(ChatRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ChatRoom]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChatRoom> updateRow(
    _is.DatabaseSession session,
    ChatRoom row, {
    _is.ColumnSelections<ChatRoomTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChatRoom>(
      row,
      columns: columns?.call(ChatRoom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChatRoom] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChatRoom?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChatRoomUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ChatRoom>(
      id,
      columnValues: columnValues(ChatRoom.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChatRoom]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatRoom>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChatRoomUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ChatRoomTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatRoomTable>? orderBy,
    _is.OrderByListBuilder<ChatRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ChatRoom>(
      columnValues: columnValues(ChatRoom.t.updateTable),
      where: where(ChatRoom.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatRoom.t),
      orderByList: orderByList?.call(ChatRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ChatRoom]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatRoom>> delete(
    _is.DatabaseSession session,
    List<ChatRoom> rows, {
    _is.OrderByBuilder<ChatRoomTable>? orderBy,
    _is.OrderByListBuilder<ChatRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ChatRoom>(
      rows,
      orderBy: orderBy?.call(ChatRoom.t),
      orderByList: orderByList?.call(ChatRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ChatRoom].
  Future<ChatRoom> deleteRow(
    _is.DatabaseSession session,
    ChatRoom row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChatRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatRoom>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChatRoomTable> where,
    _is.OrderByBuilder<ChatRoomTable>? orderBy,
    _is.OrderByListBuilder<ChatRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ChatRoom>(
      where: where(ChatRoom.t),
      orderBy: orderBy?.call(ChatRoom.t),
      orderByList: orderByList?.call(ChatRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatRoomTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ChatRoom>(
      where: where?.call(ChatRoom.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChatRoom] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChatRoomTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChatRoom>(
      where: where(ChatRoom.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
