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

abstract class PrintPointTransaction
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PrintPointTransaction._({
    this.id,
    required this.authUserId,
    this.printRequestId,
    required this.type,
    required this.points,
    required this.balanceAfter,
    required this.description,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory PrintPointTransaction({
    int? id,
    required _is.UuidValue authUserId,
    int? printRequestId,
    required String type,
    required int points,
    required int balanceAfter,
    required String description,
    DateTime? createdAt,
  }) = _PrintPointTransactionImpl;

  factory PrintPointTransaction.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PrintPointTransaction(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      printRequestId: jsonSerialization['printRequestId'] as int?,
      type: jsonSerialization['type'] as String,
      points: jsonSerialization['points'] as int,
      balanceAfter: jsonSerialization['balanceAfter'] as int,
      description: jsonSerialization['description'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PrintPointTransactionTable();

  static const db = PrintPointTransactionRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  int? printRequestId;

  String type;

  int points;

  int balanceAfter;

  String description;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PrintPointTransaction]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PrintPointTransaction copyWith({
    int? id,
    _is.UuidValue? authUserId,
    int? printRequestId,
    String? type,
    int? points,
    int? balanceAfter,
    String? description,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PrintPointTransaction',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (printRequestId != null) 'printRequestId': printRequestId,
      'type': type,
      'points': points,
      'balanceAfter': balanceAfter,
      'description': description,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PrintPointTransaction',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (printRequestId != null) 'printRequestId': printRequestId,
      'type': type,
      'points': points,
      'balanceAfter': balanceAfter,
      'description': description,
      'createdAt': createdAt.toJson(),
    };
  }

  static PrintPointTransactionInclude include() {
    return PrintPointTransactionInclude._();
  }

  static PrintPointTransactionIncludeList includeList({
    _is.WhereExpressionBuilder<PrintPointTransactionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PrintPointTransactionTable>? orderBy,
    _is.OrderByListBuilder<PrintPointTransactionTable>? orderByList,
    PrintPointTransactionInclude? include,
  }) {
    return PrintPointTransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PrintPointTransaction.t),
      orderByList: orderByList?.call(PrintPointTransaction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrintPointTransactionImpl extends PrintPointTransaction {
  _PrintPointTransactionImpl({
    int? id,
    required _is.UuidValue authUserId,
    int? printRequestId,
    required String type,
    required int points,
    required int balanceAfter,
    required String description,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         printRequestId: printRequestId,
         type: type,
         points: points,
         balanceAfter: balanceAfter,
         description: description,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PrintPointTransaction]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PrintPointTransaction copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? printRequestId = _Undefined,
    String? type,
    int? points,
    int? balanceAfter,
    String? description,
    DateTime? createdAt,
  }) {
    return PrintPointTransaction(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      printRequestId: printRequestId is int?
          ? printRequestId
          : this.printRequestId,
      type: type ?? this.type,
      points: points ?? this.points,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PrintPointTransactionUpdateTable
    extends _is.UpdateTable<PrintPointTransactionTable> {
  PrintPointTransactionUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<int, int> printRequestId(int? value) => _is.ColumnValue(
    table.printRequestId,
    value,
  );

  _is.ColumnValue<String, String> type(String value) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<int, int> points(int value) => _is.ColumnValue(
    table.points,
    value,
  );

  _is.ColumnValue<int, int> balanceAfter(int value) => _is.ColumnValue(
    table.balanceAfter,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PrintPointTransactionTable extends _is.Table<int?> {
  PrintPointTransactionTable({super.tableRelation})
    : super(tableName: 'print_point_transactions') {
    updateTable = PrintPointTransactionUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    printRequestId = _is.ColumnInt(
      'printRequestId',
      this,
    );
    type = _is.ColumnString(
      'type',
      this,
    );
    points = _is.ColumnInt(
      'points',
      this,
    );
    balanceAfter = _is.ColumnInt(
      'balanceAfter',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final PrintPointTransactionUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnInt printRequestId;

  late final _is.ColumnString type;

  late final _is.ColumnInt points;

  late final _is.ColumnInt balanceAfter;

  late final _is.ColumnString description;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    printRequestId,
    type,
    points,
    balanceAfter,
    description,
    createdAt,
  ];
}

class PrintPointTransactionInclude extends _is.IncludeObject {
  PrintPointTransactionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PrintPointTransaction.t;
}

class PrintPointTransactionIncludeList extends _is.IncludeList {
  PrintPointTransactionIncludeList._({
    _is.WhereExpressionBuilder<PrintPointTransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PrintPointTransaction.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PrintPointTransaction.t;
}

class PrintPointTransactionRepository {
  const PrintPointTransactionRepository._();

  /// Returns a list of [PrintPointTransaction]s matching the given query parameters.
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
  Future<List<PrintPointTransaction>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PrintPointTransactionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PrintPointTransactionTable>? orderBy,
    _is.OrderByListBuilder<PrintPointTransactionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PrintPointTransaction>(
      where: where?.call(PrintPointTransaction.t),
      orderBy: orderBy?.call(PrintPointTransaction.t),
      orderByList: orderByList?.call(PrintPointTransaction.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PrintPointTransaction] matching the given query parameters.
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
  Future<PrintPointTransaction?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PrintPointTransactionTable>? where,
    int? offset,
    _is.OrderByBuilder<PrintPointTransactionTable>? orderBy,
    _is.OrderByListBuilder<PrintPointTransactionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PrintPointTransaction>(
      where: where?.call(PrintPointTransaction.t),
      orderBy: orderBy?.call(PrintPointTransaction.t),
      orderByList: orderByList?.call(PrintPointTransaction.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PrintPointTransaction] by its [id] or null if no such row exists.
  Future<PrintPointTransaction?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PrintPointTransaction>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PrintPointTransaction]s in the list and returns the inserted rows.
  ///
  /// The returned [PrintPointTransaction]s will have their `id` fields set.
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
  Future<List<PrintPointTransaction>> insert(
    _is.DatabaseSession session,
    List<PrintPointTransaction> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PrintPointTransaction>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PrintPointTransaction] and returns the inserted row.
  ///
  /// The returned [PrintPointTransaction] will have its `id` field set.
  Future<PrintPointTransaction> insertRow(
    _is.DatabaseSession session,
    PrintPointTransaction row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PrintPointTransaction>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PrintPointTransaction]s in the list and returns the resulting rows.
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
  /// The returned [PrintPointTransaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PrintPointTransaction>> upsert(
    _is.DatabaseSession session,
    List<PrintPointTransaction> rows, {
    required _is.ColumnSelections<PrintPointTransactionTable> conflictColumns,
    _is.ColumnSelections<PrintPointTransactionTable>? updateColumns,
    _is.WhereExpressionBuilder<PrintPointTransactionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PrintPointTransaction>(
      rows,
      conflictColumns: conflictColumns(PrintPointTransaction.t),
      updateColumns: updateColumns?.call(PrintPointTransaction.t),
      updateWhere: updateWhere?.call(PrintPointTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PrintPointTransaction] and returns the resulting row.
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
  /// The returned [PrintPointTransaction] will have its `id` field set.
  Future<PrintPointTransaction?> upsertRow(
    _is.DatabaseSession session,
    PrintPointTransaction row, {
    required _is.ColumnSelections<PrintPointTransactionTable> conflictColumns,
    _is.ColumnSelections<PrintPointTransactionTable>? updateColumns,
    _is.WhereExpressionBuilder<PrintPointTransactionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PrintPointTransaction>(
      row,
      conflictColumns: conflictColumns(PrintPointTransaction.t),
      updateColumns: updateColumns?.call(PrintPointTransaction.t),
      updateWhere: updateWhere?.call(PrintPointTransaction.t),
      transaction: transaction,
    );
  }

  /// Updates all [PrintPointTransaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PrintPointTransaction>> update(
    _is.DatabaseSession session,
    List<PrintPointTransaction> rows, {
    _is.ColumnSelections<PrintPointTransactionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PrintPointTransaction>(
      rows,
      columns: columns?.call(PrintPointTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PrintPointTransaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PrintPointTransaction> updateRow(
    _is.DatabaseSession session,
    PrintPointTransaction row, {
    _is.ColumnSelections<PrintPointTransactionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PrintPointTransaction>(
      row,
      columns: columns?.call(PrintPointTransaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PrintPointTransaction] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PrintPointTransaction?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PrintPointTransactionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PrintPointTransaction>(
      id,
      columnValues: columnValues(PrintPointTransaction.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PrintPointTransaction]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PrintPointTransaction>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PrintPointTransactionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<PrintPointTransactionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PrintPointTransactionTable>? orderBy,
    _is.OrderByListBuilder<PrintPointTransactionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PrintPointTransaction>(
      columnValues: columnValues(PrintPointTransaction.t.updateTable),
      where: where(PrintPointTransaction.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PrintPointTransaction.t),
      orderByList: orderByList?.call(PrintPointTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PrintPointTransaction]s in the list and returns the deleted rows.
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
  Future<List<PrintPointTransaction>> delete(
    _is.DatabaseSession session,
    List<PrintPointTransaction> rows, {
    _is.OrderByBuilder<PrintPointTransactionTable>? orderBy,
    _is.OrderByListBuilder<PrintPointTransactionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PrintPointTransaction>(
      rows,
      orderBy: orderBy?.call(PrintPointTransaction.t),
      orderByList: orderByList?.call(PrintPointTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PrintPointTransaction].
  Future<PrintPointTransaction> deleteRow(
    _is.DatabaseSession session,
    PrintPointTransaction row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PrintPointTransaction>(
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
  Future<List<PrintPointTransaction>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PrintPointTransactionTable> where,
    _is.OrderByBuilder<PrintPointTransactionTable>? orderBy,
    _is.OrderByListBuilder<PrintPointTransactionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PrintPointTransaction>(
      where: where(PrintPointTransaction.t),
      orderBy: orderBy?.call(PrintPointTransaction.t),
      orderByList: orderByList?.call(PrintPointTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PrintPointTransactionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PrintPointTransaction>(
      where: where?.call(PrintPointTransaction.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PrintPointTransaction] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PrintPointTransactionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PrintPointTransaction>(
      where: where(PrintPointTransaction.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
