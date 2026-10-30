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

abstract class CampusCompany
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CampusCompany._({
    this.id,
    required this.name,
    required this.tier,
    required this.avgPackageLpa,
    required this.eligibleBranches,
    required this.cgpaCutoff,
    required this.hiringRounds,
    required this.keyFocusAreas,
    required this.description,
    this.logoUrl,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CampusCompany({
    int? id,
    required String name,
    required String tier,
    required double avgPackageLpa,
    required List<String> eligibleBranches,
    required double cgpaCutoff,
    required List<String> hiringRounds,
    required List<String> keyFocusAreas,
    required String description,
    String? logoUrl,
    DateTime? createdAt,
  }) = _CampusCompanyImpl;

  factory CampusCompany.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusCompany(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      tier: jsonSerialization['tier'] as String,
      avgPackageLpa: (jsonSerialization['avgPackageLpa'] as num).toDouble(),
      eligibleBranches: _i2t5n14n.Protocol().deserialize<List<String>>(
        jsonSerialization['eligibleBranches'],
      ),
      cgpaCutoff: (jsonSerialization['cgpaCutoff'] as num).toDouble(),
      hiringRounds: _i2t5n14n.Protocol().deserialize<List<String>>(
        jsonSerialization['hiringRounds'],
      ),
      keyFocusAreas: _i2t5n14n.Protocol().deserialize<List<String>>(
        jsonSerialization['keyFocusAreas'],
      ),
      description: jsonSerialization['description'] as String,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CampusCompanyTable();

  static const db = CampusCompanyRepository._();

  @override
  int? id;

  String name;

  String tier;

  double avgPackageLpa;

  List<String> eligibleBranches;

  double cgpaCutoff;

  List<String> hiringRounds;

  List<String> keyFocusAreas;

  String description;

  String? logoUrl;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CampusCompany]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CampusCompany copyWith({
    int? id,
    String? name,
    String? tier,
    double? avgPackageLpa,
    List<String>? eligibleBranches,
    double? cgpaCutoff,
    List<String>? hiringRounds,
    List<String>? keyFocusAreas,
    String? description,
    String? logoUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusCompany',
      if (id != null) 'id': id,
      'name': name,
      'tier': tier,
      'avgPackageLpa': avgPackageLpa,
      'eligibleBranches': eligibleBranches.toJson(),
      'cgpaCutoff': cgpaCutoff,
      'hiringRounds': hiringRounds.toJson(),
      'keyFocusAreas': keyFocusAreas.toJson(),
      'description': description,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusCompany',
      if (id != null) 'id': id,
      'name': name,
      'tier': tier,
      'avgPackageLpa': avgPackageLpa,
      'eligibleBranches': eligibleBranches.toJson(),
      'cgpaCutoff': cgpaCutoff,
      'hiringRounds': hiringRounds.toJson(),
      'keyFocusAreas': keyFocusAreas.toJson(),
      'description': description,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  static CampusCompanyInclude include() {
    return CampusCompanyInclude._();
  }

  static CampusCompanyIncludeList includeList({
    _is.WhereExpressionBuilder<CampusCompanyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusCompanyTable>? orderBy,
    _is.OrderByListBuilder<CampusCompanyTable>? orderByList,
    CampusCompanyInclude? include,
  }) {
    return CampusCompanyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusCompany.t),
      orderByList: orderByList?.call(CampusCompany.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusCompanyImpl extends CampusCompany {
  _CampusCompanyImpl({
    int? id,
    required String name,
    required String tier,
    required double avgPackageLpa,
    required List<String> eligibleBranches,
    required double cgpaCutoff,
    required List<String> hiringRounds,
    required List<String> keyFocusAreas,
    required String description,
    String? logoUrl,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         tier: tier,
         avgPackageLpa: avgPackageLpa,
         eligibleBranches: eligibleBranches,
         cgpaCutoff: cgpaCutoff,
         hiringRounds: hiringRounds,
         keyFocusAreas: keyFocusAreas,
         description: description,
         logoUrl: logoUrl,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CampusCompany]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CampusCompany copyWith({
    Object? id = _Undefined,
    String? name,
    String? tier,
    double? avgPackageLpa,
    List<String>? eligibleBranches,
    double? cgpaCutoff,
    List<String>? hiringRounds,
    List<String>? keyFocusAreas,
    String? description,
    Object? logoUrl = _Undefined,
    DateTime? createdAt,
  }) {
    return CampusCompany(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      tier: tier ?? this.tier,
      avgPackageLpa: avgPackageLpa ?? this.avgPackageLpa,
      eligibleBranches:
          eligibleBranches ?? this.eligibleBranches.map((e0) => e0).toList(),
      cgpaCutoff: cgpaCutoff ?? this.cgpaCutoff,
      hiringRounds: hiringRounds ?? this.hiringRounds.map((e0) => e0).toList(),
      keyFocusAreas:
          keyFocusAreas ?? this.keyFocusAreas.map((e0) => e0).toList(),
      description: description ?? this.description,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CampusCompanyUpdateTable extends _is.UpdateTable<CampusCompanyTable> {
  CampusCompanyUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> tier(String value) => _is.ColumnValue(
    table.tier,
    value,
  );

  _is.ColumnValue<double, double> avgPackageLpa(double value) =>
      _is.ColumnValue(
        table.avgPackageLpa,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> eligibleBranches(
    List<String> value,
  ) => _is.ColumnValue(
    table.eligibleBranches,
    value,
  );

  _is.ColumnValue<double, double> cgpaCutoff(double value) => _is.ColumnValue(
    table.cgpaCutoff,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> hiringRounds(
    List<String> value,
  ) => _is.ColumnValue(
    table.hiringRounds,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> keyFocusAreas(
    List<String> value,
  ) => _is.ColumnValue(
    table.keyFocusAreas,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> logoUrl(String? value) => _is.ColumnValue(
    table.logoUrl,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class CampusCompanyTable extends _is.Table<int?> {
  CampusCompanyTable({super.tableRelation})
    : super(tableName: 'campus_companies') {
    updateTable = CampusCompanyUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    tier = _is.ColumnString(
      'tier',
      this,
    );
    avgPackageLpa = _is.ColumnDouble(
      'avgPackageLpa',
      this,
    );
    eligibleBranches = _is.ColumnSerializable<List<String>>(
      'eligibleBranches',
      this,
    );
    cgpaCutoff = _is.ColumnDouble(
      'cgpaCutoff',
      this,
    );
    hiringRounds = _is.ColumnSerializable<List<String>>(
      'hiringRounds',
      this,
    );
    keyFocusAreas = _is.ColumnSerializable<List<String>>(
      'keyFocusAreas',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    logoUrl = _is.ColumnString(
      'logoUrl',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CampusCompanyUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString tier;

  late final _is.ColumnDouble avgPackageLpa;

  late final _is.ColumnSerializable<List<String>> eligibleBranches;

  late final _is.ColumnDouble cgpaCutoff;

  late final _is.ColumnSerializable<List<String>> hiringRounds;

  late final _is.ColumnSerializable<List<String>> keyFocusAreas;

  late final _is.ColumnString description;

  late final _is.ColumnString logoUrl;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    tier,
    avgPackageLpa,
    eligibleBranches,
    cgpaCutoff,
    hiringRounds,
    keyFocusAreas,
    description,
    logoUrl,
    createdAt,
  ];
}

class CampusCompanyInclude extends _is.IncludeObject {
  CampusCompanyInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CampusCompany.t;
}

class CampusCompanyIncludeList extends _is.IncludeList {
  CampusCompanyIncludeList._({
    _is.WhereExpressionBuilder<CampusCompanyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CampusCompany.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CampusCompany.t;
}

class CampusCompanyRepository {
  const CampusCompanyRepository._();

  /// Returns a list of [CampusCompany]s matching the given query parameters.
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
  Future<List<CampusCompany>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusCompanyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusCompanyTable>? orderBy,
    _is.OrderByListBuilder<CampusCompanyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CampusCompany>(
      where: where?.call(CampusCompany.t),
      orderBy: orderBy?.call(CampusCompany.t),
      orderByList: orderByList?.call(CampusCompany.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CampusCompany] matching the given query parameters.
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
  Future<CampusCompany?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusCompanyTable>? where,
    int? offset,
    _is.OrderByBuilder<CampusCompanyTable>? orderBy,
    _is.OrderByListBuilder<CampusCompanyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CampusCompany>(
      where: where?.call(CampusCompany.t),
      orderBy: orderBy?.call(CampusCompany.t),
      orderByList: orderByList?.call(CampusCompany.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CampusCompany] by its [id] or null if no such row exists.
  Future<CampusCompany?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CampusCompany>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CampusCompany]s in the list and returns the inserted rows.
  ///
  /// The returned [CampusCompany]s will have their `id` fields set.
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
  Future<List<CampusCompany>> insert(
    _is.DatabaseSession session,
    List<CampusCompany> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CampusCompany>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CampusCompany] and returns the inserted row.
  ///
  /// The returned [CampusCompany] will have its `id` field set.
  Future<CampusCompany> insertRow(
    _is.DatabaseSession session,
    CampusCompany row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CampusCompany>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CampusCompany]s in the list and returns the resulting rows.
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
  /// The returned [CampusCompany]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusCompany>> upsert(
    _is.DatabaseSession session,
    List<CampusCompany> rows, {
    required _is.ColumnSelections<CampusCompanyTable> conflictColumns,
    _is.ColumnSelections<CampusCompanyTable>? updateColumns,
    _is.WhereExpressionBuilder<CampusCompanyTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CampusCompany>(
      rows,
      conflictColumns: conflictColumns(CampusCompany.t),
      updateColumns: updateColumns?.call(CampusCompany.t),
      updateWhere: updateWhere?.call(CampusCompany.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CampusCompany] and returns the resulting row.
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
  /// The returned [CampusCompany] will have its `id` field set.
  Future<CampusCompany?> upsertRow(
    _is.DatabaseSession session,
    CampusCompany row, {
    required _is.ColumnSelections<CampusCompanyTable> conflictColumns,
    _is.ColumnSelections<CampusCompanyTable>? updateColumns,
    _is.WhereExpressionBuilder<CampusCompanyTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CampusCompany>(
      row,
      conflictColumns: conflictColumns(CampusCompany.t),
      updateColumns: updateColumns?.call(CampusCompany.t),
      updateWhere: updateWhere?.call(CampusCompany.t),
      transaction: transaction,
    );
  }

  /// Updates all [CampusCompany]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusCompany>> update(
    _is.DatabaseSession session,
    List<CampusCompany> rows, {
    _is.ColumnSelections<CampusCompanyTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CampusCompany>(
      rows,
      columns: columns?.call(CampusCompany.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CampusCompany]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CampusCompany> updateRow(
    _is.DatabaseSession session,
    CampusCompany row, {
    _is.ColumnSelections<CampusCompanyTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CampusCompany>(
      row,
      columns: columns?.call(CampusCompany.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CampusCompany] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CampusCompany?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CampusCompanyUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CampusCompany>(
      id,
      columnValues: columnValues(CampusCompany.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CampusCompany]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusCompany>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CampusCompanyUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CampusCompanyTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusCompanyTable>? orderBy,
    _is.OrderByListBuilder<CampusCompanyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CampusCompany>(
      columnValues: columnValues(CampusCompany.t.updateTable),
      where: where(CampusCompany.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusCompany.t),
      orderByList: orderByList?.call(CampusCompany.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CampusCompany]s in the list and returns the deleted rows.
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
  Future<List<CampusCompany>> delete(
    _is.DatabaseSession session,
    List<CampusCompany> rows, {
    _is.OrderByBuilder<CampusCompanyTable>? orderBy,
    _is.OrderByListBuilder<CampusCompanyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CampusCompany>(
      rows,
      orderBy: orderBy?.call(CampusCompany.t),
      orderByList: orderByList?.call(CampusCompany.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CampusCompany].
  Future<CampusCompany> deleteRow(
    _is.DatabaseSession session,
    CampusCompany row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CampusCompany>(
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
  Future<List<CampusCompany>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CampusCompanyTable> where,
    _is.OrderByBuilder<CampusCompanyTable>? orderBy,
    _is.OrderByListBuilder<CampusCompanyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CampusCompany>(
      where: where(CampusCompany.t),
      orderBy: orderBy?.call(CampusCompany.t),
      orderByList: orderByList?.call(CampusCompany.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusCompanyTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CampusCompany>(
      where: where?.call(CampusCompany.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CampusCompany] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CampusCompanyTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CampusCompany>(
      where: where(CampusCompany.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
