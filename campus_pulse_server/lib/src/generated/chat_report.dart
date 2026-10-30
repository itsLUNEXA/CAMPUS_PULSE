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

abstract class ChatReport
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ChatReport._({
    this.id,
    required this.messageId,
    required this.roomId,
    required this.reporterUserId,
    required this.reporterName,
    required this.reason,
    String? status,
    this.actionTaken,
    DateTime? createdAt,
    this.reviewedByUserId,
    this.reviewedAt,
  }) : status = status ?? 'pending',
       createdAt = createdAt ?? DateTime.now();

  factory ChatReport({
    int? id,
    required int messageId,
    required int roomId,
    required _is.UuidValue reporterUserId,
    required String reporterName,
    required String reason,
    String? status,
    String? actionTaken,
    DateTime? createdAt,
    _is.UuidValue? reviewedByUserId,
    DateTime? reviewedAt,
  }) = _ChatReportImpl;

  factory ChatReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatReport(
      id: jsonSerialization['id'] as int?,
      messageId: jsonSerialization['messageId'] as int,
      roomId: jsonSerialization['roomId'] as int,
      reporterUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['reporterUserId'],
      ),
      reporterName: jsonSerialization['reporterName'] as String,
      reason: jsonSerialization['reason'] as String,
      status: jsonSerialization['status'] as String?,
      actionTaken: jsonSerialization['actionTaken'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      reviewedByUserId: jsonSerialization['reviewedByUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['reviewedByUserId'],
            ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
    );
  }

  static final t = ChatReportTable();

  static const db = ChatReportRepository._();

  @override
  int? id;

  int messageId;

  int roomId;

  _is.UuidValue reporterUserId;

  String reporterName;

  String reason;

  String status;

  String? actionTaken;

  DateTime createdAt;

  _is.UuidValue? reviewedByUserId;

  DateTime? reviewedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChatReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChatReport copyWith({
    int? id,
    int? messageId,
    int? roomId,
    _is.UuidValue? reporterUserId,
    String? reporterName,
    String? reason,
    String? status,
    String? actionTaken,
    DateTime? createdAt,
    _is.UuidValue? reviewedByUserId,
    DateTime? reviewedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatReport',
      if (id != null) 'id': id,
      'messageId': messageId,
      'roomId': roomId,
      'reporterUserId': reporterUserId.toJson(),
      'reporterName': reporterName,
      'reason': reason,
      'status': status,
      if (actionTaken != null) 'actionTaken': actionTaken,
      'createdAt': createdAt.toJson(),
      if (reviewedByUserId != null)
        'reviewedByUserId': reviewedByUserId?.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatReport',
      if (id != null) 'id': id,
      'messageId': messageId,
      'roomId': roomId,
      'reporterUserId': reporterUserId.toJson(),
      'reporterName': reporterName,
      'reason': reason,
      'status': status,
      if (actionTaken != null) 'actionTaken': actionTaken,
      'createdAt': createdAt.toJson(),
      if (reviewedByUserId != null)
        'reviewedByUserId': reviewedByUserId?.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  static ChatReportInclude include() {
    return ChatReportInclude._();
  }

  static ChatReportIncludeList includeList({
    _is.WhereExpressionBuilder<ChatReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatReportTable>? orderBy,
    _is.OrderByListBuilder<ChatReportTable>? orderByList,
    ChatReportInclude? include,
  }) {
    return ChatReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatReport.t),
      orderByList: orderByList?.call(ChatReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatReportImpl extends ChatReport {
  _ChatReportImpl({
    int? id,
    required int messageId,
    required int roomId,
    required _is.UuidValue reporterUserId,
    required String reporterName,
    required String reason,
    String? status,
    String? actionTaken,
    DateTime? createdAt,
    _is.UuidValue? reviewedByUserId,
    DateTime? reviewedAt,
  }) : super._(
         id: id,
         messageId: messageId,
         roomId: roomId,
         reporterUserId: reporterUserId,
         reporterName: reporterName,
         reason: reason,
         status: status,
         actionTaken: actionTaken,
         createdAt: createdAt,
         reviewedByUserId: reviewedByUserId,
         reviewedAt: reviewedAt,
       );

  /// Returns a shallow copy of this [ChatReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChatReport copyWith({
    Object? id = _Undefined,
    int? messageId,
    int? roomId,
    _is.UuidValue? reporterUserId,
    String? reporterName,
    String? reason,
    String? status,
    Object? actionTaken = _Undefined,
    DateTime? createdAt,
    Object? reviewedByUserId = _Undefined,
    Object? reviewedAt = _Undefined,
  }) {
    return ChatReport(
      id: id is int? ? id : this.id,
      messageId: messageId ?? this.messageId,
      roomId: roomId ?? this.roomId,
      reporterUserId: reporterUserId ?? this.reporterUserId,
      reporterName: reporterName ?? this.reporterName,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      actionTaken: actionTaken is String? ? actionTaken : this.actionTaken,
      createdAt: createdAt ?? this.createdAt,
      reviewedByUserId: reviewedByUserId is _is.UuidValue?
          ? reviewedByUserId
          : this.reviewedByUserId,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
    );
  }
}

class ChatReportUpdateTable extends _is.UpdateTable<ChatReportTable> {
  ChatReportUpdateTable(super.table);

  _is.ColumnValue<int, int> messageId(int value) => _is.ColumnValue(
    table.messageId,
    value,
  );

  _is.ColumnValue<int, int> roomId(int value) => _is.ColumnValue(
    table.roomId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> reporterUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.reporterUserId,
    value,
  );

  _is.ColumnValue<String, String> reporterName(String value) => _is.ColumnValue(
    table.reporterName,
    value,
  );

  _is.ColumnValue<String, String> reason(String value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> actionTaken(String? value) => _is.ColumnValue(
    table.actionTaken,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> reviewedByUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.reviewedByUserId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> reviewedAt(DateTime? value) =>
      _is.ColumnValue(
        table.reviewedAt,
        value,
      );
}

class ChatReportTable extends _is.Table<int?> {
  ChatReportTable({super.tableRelation}) : super(tableName: 'chat_report') {
    updateTable = ChatReportUpdateTable(this);
    messageId = _is.ColumnInt(
      'messageId',
      this,
    );
    roomId = _is.ColumnInt(
      'roomId',
      this,
    );
    reporterUserId = _is.ColumnUuid(
      'reporterUserId',
      this,
    );
    reporterName = _is.ColumnString(
      'reporterName',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    actionTaken = _is.ColumnString(
      'actionTaken',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    reviewedByUserId = _is.ColumnUuid(
      'reviewedByUserId',
      this,
    );
    reviewedAt = _is.ColumnDateTime(
      'reviewedAt',
      this,
    );
  }

  late final ChatReportUpdateTable updateTable;

  late final _is.ColumnInt messageId;

  late final _is.ColumnInt roomId;

  late final _is.ColumnUuid reporterUserId;

  late final _is.ColumnString reporterName;

  late final _is.ColumnString reason;

  late final _is.ColumnString status;

  late final _is.ColumnString actionTaken;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnUuid reviewedByUserId;

  late final _is.ColumnDateTime reviewedAt;

  @override
  List<_is.Column> get columns => [
    id,
    messageId,
    roomId,
    reporterUserId,
    reporterName,
    reason,
    status,
    actionTaken,
    createdAt,
    reviewedByUserId,
    reviewedAt,
  ];
}

class ChatReportInclude extends _is.IncludeObject {
  ChatReportInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ChatReport.t;
}

class ChatReportIncludeList extends _is.IncludeList {
  ChatReportIncludeList._({
    _is.WhereExpressionBuilder<ChatReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChatReport.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ChatReport.t;
}

class ChatReportRepository {
  const ChatReportRepository._();

  /// Returns a list of [ChatReport]s matching the given query parameters.
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
  Future<List<ChatReport>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatReportTable>? orderBy,
    _is.OrderByListBuilder<ChatReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChatReport>(
      where: where?.call(ChatReport.t),
      orderBy: orderBy?.call(ChatReport.t),
      orderByList: orderByList?.call(ChatReport.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChatReport] matching the given query parameters.
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
  Future<ChatReport?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatReportTable>? where,
    int? offset,
    _is.OrderByBuilder<ChatReportTable>? orderBy,
    _is.OrderByListBuilder<ChatReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChatReport>(
      where: where?.call(ChatReport.t),
      orderBy: orderBy?.call(ChatReport.t),
      orderByList: orderByList?.call(ChatReport.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChatReport] by its [id] or null if no such row exists.
  Future<ChatReport?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChatReport>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChatReport]s in the list and returns the inserted rows.
  ///
  /// The returned [ChatReport]s will have their `id` fields set.
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
  Future<List<ChatReport>> insert(
    _is.DatabaseSession session,
    List<ChatReport> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ChatReport>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ChatReport] and returns the inserted row.
  ///
  /// The returned [ChatReport] will have its `id` field set.
  Future<ChatReport> insertRow(
    _is.DatabaseSession session,
    ChatReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChatReport>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ChatReport]s in the list and returns the resulting rows.
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
  /// The returned [ChatReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatReport>> upsert(
    _is.DatabaseSession session,
    List<ChatReport> rows, {
    required _is.ColumnSelections<ChatReportTable> conflictColumns,
    _is.ColumnSelections<ChatReportTable>? updateColumns,
    _is.WhereExpressionBuilder<ChatReportTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ChatReport>(
      rows,
      conflictColumns: conflictColumns(ChatReport.t),
      updateColumns: updateColumns?.call(ChatReport.t),
      updateWhere: updateWhere?.call(ChatReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ChatReport] and returns the resulting row.
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
  /// The returned [ChatReport] will have its `id` field set.
  Future<ChatReport?> upsertRow(
    _is.DatabaseSession session,
    ChatReport row, {
    required _is.ColumnSelections<ChatReportTable> conflictColumns,
    _is.ColumnSelections<ChatReportTable>? updateColumns,
    _is.WhereExpressionBuilder<ChatReportTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ChatReport>(
      row,
      conflictColumns: conflictColumns(ChatReport.t),
      updateColumns: updateColumns?.call(ChatReport.t),
      updateWhere: updateWhere?.call(ChatReport.t),
      transaction: transaction,
    );
  }

  /// Updates all [ChatReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatReport>> update(
    _is.DatabaseSession session,
    List<ChatReport> rows, {
    _is.ColumnSelections<ChatReportTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ChatReport>(
      rows,
      columns: columns?.call(ChatReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ChatReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChatReport> updateRow(
    _is.DatabaseSession session,
    ChatReport row, {
    _is.ColumnSelections<ChatReportTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChatReport>(
      row,
      columns: columns?.call(ChatReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChatReport] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChatReport?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChatReportUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ChatReport>(
      id,
      columnValues: columnValues(ChatReport.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChatReport]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChatReport>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChatReportUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ChatReportTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChatReportTable>? orderBy,
    _is.OrderByListBuilder<ChatReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ChatReport>(
      columnValues: columnValues(ChatReport.t.updateTable),
      where: where(ChatReport.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatReport.t),
      orderByList: orderByList?.call(ChatReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ChatReport]s in the list and returns the deleted rows.
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
  Future<List<ChatReport>> delete(
    _is.DatabaseSession session,
    List<ChatReport> rows, {
    _is.OrderByBuilder<ChatReportTable>? orderBy,
    _is.OrderByListBuilder<ChatReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ChatReport>(
      rows,
      orderBy: orderBy?.call(ChatReport.t),
      orderByList: orderByList?.call(ChatReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ChatReport].
  Future<ChatReport> deleteRow(
    _is.DatabaseSession session,
    ChatReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChatReport>(
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
  Future<List<ChatReport>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChatReportTable> where,
    _is.OrderByBuilder<ChatReportTable>? orderBy,
    _is.OrderByListBuilder<ChatReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ChatReport>(
      where: where(ChatReport.t),
      orderBy: orderBy?.call(ChatReport.t),
      orderByList: orderByList?.call(ChatReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChatReportTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ChatReport>(
      where: where?.call(ChatReport.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChatReport] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChatReportTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChatReport>(
      where: where(ChatReport.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
