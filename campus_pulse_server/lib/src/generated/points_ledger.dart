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

abstract class PointsLedger
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PointsLedger._({
    this.id,
    required this.authUserId,
    required this.studentName,
    required this.source,
    required this.points,
    required this.description,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory PointsLedger({
    int? id,
    required _is.UuidValue authUserId,
    required String studentName,
    required String source,
    required int points,
    required String description,
    DateTime? timestamp,
  }) = _PointsLedgerImpl;

  factory PointsLedger.fromJson(Map<String, dynamic> jsonSerialization) {
    return PointsLedger(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      source: jsonSerialization['source'] as String,
      points: jsonSerialization['points'] as int,
      description: jsonSerialization['description'] as String,
      timestamp: jsonSerialization['timestamp'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  static final t = PointsLedgerTable();

  static const db = PointsLedgerRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String studentName;

  String source;

  int points;

  String description;

  DateTime timestamp;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PointsLedger]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PointsLedger copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? studentName,
    String? source,
    int? points,
    String? description,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PointsLedger',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'source': source,
      'points': points,
      'description': description,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PointsLedger',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'source': source,
      'points': points,
      'description': description,
      'timestamp': timestamp.toJson(),
    };
  }

  static PointsLedgerInclude include() {
    return PointsLedgerInclude._();
  }

  static PointsLedgerIncludeList includeList({
    _is.WhereExpressionBuilder<PointsLedgerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PointsLedgerTable>? orderBy,
    _is.OrderByListBuilder<PointsLedgerTable>? orderByList,
    PointsLedgerInclude? include,
  }) {
    return PointsLedgerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PointsLedger.t),
      orderByList: orderByList?.call(PointsLedger.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PointsLedgerImpl extends PointsLedger {
  _PointsLedgerImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String studentName,
    required String source,
    required int points,
    required String description,
    DateTime? timestamp,
  }) : super._(
         id: id,
         authUserId: authUserId,
         studentName: studentName,
         source: source,
         points: points,
         description: description,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [PointsLedger]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PointsLedger copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? studentName,
    String? source,
    int? points,
    String? description,
    DateTime? timestamp,
  }) {
    return PointsLedger(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      source: source ?? this.source,
      points: points ?? this.points,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class PointsLedgerUpdateTable extends _is.UpdateTable<PointsLedgerTable> {
  PointsLedgerUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> studentName(String value) => _is.ColumnValue(
    table.studentName,
    value,
  );

  _is.ColumnValue<String, String> source(String value) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<int, int> points(int value) => _is.ColumnValue(
    table.points,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );
}

class PointsLedgerTable extends _is.Table<int?> {
  PointsLedgerTable({super.tableRelation}) : super(tableName: 'points_ledger') {
    updateTable = PointsLedgerUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    studentName = _is.ColumnString(
      'studentName',
      this,
    );
    source = _is.ColumnString(
      'source',
      this,
    );
    points = _is.ColumnInt(
      'points',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
      hasDefault: true,
    );
  }

  late final PointsLedgerUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString studentName;

  late final _is.ColumnString source;

  late final _is.ColumnInt points;

  late final _is.ColumnString description;

  late final _is.ColumnDateTime timestamp;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    studentName,
    source,
    points,
    description,
    timestamp,
  ];
}

class PointsLedgerInclude extends _is.IncludeObject {
  PointsLedgerInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PointsLedger.t;
}

class PointsLedgerIncludeList extends _is.IncludeList {
  PointsLedgerIncludeList._({
    _is.WhereExpressionBuilder<PointsLedgerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PointsLedger.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PointsLedger.t;
}

class PointsLedgerRepository {
  const PointsLedgerRepository._();

  /// Returns a list of [PointsLedger]s matching the given query parameters.
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
  Future<List<PointsLedger>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PointsLedgerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PointsLedgerTable>? orderBy,
    _is.OrderByListBuilder<PointsLedgerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PointsLedger>(
      where: where?.call(PointsLedger.t),
      orderBy: orderBy?.call(PointsLedger.t),
      orderByList: orderByList?.call(PointsLedger.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PointsLedger] matching the given query parameters.
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
  Future<PointsLedger?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PointsLedgerTable>? where,
    int? offset,
    _is.OrderByBuilder<PointsLedgerTable>? orderBy,
    _is.OrderByListBuilder<PointsLedgerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PointsLedger>(
      where: where?.call(PointsLedger.t),
      orderBy: orderBy?.call(PointsLedger.t),
      orderByList: orderByList?.call(PointsLedger.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PointsLedger] by its [id] or null if no such row exists.
  Future<PointsLedger?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PointsLedger>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PointsLedger]s in the list and returns the inserted rows.
  ///
  /// The returned [PointsLedger]s will have their `id` fields set.
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
  Future<List<PointsLedger>> insert(
    _is.DatabaseSession session,
    List<PointsLedger> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PointsLedger>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PointsLedger] and returns the inserted row.
  ///
  /// The returned [PointsLedger] will have its `id` field set.
  Future<PointsLedger> insertRow(
    _is.DatabaseSession session,
    PointsLedger row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PointsLedger>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PointsLedger]s in the list and returns the resulting rows.
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
  /// The returned [PointsLedger]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PointsLedger>> upsert(
    _is.DatabaseSession session,
    List<PointsLedger> rows, {
    required _is.ColumnSelections<PointsLedgerTable> conflictColumns,
    _is.ColumnSelections<PointsLedgerTable>? updateColumns,
    _is.WhereExpressionBuilder<PointsLedgerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PointsLedger>(
      rows,
      conflictColumns: conflictColumns(PointsLedger.t),
      updateColumns: updateColumns?.call(PointsLedger.t),
      updateWhere: updateWhere?.call(PointsLedger.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PointsLedger] and returns the resulting row.
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
  /// The returned [PointsLedger] will have its `id` field set.
  Future<PointsLedger?> upsertRow(
    _is.DatabaseSession session,
    PointsLedger row, {
    required _is.ColumnSelections<PointsLedgerTable> conflictColumns,
    _is.ColumnSelections<PointsLedgerTable>? updateColumns,
    _is.WhereExpressionBuilder<PointsLedgerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PointsLedger>(
      row,
      conflictColumns: conflictColumns(PointsLedger.t),
      updateColumns: updateColumns?.call(PointsLedger.t),
      updateWhere: updateWhere?.call(PointsLedger.t),
      transaction: transaction,
    );
  }

  /// Updates all [PointsLedger]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PointsLedger>> update(
    _is.DatabaseSession session,
    List<PointsLedger> rows, {
    _is.ColumnSelections<PointsLedgerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PointsLedger>(
      rows,
      columns: columns?.call(PointsLedger.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PointsLedger]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PointsLedger> updateRow(
    _is.DatabaseSession session,
    PointsLedger row, {
    _is.ColumnSelections<PointsLedgerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PointsLedger>(
      row,
      columns: columns?.call(PointsLedger.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PointsLedger] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PointsLedger?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PointsLedgerUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PointsLedger>(
      id,
      columnValues: columnValues(PointsLedger.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PointsLedger]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PointsLedger>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PointsLedgerUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PointsLedgerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PointsLedgerTable>? orderBy,
    _is.OrderByListBuilder<PointsLedgerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PointsLedger>(
      columnValues: columnValues(PointsLedger.t.updateTable),
      where: where(PointsLedger.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PointsLedger.t),
      orderByList: orderByList?.call(PointsLedger.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PointsLedger]s in the list and returns the deleted rows.
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
  Future<List<PointsLedger>> delete(
    _is.DatabaseSession session,
    List<PointsLedger> rows, {
    _is.OrderByBuilder<PointsLedgerTable>? orderBy,
    _is.OrderByListBuilder<PointsLedgerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PointsLedger>(
      rows,
      orderBy: orderBy?.call(PointsLedger.t),
      orderByList: orderByList?.call(PointsLedger.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PointsLedger].
  Future<PointsLedger> deleteRow(
    _is.DatabaseSession session,
    PointsLedger row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PointsLedger>(
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
  Future<List<PointsLedger>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PointsLedgerTable> where,
    _is.OrderByBuilder<PointsLedgerTable>? orderBy,
    _is.OrderByListBuilder<PointsLedgerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PointsLedger>(
      where: where(PointsLedger.t),
      orderBy: orderBy?.call(PointsLedger.t),
      orderByList: orderByList?.call(PointsLedger.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PointsLedgerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PointsLedger>(
      where: where?.call(PointsLedger.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PointsLedger] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PointsLedgerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PointsLedger>(
      where: where(PointsLedger.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
