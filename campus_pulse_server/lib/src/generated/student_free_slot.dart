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

abstract class StudentFreeSlot
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StudentFreeSlot._({
    this.id,
    required this.authUserId,
    required this.dayOfWeek,
    required this.slotLabel,
    required this.startTime,
    required this.endTime,
    bool? isFree,
    DateTime? updatedAt,
  }) : isFree = isFree ?? true,
       updatedAt = updatedAt ?? DateTime.now();

  factory StudentFreeSlot({
    int? id,
    required _is.UuidValue authUserId,
    required String dayOfWeek,
    required String slotLabel,
    required String startTime,
    required String endTime,
    bool? isFree,
    DateTime? updatedAt,
  }) = _StudentFreeSlotImpl;

  factory StudentFreeSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentFreeSlot(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      dayOfWeek: jsonSerialization['dayOfWeek'] as String,
      slotLabel: jsonSerialization['slotLabel'] as String,
      startTime: jsonSerialization['startTime'] as String,
      endTime: jsonSerialization['endTime'] as String,
      isFree: jsonSerialization['isFree'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isFree']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = StudentFreeSlotTable();

  static const db = StudentFreeSlotRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String dayOfWeek;

  String slotLabel;

  String startTime;

  String endTime;

  bool isFree;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudentFreeSlot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudentFreeSlot copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? dayOfWeek,
    String? slotLabel,
    String? startTime,
    String? endTime,
    bool? isFree,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentFreeSlot',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'dayOfWeek': dayOfWeek,
      'slotLabel': slotLabel,
      'startTime': startTime,
      'endTime': endTime,
      'isFree': isFree,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentFreeSlot',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'dayOfWeek': dayOfWeek,
      'slotLabel': slotLabel,
      'startTime': startTime,
      'endTime': endTime,
      'isFree': isFree,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StudentFreeSlotInclude include() {
    return StudentFreeSlotInclude._();
  }

  static StudentFreeSlotIncludeList includeList({
    _is.WhereExpressionBuilder<StudentFreeSlotTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentFreeSlotTable>? orderBy,
    _is.OrderByListBuilder<StudentFreeSlotTable>? orderByList,
    StudentFreeSlotInclude? include,
  }) {
    return StudentFreeSlotIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentFreeSlot.t),
      orderByList: orderByList?.call(StudentFreeSlot.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentFreeSlotImpl extends StudentFreeSlot {
  _StudentFreeSlotImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String dayOfWeek,
    required String slotLabel,
    required String startTime,
    required String endTime,
    bool? isFree,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         dayOfWeek: dayOfWeek,
         slotLabel: slotLabel,
         startTime: startTime,
         endTime: endTime,
         isFree: isFree,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentFreeSlot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudentFreeSlot copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? dayOfWeek,
    String? slotLabel,
    String? startTime,
    String? endTime,
    bool? isFree,
    DateTime? updatedAt,
  }) {
    return StudentFreeSlot(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      slotLabel: slotLabel ?? this.slotLabel,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isFree: isFree ?? this.isFree,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StudentFreeSlotUpdateTable extends _is.UpdateTable<StudentFreeSlotTable> {
  StudentFreeSlotUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> dayOfWeek(String value) => _is.ColumnValue(
    table.dayOfWeek,
    value,
  );

  _is.ColumnValue<String, String> slotLabel(String value) => _is.ColumnValue(
    table.slotLabel,
    value,
  );

  _is.ColumnValue<String, String> startTime(String value) => _is.ColumnValue(
    table.startTime,
    value,
  );

  _is.ColumnValue<String, String> endTime(String value) => _is.ColumnValue(
    table.endTime,
    value,
  );

  _is.ColumnValue<bool, bool> isFree(bool value) => _is.ColumnValue(
    table.isFree,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class StudentFreeSlotTable extends _is.Table<int?> {
  StudentFreeSlotTable({super.tableRelation})
    : super(tableName: 'student_free_slots') {
    updateTable = StudentFreeSlotUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    dayOfWeek = _is.ColumnString(
      'dayOfWeek',
      this,
    );
    slotLabel = _is.ColumnString(
      'slotLabel',
      this,
    );
    startTime = _is.ColumnString(
      'startTime',
      this,
    );
    endTime = _is.ColumnString(
      'endTime',
      this,
    );
    isFree = _is.ColumnBool(
      'isFree',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final StudentFreeSlotUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString dayOfWeek;

  late final _is.ColumnString slotLabel;

  late final _is.ColumnString startTime;

  late final _is.ColumnString endTime;

  late final _is.ColumnBool isFree;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    dayOfWeek,
    slotLabel,
    startTime,
    endTime,
    isFree,
    updatedAt,
  ];
}

class StudentFreeSlotInclude extends _is.IncludeObject {
  StudentFreeSlotInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StudentFreeSlot.t;
}

class StudentFreeSlotIncludeList extends _is.IncludeList {
  StudentFreeSlotIncludeList._({
    _is.WhereExpressionBuilder<StudentFreeSlotTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudentFreeSlot.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StudentFreeSlot.t;
}

class StudentFreeSlotRepository {
  const StudentFreeSlotRepository._();

  /// Returns a list of [StudentFreeSlot]s matching the given query parameters.
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
  Future<List<StudentFreeSlot>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentFreeSlotTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentFreeSlotTable>? orderBy,
    _is.OrderByListBuilder<StudentFreeSlotTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudentFreeSlot>(
      where: where?.call(StudentFreeSlot.t),
      orderBy: orderBy?.call(StudentFreeSlot.t),
      orderByList: orderByList?.call(StudentFreeSlot.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudentFreeSlot] matching the given query parameters.
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
  Future<StudentFreeSlot?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentFreeSlotTable>? where,
    int? offset,
    _is.OrderByBuilder<StudentFreeSlotTable>? orderBy,
    _is.OrderByListBuilder<StudentFreeSlotTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudentFreeSlot>(
      where: where?.call(StudentFreeSlot.t),
      orderBy: orderBy?.call(StudentFreeSlot.t),
      orderByList: orderByList?.call(StudentFreeSlot.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudentFreeSlot] by its [id] or null if no such row exists.
  Future<StudentFreeSlot?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudentFreeSlot>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudentFreeSlot]s in the list and returns the inserted rows.
  ///
  /// The returned [StudentFreeSlot]s will have their `id` fields set.
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
  Future<List<StudentFreeSlot>> insert(
    _is.DatabaseSession session,
    List<StudentFreeSlot> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StudentFreeSlot>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StudentFreeSlot] and returns the inserted row.
  ///
  /// The returned [StudentFreeSlot] will have its `id` field set.
  Future<StudentFreeSlot> insertRow(
    _is.DatabaseSession session,
    StudentFreeSlot row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudentFreeSlot>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StudentFreeSlot]s in the list and returns the resulting rows.
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
  /// The returned [StudentFreeSlot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudentFreeSlot>> upsert(
    _is.DatabaseSession session,
    List<StudentFreeSlot> rows, {
    required _is.ColumnSelections<StudentFreeSlotTable> conflictColumns,
    _is.ColumnSelections<StudentFreeSlotTable>? updateColumns,
    _is.WhereExpressionBuilder<StudentFreeSlotTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StudentFreeSlot>(
      rows,
      conflictColumns: conflictColumns(StudentFreeSlot.t),
      updateColumns: updateColumns?.call(StudentFreeSlot.t),
      updateWhere: updateWhere?.call(StudentFreeSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StudentFreeSlot] and returns the resulting row.
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
  /// The returned [StudentFreeSlot] will have its `id` field set.
  Future<StudentFreeSlot?> upsertRow(
    _is.DatabaseSession session,
    StudentFreeSlot row, {
    required _is.ColumnSelections<StudentFreeSlotTable> conflictColumns,
    _is.ColumnSelections<StudentFreeSlotTable>? updateColumns,
    _is.WhereExpressionBuilder<StudentFreeSlotTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StudentFreeSlot>(
      row,
      conflictColumns: conflictColumns(StudentFreeSlot.t),
      updateColumns: updateColumns?.call(StudentFreeSlot.t),
      updateWhere: updateWhere?.call(StudentFreeSlot.t),
      transaction: transaction,
    );
  }

  /// Updates all [StudentFreeSlot]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudentFreeSlot>> update(
    _is.DatabaseSession session,
    List<StudentFreeSlot> rows, {
    _is.ColumnSelections<StudentFreeSlotTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StudentFreeSlot>(
      rows,
      columns: columns?.call(StudentFreeSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StudentFreeSlot]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudentFreeSlot> updateRow(
    _is.DatabaseSession session,
    StudentFreeSlot row, {
    _is.ColumnSelections<StudentFreeSlotTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudentFreeSlot>(
      row,
      columns: columns?.call(StudentFreeSlot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudentFreeSlot] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudentFreeSlot?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StudentFreeSlotUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StudentFreeSlot>(
      id,
      columnValues: columnValues(StudentFreeSlot.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudentFreeSlot]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudentFreeSlot>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StudentFreeSlotUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<StudentFreeSlotTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentFreeSlotTable>? orderBy,
    _is.OrderByListBuilder<StudentFreeSlotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StudentFreeSlot>(
      columnValues: columnValues(StudentFreeSlot.t.updateTable),
      where: where(StudentFreeSlot.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentFreeSlot.t),
      orderByList: orderByList?.call(StudentFreeSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StudentFreeSlot]s in the list and returns the deleted rows.
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
  Future<List<StudentFreeSlot>> delete(
    _is.DatabaseSession session,
    List<StudentFreeSlot> rows, {
    _is.OrderByBuilder<StudentFreeSlotTable>? orderBy,
    _is.OrderByListBuilder<StudentFreeSlotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StudentFreeSlot>(
      rows,
      orderBy: orderBy?.call(StudentFreeSlot.t),
      orderByList: orderByList?.call(StudentFreeSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StudentFreeSlot].
  Future<StudentFreeSlot> deleteRow(
    _is.DatabaseSession session,
    StudentFreeSlot row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudentFreeSlot>(
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
  Future<List<StudentFreeSlot>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudentFreeSlotTable> where,
    _is.OrderByBuilder<StudentFreeSlotTable>? orderBy,
    _is.OrderByListBuilder<StudentFreeSlotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StudentFreeSlot>(
      where: where(StudentFreeSlot.t),
      orderBy: orderBy?.call(StudentFreeSlot.t),
      orderByList: orderByList?.call(StudentFreeSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentFreeSlotTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StudentFreeSlot>(
      where: where?.call(StudentFreeSlot.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudentFreeSlot] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudentFreeSlotTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudentFreeSlot>(
      where: where(StudentFreeSlot.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
