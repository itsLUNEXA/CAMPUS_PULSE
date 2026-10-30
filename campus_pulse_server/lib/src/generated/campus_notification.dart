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
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue authUserId,
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
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      title: jsonSerialization['title'] as String,
      message: jsonSerialization['message'] as String,
      type: jsonSerialization['type'] as String,
      targetRoute: jsonSerialization['targetRoute'] as String?,
      targetId: jsonSerialization['targetId'] as String?,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      eventIdTag: jsonSerialization['eventIdTag'] as String?,
    );
  }

  static final t = CampusNotificationTable();

  static const db = CampusNotificationRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String title;

  String message;

  String type;

  String? targetRoute;

  String? targetId;

  bool isRead;

  DateTime createdAt;

  String? eventIdTag;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CampusNotification]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CampusNotification copyWith({
    int? id,
    _is.UuidValue? authUserId,
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

  static CampusNotificationInclude include() {
    return CampusNotificationInclude._();
  }

  static CampusNotificationIncludeList includeList({
    _is.WhereExpressionBuilder<CampusNotificationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusNotificationTable>? orderBy,
    _is.OrderByListBuilder<CampusNotificationTable>? orderByList,
    CampusNotificationInclude? include,
  }) {
    return CampusNotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusNotification.t),
      orderByList: orderByList?.call(CampusNotification.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusNotificationImpl extends CampusNotification {
  _CampusNotificationImpl({
    int? id,
    required _is.UuidValue authUserId,
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
  @_is.useResult
  @override
  CampusNotification copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
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

class CampusNotificationUpdateTable
    extends _is.UpdateTable<CampusNotificationTable> {
  CampusNotificationUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> message(String value) => _is.ColumnValue(
    table.message,
    value,
  );

  _is.ColumnValue<String, String> type(String value) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<String, String> targetRoute(String? value) => _is.ColumnValue(
    table.targetRoute,
    value,
  );

  _is.ColumnValue<String, String> targetId(String? value) => _is.ColumnValue(
    table.targetId,
    value,
  );

  _is.ColumnValue<bool, bool> isRead(bool value) => _is.ColumnValue(
    table.isRead,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<String, String> eventIdTag(String? value) => _is.ColumnValue(
    table.eventIdTag,
    value,
  );
}

class CampusNotificationTable extends _is.Table<int?> {
  CampusNotificationTable({super.tableRelation})
    : super(tableName: 'campus_notifications') {
    updateTable = CampusNotificationUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    message = _is.ColumnString(
      'message',
      this,
    );
    type = _is.ColumnString(
      'type',
      this,
    );
    targetRoute = _is.ColumnString(
      'targetRoute',
      this,
    );
    targetId = _is.ColumnString(
      'targetId',
      this,
    );
    isRead = _is.ColumnBool(
      'isRead',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    eventIdTag = _is.ColumnString(
      'eventIdTag',
      this,
    );
  }

  late final CampusNotificationUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString title;

  late final _is.ColumnString message;

  late final _is.ColumnString type;

  late final _is.ColumnString targetRoute;

  late final _is.ColumnString targetId;

  late final _is.ColumnBool isRead;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnString eventIdTag;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    title,
    message,
    type,
    targetRoute,
    targetId,
    isRead,
    createdAt,
    eventIdTag,
  ];
}

class CampusNotificationInclude extends _is.IncludeObject {
  CampusNotificationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CampusNotification.t;
}

class CampusNotificationIncludeList extends _is.IncludeList {
  CampusNotificationIncludeList._({
    _is.WhereExpressionBuilder<CampusNotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CampusNotification.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CampusNotification.t;
}

class CampusNotificationRepository {
  const CampusNotificationRepository._();

  /// Returns a list of [CampusNotification]s matching the given query parameters.
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
  Future<List<CampusNotification>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusNotificationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusNotificationTable>? orderBy,
    _is.OrderByListBuilder<CampusNotificationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CampusNotification>(
      where: where?.call(CampusNotification.t),
      orderBy: orderBy?.call(CampusNotification.t),
      orderByList: orderByList?.call(CampusNotification.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CampusNotification] matching the given query parameters.
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
  Future<CampusNotification?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusNotificationTable>? where,
    int? offset,
    _is.OrderByBuilder<CampusNotificationTable>? orderBy,
    _is.OrderByListBuilder<CampusNotificationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CampusNotification>(
      where: where?.call(CampusNotification.t),
      orderBy: orderBy?.call(CampusNotification.t),
      orderByList: orderByList?.call(CampusNotification.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CampusNotification] by its [id] or null if no such row exists.
  Future<CampusNotification?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CampusNotification>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CampusNotification]s in the list and returns the inserted rows.
  ///
  /// The returned [CampusNotification]s will have their `id` fields set.
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
  Future<List<CampusNotification>> insert(
    _is.DatabaseSession session,
    List<CampusNotification> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CampusNotification>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CampusNotification] and returns the inserted row.
  ///
  /// The returned [CampusNotification] will have its `id` field set.
  Future<CampusNotification> insertRow(
    _is.DatabaseSession session,
    CampusNotification row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CampusNotification>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CampusNotification]s in the list and returns the resulting rows.
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
  /// The returned [CampusNotification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusNotification>> upsert(
    _is.DatabaseSession session,
    List<CampusNotification> rows, {
    required _is.ColumnSelections<CampusNotificationTable> conflictColumns,
    _is.ColumnSelections<CampusNotificationTable>? updateColumns,
    _is.WhereExpressionBuilder<CampusNotificationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CampusNotification>(
      rows,
      conflictColumns: conflictColumns(CampusNotification.t),
      updateColumns: updateColumns?.call(CampusNotification.t),
      updateWhere: updateWhere?.call(CampusNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CampusNotification] and returns the resulting row.
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
  /// The returned [CampusNotification] will have its `id` field set.
  Future<CampusNotification?> upsertRow(
    _is.DatabaseSession session,
    CampusNotification row, {
    required _is.ColumnSelections<CampusNotificationTable> conflictColumns,
    _is.ColumnSelections<CampusNotificationTable>? updateColumns,
    _is.WhereExpressionBuilder<CampusNotificationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CampusNotification>(
      row,
      conflictColumns: conflictColumns(CampusNotification.t),
      updateColumns: updateColumns?.call(CampusNotification.t),
      updateWhere: updateWhere?.call(CampusNotification.t),
      transaction: transaction,
    );
  }

  /// Updates all [CampusNotification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusNotification>> update(
    _is.DatabaseSession session,
    List<CampusNotification> rows, {
    _is.ColumnSelections<CampusNotificationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CampusNotification>(
      rows,
      columns: columns?.call(CampusNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CampusNotification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CampusNotification> updateRow(
    _is.DatabaseSession session,
    CampusNotification row, {
    _is.ColumnSelections<CampusNotificationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CampusNotification>(
      row,
      columns: columns?.call(CampusNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CampusNotification] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CampusNotification?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CampusNotificationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CampusNotification>(
      id,
      columnValues: columnValues(CampusNotification.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CampusNotification]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusNotification>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CampusNotificationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CampusNotificationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusNotificationTable>? orderBy,
    _is.OrderByListBuilder<CampusNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CampusNotification>(
      columnValues: columnValues(CampusNotification.t.updateTable),
      where: where(CampusNotification.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusNotification.t),
      orderByList: orderByList?.call(CampusNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CampusNotification]s in the list and returns the deleted rows.
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
  Future<List<CampusNotification>> delete(
    _is.DatabaseSession session,
    List<CampusNotification> rows, {
    _is.OrderByBuilder<CampusNotificationTable>? orderBy,
    _is.OrderByListBuilder<CampusNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CampusNotification>(
      rows,
      orderBy: orderBy?.call(CampusNotification.t),
      orderByList: orderByList?.call(CampusNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CampusNotification].
  Future<CampusNotification> deleteRow(
    _is.DatabaseSession session,
    CampusNotification row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CampusNotification>(
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
  Future<List<CampusNotification>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CampusNotificationTable> where,
    _is.OrderByBuilder<CampusNotificationTable>? orderBy,
    _is.OrderByListBuilder<CampusNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CampusNotification>(
      where: where(CampusNotification.t),
      orderBy: orderBy?.call(CampusNotification.t),
      orderByList: orderByList?.call(CampusNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusNotificationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CampusNotification>(
      where: where?.call(CampusNotification.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CampusNotification] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CampusNotificationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CampusNotification>(
      where: where(CampusNotification.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
