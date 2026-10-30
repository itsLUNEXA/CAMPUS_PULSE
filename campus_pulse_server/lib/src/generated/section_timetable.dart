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

abstract class SectionTimetable
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SectionTimetable._({
    this.id,
    required this.branch,
    required this.academicYear,
    required this.semester,
    required this.section,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.room,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory SectionTimetable({
    int? id,
    required String branch,
    required int academicYear,
    required int semester,
    required String section,
    required String dayOfWeek,
    required String startTime,
    required String endTime,
    required String subject,
    required String room,
    DateTime? createdAt,
  }) = _SectionTimetableImpl;

  factory SectionTimetable.fromJson(Map<String, dynamic> jsonSerialization) {
    return SectionTimetable(
      id: jsonSerialization['id'] as int?,
      branch: jsonSerialization['branch'] as String,
      academicYear: jsonSerialization['academicYear'] as int,
      semester: jsonSerialization['semester'] as int,
      section: jsonSerialization['section'] as String,
      dayOfWeek: jsonSerialization['dayOfWeek'] as String,
      startTime: jsonSerialization['startTime'] as String,
      endTime: jsonSerialization['endTime'] as String,
      subject: jsonSerialization['subject'] as String,
      room: jsonSerialization['room'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = SectionTimetableTable();

  static const db = SectionTimetableRepository._();

  @override
  int? id;

  String branch;

  int academicYear;

  int semester;

  String section;

  String dayOfWeek;

  String startTime;

  String endTime;

  String subject;

  String room;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SectionTimetable]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SectionTimetable copyWith({
    int? id,
    String? branch,
    int? academicYear,
    int? semester,
    String? section,
    String? dayOfWeek,
    String? startTime,
    String? endTime,
    String? subject,
    String? room,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SectionTimetable',
      if (id != null) 'id': id,
      'branch': branch,
      'academicYear': academicYear,
      'semester': semester,
      'section': section,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'subject': subject,
      'room': room,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SectionTimetable',
      if (id != null) 'id': id,
      'branch': branch,
      'academicYear': academicYear,
      'semester': semester,
      'section': section,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'subject': subject,
      'room': room,
      'createdAt': createdAt.toJson(),
    };
  }

  static SectionTimetableInclude include() {
    return SectionTimetableInclude._();
  }

  static SectionTimetableIncludeList includeList({
    _is.WhereExpressionBuilder<SectionTimetableTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SectionTimetableTable>? orderBy,
    _is.OrderByListBuilder<SectionTimetableTable>? orderByList,
    SectionTimetableInclude? include,
  }) {
    return SectionTimetableIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SectionTimetable.t),
      orderByList: orderByList?.call(SectionTimetable.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SectionTimetableImpl extends SectionTimetable {
  _SectionTimetableImpl({
    int? id,
    required String branch,
    required int academicYear,
    required int semester,
    required String section,
    required String dayOfWeek,
    required String startTime,
    required String endTime,
    required String subject,
    required String room,
    DateTime? createdAt,
  }) : super._(
         id: id,
         branch: branch,
         academicYear: academicYear,
         semester: semester,
         section: section,
         dayOfWeek: dayOfWeek,
         startTime: startTime,
         endTime: endTime,
         subject: subject,
         room: room,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SectionTimetable]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SectionTimetable copyWith({
    Object? id = _Undefined,
    String? branch,
    int? academicYear,
    int? semester,
    String? section,
    String? dayOfWeek,
    String? startTime,
    String? endTime,
    String? subject,
    String? room,
    DateTime? createdAt,
  }) {
    return SectionTimetable(
      id: id is int? ? id : this.id,
      branch: branch ?? this.branch,
      academicYear: academicYear ?? this.academicYear,
      semester: semester ?? this.semester,
      section: section ?? this.section,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      subject: subject ?? this.subject,
      room: room ?? this.room,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SectionTimetableUpdateTable
    extends _is.UpdateTable<SectionTimetableTable> {
  SectionTimetableUpdateTable(super.table);

  _is.ColumnValue<String, String> branch(String value) => _is.ColumnValue(
    table.branch,
    value,
  );

  _is.ColumnValue<int, int> academicYear(int value) => _is.ColumnValue(
    table.academicYear,
    value,
  );

  _is.ColumnValue<int, int> semester(int value) => _is.ColumnValue(
    table.semester,
    value,
  );

  _is.ColumnValue<String, String> section(String value) => _is.ColumnValue(
    table.section,
    value,
  );

  _is.ColumnValue<String, String> dayOfWeek(String value) => _is.ColumnValue(
    table.dayOfWeek,
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

  _is.ColumnValue<String, String> subject(String value) => _is.ColumnValue(
    table.subject,
    value,
  );

  _is.ColumnValue<String, String> room(String value) => _is.ColumnValue(
    table.room,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class SectionTimetableTable extends _is.Table<int?> {
  SectionTimetableTable({super.tableRelation})
    : super(tableName: 'section_timetables') {
    updateTable = SectionTimetableUpdateTable(this);
    branch = _is.ColumnString(
      'branch',
      this,
    );
    academicYear = _is.ColumnInt(
      'academicYear',
      this,
    );
    semester = _is.ColumnInt(
      'semester',
      this,
    );
    section = _is.ColumnString(
      'section',
      this,
    );
    dayOfWeek = _is.ColumnString(
      'dayOfWeek',
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
    subject = _is.ColumnString(
      'subject',
      this,
    );
    room = _is.ColumnString(
      'room',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final SectionTimetableUpdateTable updateTable;

  late final _is.ColumnString branch;

  late final _is.ColumnInt academicYear;

  late final _is.ColumnInt semester;

  late final _is.ColumnString section;

  late final _is.ColumnString dayOfWeek;

  late final _is.ColumnString startTime;

  late final _is.ColumnString endTime;

  late final _is.ColumnString subject;

  late final _is.ColumnString room;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    branch,
    academicYear,
    semester,
    section,
    dayOfWeek,
    startTime,
    endTime,
    subject,
    room,
    createdAt,
  ];
}

class SectionTimetableInclude extends _is.IncludeObject {
  SectionTimetableInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SectionTimetable.t;
}

class SectionTimetableIncludeList extends _is.IncludeList {
  SectionTimetableIncludeList._({
    _is.WhereExpressionBuilder<SectionTimetableTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SectionTimetable.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SectionTimetable.t;
}

class SectionTimetableRepository {
  const SectionTimetableRepository._();

  /// Returns a list of [SectionTimetable]s matching the given query parameters.
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
  Future<List<SectionTimetable>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SectionTimetableTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SectionTimetableTable>? orderBy,
    _is.OrderByListBuilder<SectionTimetableTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SectionTimetable>(
      where: where?.call(SectionTimetable.t),
      orderBy: orderBy?.call(SectionTimetable.t),
      orderByList: orderByList?.call(SectionTimetable.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SectionTimetable] matching the given query parameters.
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
  Future<SectionTimetable?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SectionTimetableTable>? where,
    int? offset,
    _is.OrderByBuilder<SectionTimetableTable>? orderBy,
    _is.OrderByListBuilder<SectionTimetableTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SectionTimetable>(
      where: where?.call(SectionTimetable.t),
      orderBy: orderBy?.call(SectionTimetable.t),
      orderByList: orderByList?.call(SectionTimetable.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SectionTimetable] by its [id] or null if no such row exists.
  Future<SectionTimetable?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SectionTimetable>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SectionTimetable]s in the list and returns the inserted rows.
  ///
  /// The returned [SectionTimetable]s will have their `id` fields set.
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
  Future<List<SectionTimetable>> insert(
    _is.DatabaseSession session,
    List<SectionTimetable> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SectionTimetable>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SectionTimetable] and returns the inserted row.
  ///
  /// The returned [SectionTimetable] will have its `id` field set.
  Future<SectionTimetable> insertRow(
    _is.DatabaseSession session,
    SectionTimetable row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SectionTimetable>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SectionTimetable]s in the list and returns the resulting rows.
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
  /// The returned [SectionTimetable]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SectionTimetable>> upsert(
    _is.DatabaseSession session,
    List<SectionTimetable> rows, {
    required _is.ColumnSelections<SectionTimetableTable> conflictColumns,
    _is.ColumnSelections<SectionTimetableTable>? updateColumns,
    _is.WhereExpressionBuilder<SectionTimetableTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SectionTimetable>(
      rows,
      conflictColumns: conflictColumns(SectionTimetable.t),
      updateColumns: updateColumns?.call(SectionTimetable.t),
      updateWhere: updateWhere?.call(SectionTimetable.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SectionTimetable] and returns the resulting row.
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
  /// The returned [SectionTimetable] will have its `id` field set.
  Future<SectionTimetable?> upsertRow(
    _is.DatabaseSession session,
    SectionTimetable row, {
    required _is.ColumnSelections<SectionTimetableTable> conflictColumns,
    _is.ColumnSelections<SectionTimetableTable>? updateColumns,
    _is.WhereExpressionBuilder<SectionTimetableTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SectionTimetable>(
      row,
      conflictColumns: conflictColumns(SectionTimetable.t),
      updateColumns: updateColumns?.call(SectionTimetable.t),
      updateWhere: updateWhere?.call(SectionTimetable.t),
      transaction: transaction,
    );
  }

  /// Updates all [SectionTimetable]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SectionTimetable>> update(
    _is.DatabaseSession session,
    List<SectionTimetable> rows, {
    _is.ColumnSelections<SectionTimetableTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SectionTimetable>(
      rows,
      columns: columns?.call(SectionTimetable.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SectionTimetable]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SectionTimetable> updateRow(
    _is.DatabaseSession session,
    SectionTimetable row, {
    _is.ColumnSelections<SectionTimetableTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SectionTimetable>(
      row,
      columns: columns?.call(SectionTimetable.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SectionTimetable] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SectionTimetable?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SectionTimetableUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SectionTimetable>(
      id,
      columnValues: columnValues(SectionTimetable.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SectionTimetable]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SectionTimetable>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SectionTimetableUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SectionTimetableTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SectionTimetableTable>? orderBy,
    _is.OrderByListBuilder<SectionTimetableTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SectionTimetable>(
      columnValues: columnValues(SectionTimetable.t.updateTable),
      where: where(SectionTimetable.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SectionTimetable.t),
      orderByList: orderByList?.call(SectionTimetable.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SectionTimetable]s in the list and returns the deleted rows.
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
  Future<List<SectionTimetable>> delete(
    _is.DatabaseSession session,
    List<SectionTimetable> rows, {
    _is.OrderByBuilder<SectionTimetableTable>? orderBy,
    _is.OrderByListBuilder<SectionTimetableTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SectionTimetable>(
      rows,
      orderBy: orderBy?.call(SectionTimetable.t),
      orderByList: orderByList?.call(SectionTimetable.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SectionTimetable].
  Future<SectionTimetable> deleteRow(
    _is.DatabaseSession session,
    SectionTimetable row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SectionTimetable>(
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
  Future<List<SectionTimetable>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SectionTimetableTable> where,
    _is.OrderByBuilder<SectionTimetableTable>? orderBy,
    _is.OrderByListBuilder<SectionTimetableTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SectionTimetable>(
      where: where(SectionTimetable.t),
      orderBy: orderBy?.call(SectionTimetable.t),
      orderByList: orderByList?.call(SectionTimetable.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SectionTimetableTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SectionTimetable>(
      where: where?.call(SectionTimetable.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SectionTimetable] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SectionTimetableTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SectionTimetable>(
      where: where(SectionTimetable.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
