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

abstract class RewardPerk
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RewardPerk._({
    this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.costPoints,
    required this.stockRemaining,
    this.imageUrl,
    bool? isActive,
    DateTime? createdAt,
  }) : isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory RewardPerk({
    int? id,
    required String title,
    required String category,
    required String description,
    required int costPoints,
    required int stockRemaining,
    String? imageUrl,
    bool? isActive,
    DateTime? createdAt,
  }) = _RewardPerkImpl;

  factory RewardPerk.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardPerk(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      category: jsonSerialization['category'] as String,
      description: jsonSerialization['description'] as String,
      costPoints: jsonSerialization['costPoints'] as int,
      stockRemaining: jsonSerialization['stockRemaining'] as int,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = RewardPerkTable();

  static const db = RewardPerkRepository._();

  @override
  int? id;

  String title;

  String category;

  String description;

  int costPoints;

  int stockRemaining;

  String? imageUrl;

  bool isActive;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardPerk]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RewardPerk copyWith({
    int? id,
    String? title,
    String? category,
    String? description,
    int? costPoints,
    int? stockRemaining,
    String? imageUrl,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardPerk',
      if (id != null) 'id': id,
      'title': title,
      'category': category,
      'description': description,
      'costPoints': costPoints,
      'stockRemaining': stockRemaining,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardPerk',
      if (id != null) 'id': id,
      'title': title,
      'category': category,
      'description': description,
      'costPoints': costPoints,
      'stockRemaining': stockRemaining,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  static RewardPerkInclude include() {
    return RewardPerkInclude._();
  }

  static RewardPerkIncludeList includeList({
    _is.WhereExpressionBuilder<RewardPerkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardPerkTable>? orderBy,
    _is.OrderByListBuilder<RewardPerkTable>? orderByList,
    RewardPerkInclude? include,
  }) {
    return RewardPerkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardPerk.t),
      orderByList: orderByList?.call(RewardPerk.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardPerkImpl extends RewardPerk {
  _RewardPerkImpl({
    int? id,
    required String title,
    required String category,
    required String description,
    required int costPoints,
    required int stockRemaining,
    String? imageUrl,
    bool? isActive,
    DateTime? createdAt,
  }) : super._(
         id: id,
         title: title,
         category: category,
         description: description,
         costPoints: costPoints,
         stockRemaining: stockRemaining,
         imageUrl: imageUrl,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RewardPerk]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RewardPerk copyWith({
    Object? id = _Undefined,
    String? title,
    String? category,
    String? description,
    int? costPoints,
    int? stockRemaining,
    Object? imageUrl = _Undefined,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return RewardPerk(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      costPoints: costPoints ?? this.costPoints,
      stockRemaining: stockRemaining ?? this.stockRemaining,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RewardPerkUpdateTable extends _is.UpdateTable<RewardPerkTable> {
  RewardPerkUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<int, int> costPoints(int value) => _is.ColumnValue(
    table.costPoints,
    value,
  );

  _is.ColumnValue<int, int> stockRemaining(int value) => _is.ColumnValue(
    table.stockRemaining,
    value,
  );

  _is.ColumnValue<String, String> imageUrl(String? value) => _is.ColumnValue(
    table.imageUrl,
    value,
  );

  _is.ColumnValue<bool, bool> isActive(bool value) => _is.ColumnValue(
    table.isActive,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RewardPerkTable extends _is.Table<int?> {
  RewardPerkTable({super.tableRelation}) : super(tableName: 'reward_perks') {
    updateTable = RewardPerkUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    costPoints = _is.ColumnInt(
      'costPoints',
      this,
    );
    stockRemaining = _is.ColumnInt(
      'stockRemaining',
      this,
    );
    imageUrl = _is.ColumnString(
      'imageUrl',
      this,
    );
    isActive = _is.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final RewardPerkUpdateTable updateTable;

  late final _is.ColumnString title;

  late final _is.ColumnString category;

  late final _is.ColumnString description;

  late final _is.ColumnInt costPoints;

  late final _is.ColumnInt stockRemaining;

  late final _is.ColumnString imageUrl;

  late final _is.ColumnBool isActive;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    title,
    category,
    description,
    costPoints,
    stockRemaining,
    imageUrl,
    isActive,
    createdAt,
  ];
}

class RewardPerkInclude extends _is.IncludeObject {
  RewardPerkInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RewardPerk.t;
}

class RewardPerkIncludeList extends _is.IncludeList {
  RewardPerkIncludeList._({
    _is.WhereExpressionBuilder<RewardPerkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardPerk.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RewardPerk.t;
}

class RewardPerkRepository {
  const RewardPerkRepository._();

  /// Returns a list of [RewardPerk]s matching the given query parameters.
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
  Future<List<RewardPerk>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardPerkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardPerkTable>? orderBy,
    _is.OrderByListBuilder<RewardPerkTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardPerk>(
      where: where?.call(RewardPerk.t),
      orderBy: orderBy?.call(RewardPerk.t),
      orderByList: orderByList?.call(RewardPerk.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardPerk] matching the given query parameters.
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
  Future<RewardPerk?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardPerkTable>? where,
    int? offset,
    _is.OrderByBuilder<RewardPerkTable>? orderBy,
    _is.OrderByListBuilder<RewardPerkTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardPerk>(
      where: where?.call(RewardPerk.t),
      orderBy: orderBy?.call(RewardPerk.t),
      orderByList: orderByList?.call(RewardPerk.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardPerk] by its [id] or null if no such row exists.
  Future<RewardPerk?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardPerk>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardPerk]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardPerk]s will have their `id` fields set.
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
  Future<List<RewardPerk>> insert(
    _is.DatabaseSession session,
    List<RewardPerk> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RewardPerk>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RewardPerk] and returns the inserted row.
  ///
  /// The returned [RewardPerk] will have its `id` field set.
  Future<RewardPerk> insertRow(
    _is.DatabaseSession session,
    RewardPerk row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardPerk>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RewardPerk]s in the list and returns the resulting rows.
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
  /// The returned [RewardPerk]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardPerk>> upsert(
    _is.DatabaseSession session,
    List<RewardPerk> rows, {
    required _is.ColumnSelections<RewardPerkTable> conflictColumns,
    _is.ColumnSelections<RewardPerkTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardPerkTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RewardPerk>(
      rows,
      conflictColumns: conflictColumns(RewardPerk.t),
      updateColumns: updateColumns?.call(RewardPerk.t),
      updateWhere: updateWhere?.call(RewardPerk.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RewardPerk] and returns the resulting row.
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
  /// The returned [RewardPerk] will have its `id` field set.
  Future<RewardPerk?> upsertRow(
    _is.DatabaseSession session,
    RewardPerk row, {
    required _is.ColumnSelections<RewardPerkTable> conflictColumns,
    _is.ColumnSelections<RewardPerkTable>? updateColumns,
    _is.WhereExpressionBuilder<RewardPerkTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RewardPerk>(
      row,
      conflictColumns: conflictColumns(RewardPerk.t),
      updateColumns: updateColumns?.call(RewardPerk.t),
      updateWhere: updateWhere?.call(RewardPerk.t),
      transaction: transaction,
    );
  }

  /// Updates all [RewardPerk]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardPerk>> update(
    _is.DatabaseSession session,
    List<RewardPerk> rows, {
    _is.ColumnSelections<RewardPerkTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RewardPerk>(
      rows,
      columns: columns?.call(RewardPerk.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RewardPerk]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardPerk> updateRow(
    _is.DatabaseSession session,
    RewardPerk row, {
    _is.ColumnSelections<RewardPerkTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardPerk>(
      row,
      columns: columns?.call(RewardPerk.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardPerk] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardPerk?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RewardPerkUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardPerk>(
      id,
      columnValues: columnValues(RewardPerk.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardPerk]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RewardPerk>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RewardPerkUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RewardPerkTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RewardPerkTable>? orderBy,
    _is.OrderByListBuilder<RewardPerkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RewardPerk>(
      columnValues: columnValues(RewardPerk.t.updateTable),
      where: where(RewardPerk.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardPerk.t),
      orderByList: orderByList?.call(RewardPerk.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RewardPerk]s in the list and returns the deleted rows.
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
  Future<List<RewardPerk>> delete(
    _is.DatabaseSession session,
    List<RewardPerk> rows, {
    _is.OrderByBuilder<RewardPerkTable>? orderBy,
    _is.OrderByListBuilder<RewardPerkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RewardPerk>(
      rows,
      orderBy: orderBy?.call(RewardPerk.t),
      orderByList: orderByList?.call(RewardPerk.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RewardPerk].
  Future<RewardPerk> deleteRow(
    _is.DatabaseSession session,
    RewardPerk row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardPerk>(
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
  Future<List<RewardPerk>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardPerkTable> where,
    _is.OrderByBuilder<RewardPerkTable>? orderBy,
    _is.OrderByListBuilder<RewardPerkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RewardPerk>(
      where: where(RewardPerk.t),
      orderBy: orderBy?.call(RewardPerk.t),
      orderByList: orderByList?.call(RewardPerk.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RewardPerkTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RewardPerk>(
      where: where?.call(RewardPerk.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardPerk] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RewardPerkTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardPerk>(
      where: where(RewardPerk.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
