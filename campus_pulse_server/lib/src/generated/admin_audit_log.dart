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

abstract class AdminAuditLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AdminAuditLog._({
    this.id,
    required this.actorUserId,
    required this.actorName,
    required this.actionType,
    required this.targetEntity,
    required this.targetId,
    required this.details,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory AdminAuditLog({
    int? id,
    required _is.UuidValue actorUserId,
    required String actorName,
    required String actionType,
    required String targetEntity,
    required String targetId,
    required String details,
    DateTime? timestamp,
  }) = _AdminAuditLogImpl;

  factory AdminAuditLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAuditLog(
      id: jsonSerialization['id'] as int?,
      actorUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['actorUserId'],
      ),
      actorName: jsonSerialization['actorName'] as String,
      actionType: jsonSerialization['actionType'] as String,
      targetEntity: jsonSerialization['targetEntity'] as String,
      targetId: jsonSerialization['targetId'] as String,
      details: jsonSerialization['details'] as String,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  static final t = AdminAuditLogTable();

  static const db = AdminAuditLogRepository._();

  @override
  int? id;

  _is.UuidValue actorUserId;

  String actorName;

  String actionType;

  String targetEntity;

  String targetId;

  String details;

  DateTime timestamp;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AdminAuditLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminAuditLog copyWith({
    int? id,
    _is.UuidValue? actorUserId,
    String? actorName,
    String? actionType,
    String? targetEntity,
    String? targetId,
    String? details,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAuditLog',
      if (id != null) 'id': id,
      'actorUserId': actorUserId.toJson(),
      'actorName': actorName,
      'actionType': actionType,
      'targetEntity': targetEntity,
      'targetId': targetId,
      'details': details,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAuditLog',
      if (id != null) 'id': id,
      'actorUserId': actorUserId.toJson(),
      'actorName': actorName,
      'actionType': actionType,
      'targetEntity': targetEntity,
      'targetId': targetId,
      'details': details,
      'timestamp': timestamp.toJson(),
    };
  }

  static AdminAuditLogInclude include() {
    return AdminAuditLogInclude._();
  }

  static AdminAuditLogIncludeList includeList({
    _is.WhereExpressionBuilder<AdminAuditLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AdminAuditLogTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditLogTable>? orderByList,
    AdminAuditLogInclude? include,
  }) {
    return AdminAuditLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminAuditLog.t),
      orderByList: orderByList?.call(AdminAuditLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminAuditLogImpl extends AdminAuditLog {
  _AdminAuditLogImpl({
    int? id,
    required _is.UuidValue actorUserId,
    required String actorName,
    required String actionType,
    required String targetEntity,
    required String targetId,
    required String details,
    DateTime? timestamp,
  }) : super._(
         id: id,
         actorUserId: actorUserId,
         actorName: actorName,
         actionType: actionType,
         targetEntity: targetEntity,
         targetId: targetId,
         details: details,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [AdminAuditLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminAuditLog copyWith({
    Object? id = _Undefined,
    _is.UuidValue? actorUserId,
    String? actorName,
    String? actionType,
    String? targetEntity,
    String? targetId,
    String? details,
    DateTime? timestamp,
  }) {
    return AdminAuditLog(
      id: id is int? ? id : this.id,
      actorUserId: actorUserId ?? this.actorUserId,
      actorName: actorName ?? this.actorName,
      actionType: actionType ?? this.actionType,
      targetEntity: targetEntity ?? this.targetEntity,
      targetId: targetId ?? this.targetId,
      details: details ?? this.details,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class AdminAuditLogUpdateTable extends _is.UpdateTable<AdminAuditLogTable> {
  AdminAuditLogUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> actorUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.actorUserId,
    value,
  );

  _is.ColumnValue<String, String> actorName(String value) => _is.ColumnValue(
    table.actorName,
    value,
  );

  _is.ColumnValue<String, String> actionType(String value) => _is.ColumnValue(
    table.actionType,
    value,
  );

  _is.ColumnValue<String, String> targetEntity(String value) => _is.ColumnValue(
    table.targetEntity,
    value,
  );

  _is.ColumnValue<String, String> targetId(String value) => _is.ColumnValue(
    table.targetId,
    value,
  );

  _is.ColumnValue<String, String> details(String value) => _is.ColumnValue(
    table.details,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );
}

class AdminAuditLogTable extends _is.Table<int?> {
  AdminAuditLogTable({super.tableRelation})
    : super(tableName: 'admin_audit_log') {
    updateTable = AdminAuditLogUpdateTable(this);
    actorUserId = _is.ColumnUuid(
      'actorUserId',
      this,
    );
    actorName = _is.ColumnString(
      'actorName',
      this,
    );
    actionType = _is.ColumnString(
      'actionType',
      this,
    );
    targetEntity = _is.ColumnString(
      'targetEntity',
      this,
    );
    targetId = _is.ColumnString(
      'targetId',
      this,
    );
    details = _is.ColumnString(
      'details',
      this,
    );
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
      hasDefault: true,
    );
  }

  late final AdminAuditLogUpdateTable updateTable;

  late final _is.ColumnUuid actorUserId;

  late final _is.ColumnString actorName;

  late final _is.ColumnString actionType;

  late final _is.ColumnString targetEntity;

  late final _is.ColumnString targetId;

  late final _is.ColumnString details;

  late final _is.ColumnDateTime timestamp;

  @override
  List<_is.Column> get columns => [
    id,
    actorUserId,
    actorName,
    actionType,
    targetEntity,
    targetId,
    details,
    timestamp,
  ];
}

class AdminAuditLogInclude extends _is.IncludeObject {
  AdminAuditLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AdminAuditLog.t;
}

class AdminAuditLogIncludeList extends _is.IncludeList {
  AdminAuditLogIncludeList._({
    _is.WhereExpressionBuilder<AdminAuditLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminAuditLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AdminAuditLog.t;
}

class AdminAuditLogRepository {
  const AdminAuditLogRepository._();

  /// Returns a list of [AdminAuditLog]s matching the given query parameters.
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
  Future<List<AdminAuditLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AdminAuditLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AdminAuditLogTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AdminAuditLog>(
      where: where?.call(AdminAuditLog.t),
      orderBy: orderBy?.call(AdminAuditLog.t),
      orderByList: orderByList?.call(AdminAuditLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AdminAuditLog] matching the given query parameters.
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
  Future<AdminAuditLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AdminAuditLogTable>? where,
    int? offset,
    _is.OrderByBuilder<AdminAuditLogTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AdminAuditLog>(
      where: where?.call(AdminAuditLog.t),
      orderBy: orderBy?.call(AdminAuditLog.t),
      orderByList: orderByList?.call(AdminAuditLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AdminAuditLog] by its [id] or null if no such row exists.
  Future<AdminAuditLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AdminAuditLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AdminAuditLog]s in the list and returns the inserted rows.
  ///
  /// The returned [AdminAuditLog]s will have their `id` fields set.
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
  Future<List<AdminAuditLog>> insert(
    _is.DatabaseSession session,
    List<AdminAuditLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AdminAuditLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AdminAuditLog] and returns the inserted row.
  ///
  /// The returned [AdminAuditLog] will have its `id` field set.
  Future<AdminAuditLog> insertRow(
    _is.DatabaseSession session,
    AdminAuditLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminAuditLog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AdminAuditLog]s in the list and returns the resulting rows.
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
  /// The returned [AdminAuditLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AdminAuditLog>> upsert(
    _is.DatabaseSession session,
    List<AdminAuditLog> rows, {
    required _is.ColumnSelections<AdminAuditLogTable> conflictColumns,
    _is.ColumnSelections<AdminAuditLogTable>? updateColumns,
    _is.WhereExpressionBuilder<AdminAuditLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AdminAuditLog>(
      rows,
      conflictColumns: conflictColumns(AdminAuditLog.t),
      updateColumns: updateColumns?.call(AdminAuditLog.t),
      updateWhere: updateWhere?.call(AdminAuditLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AdminAuditLog] and returns the resulting row.
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
  /// The returned [AdminAuditLog] will have its `id` field set.
  Future<AdminAuditLog?> upsertRow(
    _is.DatabaseSession session,
    AdminAuditLog row, {
    required _is.ColumnSelections<AdminAuditLogTable> conflictColumns,
    _is.ColumnSelections<AdminAuditLogTable>? updateColumns,
    _is.WhereExpressionBuilder<AdminAuditLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AdminAuditLog>(
      row,
      conflictColumns: conflictColumns(AdminAuditLog.t),
      updateColumns: updateColumns?.call(AdminAuditLog.t),
      updateWhere: updateWhere?.call(AdminAuditLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [AdminAuditLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AdminAuditLog>> update(
    _is.DatabaseSession session,
    List<AdminAuditLog> rows, {
    _is.ColumnSelections<AdminAuditLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AdminAuditLog>(
      rows,
      columns: columns?.call(AdminAuditLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AdminAuditLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminAuditLog> updateRow(
    _is.DatabaseSession session,
    AdminAuditLog row, {
    _is.ColumnSelections<AdminAuditLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdminAuditLog>(
      row,
      columns: columns?.call(AdminAuditLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminAuditLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AdminAuditLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AdminAuditLogUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminAuditLog>(
      id,
      columnValues: columnValues(AdminAuditLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminAuditLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AdminAuditLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AdminAuditLogUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AdminAuditLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AdminAuditLogTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AdminAuditLog>(
      columnValues: columnValues(AdminAuditLog.t.updateTable),
      where: where(AdminAuditLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminAuditLog.t),
      orderByList: orderByList?.call(AdminAuditLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AdminAuditLog]s in the list and returns the deleted rows.
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
  Future<List<AdminAuditLog>> delete(
    _is.DatabaseSession session,
    List<AdminAuditLog> rows, {
    _is.OrderByBuilder<AdminAuditLogTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AdminAuditLog>(
      rows,
      orderBy: orderBy?.call(AdminAuditLog.t),
      orderByList: orderByList?.call(AdminAuditLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AdminAuditLog].
  Future<AdminAuditLog> deleteRow(
    _is.DatabaseSession session,
    AdminAuditLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminAuditLog>(
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
  Future<List<AdminAuditLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AdminAuditLogTable> where,
    _is.OrderByBuilder<AdminAuditLogTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AdminAuditLog>(
      where: where(AdminAuditLog.t),
      orderBy: orderBy?.call(AdminAuditLog.t),
      orderByList: orderByList?.call(AdminAuditLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AdminAuditLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AdminAuditLog>(
      where: where?.call(AdminAuditLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AdminAuditLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AdminAuditLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AdminAuditLog>(
      where: where(AdminAuditLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
