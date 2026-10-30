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

abstract class PrintPointWallet
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PrintPointWallet._({
    this.id,
    required this.authUserId,
    required this.studentName,
    required this.balance,
    required this.lifetimeEarned,
    required this.lifetimeRedeemed,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory PrintPointWallet({
    int? id,
    required _is.UuidValue authUserId,
    required String studentName,
    required int balance,
    required int lifetimeEarned,
    required int lifetimeRedeemed,
    DateTime? updatedAt,
  }) = _PrintPointWalletImpl;

  factory PrintPointWallet.fromJson(Map<String, dynamic> jsonSerialization) {
    return PrintPointWallet(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      balance: jsonSerialization['balance'] as int,
      lifetimeEarned: jsonSerialization['lifetimeEarned'] as int,
      lifetimeRedeemed: jsonSerialization['lifetimeRedeemed'] as int,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = PrintPointWalletTable();

  static const db = PrintPointWalletRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String studentName;

  int balance;

  int lifetimeEarned;

  int lifetimeRedeemed;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PrintPointWallet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PrintPointWallet copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? studentName,
    int? balance,
    int? lifetimeEarned,
    int? lifetimeRedeemed,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PrintPointWallet',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'balance': balance,
      'lifetimeEarned': lifetimeEarned,
      'lifetimeRedeemed': lifetimeRedeemed,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PrintPointWallet',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'balance': balance,
      'lifetimeEarned': lifetimeEarned,
      'lifetimeRedeemed': lifetimeRedeemed,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PrintPointWalletInclude include() {
    return PrintPointWalletInclude._();
  }

  static PrintPointWalletIncludeList includeList({
    _is.WhereExpressionBuilder<PrintPointWalletTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PrintPointWalletTable>? orderBy,
    _is.OrderByListBuilder<PrintPointWalletTable>? orderByList,
    PrintPointWalletInclude? include,
  }) {
    return PrintPointWalletIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PrintPointWallet.t),
      orderByList: orderByList?.call(PrintPointWallet.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrintPointWalletImpl extends PrintPointWallet {
  _PrintPointWalletImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String studentName,
    required int balance,
    required int lifetimeEarned,
    required int lifetimeRedeemed,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         studentName: studentName,
         balance: balance,
         lifetimeEarned: lifetimeEarned,
         lifetimeRedeemed: lifetimeRedeemed,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PrintPointWallet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PrintPointWallet copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? studentName,
    int? balance,
    int? lifetimeEarned,
    int? lifetimeRedeemed,
    DateTime? updatedAt,
  }) {
    return PrintPointWallet(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      balance: balance ?? this.balance,
      lifetimeEarned: lifetimeEarned ?? this.lifetimeEarned,
      lifetimeRedeemed: lifetimeRedeemed ?? this.lifetimeRedeemed,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PrintPointWalletUpdateTable
    extends _is.UpdateTable<PrintPointWalletTable> {
  PrintPointWalletUpdateTable(super.table);

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

  _is.ColumnValue<int, int> balance(int value) => _is.ColumnValue(
    table.balance,
    value,
  );

  _is.ColumnValue<int, int> lifetimeEarned(int value) => _is.ColumnValue(
    table.lifetimeEarned,
    value,
  );

  _is.ColumnValue<int, int> lifetimeRedeemed(int value) => _is.ColumnValue(
    table.lifetimeRedeemed,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class PrintPointWalletTable extends _is.Table<int?> {
  PrintPointWalletTable({super.tableRelation})
    : super(tableName: 'print_point_wallets') {
    updateTable = PrintPointWalletUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    studentName = _is.ColumnString(
      'studentName',
      this,
    );
    balance = _is.ColumnInt(
      'balance',
      this,
    );
    lifetimeEarned = _is.ColumnInt(
      'lifetimeEarned',
      this,
    );
    lifetimeRedeemed = _is.ColumnInt(
      'lifetimeRedeemed',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final PrintPointWalletUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString studentName;

  late final _is.ColumnInt balance;

  late final _is.ColumnInt lifetimeEarned;

  late final _is.ColumnInt lifetimeRedeemed;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    studentName,
    balance,
    lifetimeEarned,
    lifetimeRedeemed,
    updatedAt,
  ];
}

class PrintPointWalletInclude extends _is.IncludeObject {
  PrintPointWalletInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PrintPointWallet.t;
}

class PrintPointWalletIncludeList extends _is.IncludeList {
  PrintPointWalletIncludeList._({
    _is.WhereExpressionBuilder<PrintPointWalletTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PrintPointWallet.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PrintPointWallet.t;
}

class PrintPointWalletRepository {
  const PrintPointWalletRepository._();

  /// Returns a list of [PrintPointWallet]s matching the given query parameters.
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
  Future<List<PrintPointWallet>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PrintPointWalletTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PrintPointWalletTable>? orderBy,
    _is.OrderByListBuilder<PrintPointWalletTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PrintPointWallet>(
      where: where?.call(PrintPointWallet.t),
      orderBy: orderBy?.call(PrintPointWallet.t),
      orderByList: orderByList?.call(PrintPointWallet.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PrintPointWallet] matching the given query parameters.
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
  Future<PrintPointWallet?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PrintPointWalletTable>? where,
    int? offset,
    _is.OrderByBuilder<PrintPointWalletTable>? orderBy,
    _is.OrderByListBuilder<PrintPointWalletTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PrintPointWallet>(
      where: where?.call(PrintPointWallet.t),
      orderBy: orderBy?.call(PrintPointWallet.t),
      orderByList: orderByList?.call(PrintPointWallet.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PrintPointWallet] by its [id] or null if no such row exists.
  Future<PrintPointWallet?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PrintPointWallet>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PrintPointWallet]s in the list and returns the inserted rows.
  ///
  /// The returned [PrintPointWallet]s will have their `id` fields set.
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
  Future<List<PrintPointWallet>> insert(
    _is.DatabaseSession session,
    List<PrintPointWallet> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PrintPointWallet>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PrintPointWallet] and returns the inserted row.
  ///
  /// The returned [PrintPointWallet] will have its `id` field set.
  Future<PrintPointWallet> insertRow(
    _is.DatabaseSession session,
    PrintPointWallet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PrintPointWallet>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PrintPointWallet]s in the list and returns the resulting rows.
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
  /// The returned [PrintPointWallet]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PrintPointWallet>> upsert(
    _is.DatabaseSession session,
    List<PrintPointWallet> rows, {
    required _is.ColumnSelections<PrintPointWalletTable> conflictColumns,
    _is.ColumnSelections<PrintPointWalletTable>? updateColumns,
    _is.WhereExpressionBuilder<PrintPointWalletTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PrintPointWallet>(
      rows,
      conflictColumns: conflictColumns(PrintPointWallet.t),
      updateColumns: updateColumns?.call(PrintPointWallet.t),
      updateWhere: updateWhere?.call(PrintPointWallet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PrintPointWallet] and returns the resulting row.
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
  /// The returned [PrintPointWallet] will have its `id` field set.
  Future<PrintPointWallet?> upsertRow(
    _is.DatabaseSession session,
    PrintPointWallet row, {
    required _is.ColumnSelections<PrintPointWalletTable> conflictColumns,
    _is.ColumnSelections<PrintPointWalletTable>? updateColumns,
    _is.WhereExpressionBuilder<PrintPointWalletTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PrintPointWallet>(
      row,
      conflictColumns: conflictColumns(PrintPointWallet.t),
      updateColumns: updateColumns?.call(PrintPointWallet.t),
      updateWhere: updateWhere?.call(PrintPointWallet.t),
      transaction: transaction,
    );
  }

  /// Updates all [PrintPointWallet]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PrintPointWallet>> update(
    _is.DatabaseSession session,
    List<PrintPointWallet> rows, {
    _is.ColumnSelections<PrintPointWalletTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PrintPointWallet>(
      rows,
      columns: columns?.call(PrintPointWallet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PrintPointWallet]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PrintPointWallet> updateRow(
    _is.DatabaseSession session,
    PrintPointWallet row, {
    _is.ColumnSelections<PrintPointWalletTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PrintPointWallet>(
      row,
      columns: columns?.call(PrintPointWallet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PrintPointWallet] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PrintPointWallet?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PrintPointWalletUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PrintPointWallet>(
      id,
      columnValues: columnValues(PrintPointWallet.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PrintPointWallet]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PrintPointWallet>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PrintPointWalletUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<PrintPointWalletTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PrintPointWalletTable>? orderBy,
    _is.OrderByListBuilder<PrintPointWalletTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PrintPointWallet>(
      columnValues: columnValues(PrintPointWallet.t.updateTable),
      where: where(PrintPointWallet.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PrintPointWallet.t),
      orderByList: orderByList?.call(PrintPointWallet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PrintPointWallet]s in the list and returns the deleted rows.
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
  Future<List<PrintPointWallet>> delete(
    _is.DatabaseSession session,
    List<PrintPointWallet> rows, {
    _is.OrderByBuilder<PrintPointWalletTable>? orderBy,
    _is.OrderByListBuilder<PrintPointWalletTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PrintPointWallet>(
      rows,
      orderBy: orderBy?.call(PrintPointWallet.t),
      orderByList: orderByList?.call(PrintPointWallet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PrintPointWallet].
  Future<PrintPointWallet> deleteRow(
    _is.DatabaseSession session,
    PrintPointWallet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PrintPointWallet>(
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
  Future<List<PrintPointWallet>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PrintPointWalletTable> where,
    _is.OrderByBuilder<PrintPointWalletTable>? orderBy,
    _is.OrderByListBuilder<PrintPointWalletTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PrintPointWallet>(
      where: where(PrintPointWallet.t),
      orderBy: orderBy?.call(PrintPointWallet.t),
      orderByList: orderByList?.call(PrintPointWallet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PrintPointWalletTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PrintPointWallet>(
      where: where?.call(PrintPointWallet.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PrintPointWallet] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PrintPointWalletTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PrintPointWallet>(
      where: where(PrintPointWallet.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
