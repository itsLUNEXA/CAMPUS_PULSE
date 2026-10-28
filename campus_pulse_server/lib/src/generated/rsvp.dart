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

abstract class Rsvp implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Rsvp._({
    this.id,
    required this.studentId,
    required this.eventId,
  });

  factory Rsvp({
    int? id,
    required int studentId,
    required int eventId,
  }) = _RsvpImpl;

  factory Rsvp.fromJson(Map<String, dynamic> jsonSerialization) {
    return Rsvp(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      eventId: jsonSerialization['eventId'] as int,
    );
  }

  static final t = RsvpTable();

  static const db = RsvpRepository._();

  @override
  int? id;

  int studentId;

  int eventId;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Rsvp]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Rsvp copyWith({
    int? id,
    int? studentId,
    int? eventId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Rsvp',
      if (id != null) 'id': id,
      'studentId': studentId,
      'eventId': eventId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Rsvp',
      if (id != null) 'id': id,
      'studentId': studentId,
      'eventId': eventId,
    };
  }

  static RsvpInclude include() {
    return RsvpInclude._();
  }

  static RsvpIncludeList includeList({
    _is.WhereExpressionBuilder<RsvpTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RsvpTable>? orderBy,
    _is.OrderByListBuilder<RsvpTable>? orderByList,
    RsvpInclude? include,
  }) {
    return RsvpIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Rsvp.t),
      orderByList: orderByList?.call(Rsvp.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RsvpImpl extends Rsvp {
  _RsvpImpl({
    int? id,
    required int studentId,
    required int eventId,
  }) : super._(
          id: id,
          studentId: studentId,
          eventId: eventId,
        );

  /// Returns a shallow copy of this [Rsvp]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Rsvp copyWith({
    Object? id = _Undefined,
    int? studentId,
    int? eventId,
  }) {
    return Rsvp(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      eventId: eventId ?? this.eventId,
    );
  }
}

class RsvpUpdateTable extends _is.UpdateTable<RsvpTable> {
  RsvpUpdateTable(super.table);

  _is.ColumnValue<int, int> studentId(int value) => _is.ColumnValue(
        table.studentId,
        value,
      );

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
        table.eventId,
        value,
      );
}

class RsvpTable extends _is.Table<int?> {
  RsvpTable({super.tableRelation}) : super(tableName: 'rsvp') {
    updateTable = RsvpUpdateTable(this);
    studentId = _is.ColumnInt(
      'studentId',
      this,
    );
    eventId = _is.ColumnInt(
      'eventId',
      this,
    );
  }

  late final RsvpUpdateTable updateTable;

  late final _is.ColumnInt studentId;

  late final _is.ColumnInt eventId;

  @override
  List<_is.Column> get columns => [
        id,
        studentId,
        eventId,
      ];
}

class RsvpInclude extends _is.IncludeObject {
  RsvpInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Rsvp.t;
}

class RsvpIncludeList extends _is.IncludeList {
  RsvpIncludeList._({
    _is.WhereExpressionBuilder<RsvpTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Rsvp.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Rsvp.t;
}

class RsvpRepository {
  const RsvpRepository._();

  /// Returns a list of [Rsvp]s matching the given query parameters.
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
  Future<List<Rsvp>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RsvpTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RsvpTable>? orderBy,
    _is.OrderByListBuilder<RsvpTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Rsvp>(
      where: where?.call(Rsvp.t),
      orderBy: orderBy?.call(Rsvp.t),
      orderByList: orderByList?.call(Rsvp.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Rsvp] matching the given query parameters.
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
  Future<Rsvp?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RsvpTable>? where,
    int? offset,
    _is.OrderByBuilder<RsvpTable>? orderBy,
    _is.OrderByListBuilder<RsvpTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Rsvp>(
      where: where?.call(Rsvp.t),
      orderBy: orderBy?.call(Rsvp.t),
      orderByList: orderByList?.call(Rsvp.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Rsvp] by its [id] or null if no such row exists.
  Future<Rsvp?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Rsvp>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Rsvp]s in the list and returns the inserted rows.
  ///
  /// The returned [Rsvp]s will have their `id` fields set.
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
  Future<List<Rsvp>> insert(
    _is.DatabaseSession session,
    List<Rsvp> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Rsvp>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Rsvp] and returns the inserted row.
  ///
  /// The returned [Rsvp] will have its `id` field set.
  Future<Rsvp> insertRow(
    _is.DatabaseSession session,
    Rsvp row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Rsvp>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Rsvp]s in the list and returns the resulting rows.
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
  /// The returned [Rsvp]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Rsvp>> upsert(
    _is.DatabaseSession session,
    List<Rsvp> rows, {
    required _is.ColumnSelections<RsvpTable> conflictColumns,
    _is.ColumnSelections<RsvpTable>? updateColumns,
    _is.WhereExpressionBuilder<RsvpTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Rsvp>(
      rows,
      conflictColumns: conflictColumns(Rsvp.t),
      updateColumns: updateColumns?.call(Rsvp.t),
      updateWhere: updateWhere?.call(Rsvp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Rsvp] and returns the resulting row.
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
  /// The returned [Rsvp] will have its `id` field set.
  Future<Rsvp?> upsertRow(
    _is.DatabaseSession session,
    Rsvp row, {
    required _is.ColumnSelections<RsvpTable> conflictColumns,
    _is.ColumnSelections<RsvpTable>? updateColumns,
    _is.WhereExpressionBuilder<RsvpTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Rsvp>(
      row,
      conflictColumns: conflictColumns(Rsvp.t),
      updateColumns: updateColumns?.call(Rsvp.t),
      updateWhere: updateWhere?.call(Rsvp.t),
      transaction: transaction,
    );
  }

  /// Updates all [Rsvp]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Rsvp>> update(
    _is.DatabaseSession session,
    List<Rsvp> rows, {
    _is.ColumnSelections<RsvpTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Rsvp>(
      rows,
      columns: columns?.call(Rsvp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Rsvp]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Rsvp> updateRow(
    _is.DatabaseSession session,
    Rsvp row, {
    _is.ColumnSelections<RsvpTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Rsvp>(
      row,
      columns: columns?.call(Rsvp.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Rsvp] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Rsvp?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RsvpUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Rsvp>(
      id,
      columnValues: columnValues(Rsvp.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Rsvp]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Rsvp>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RsvpUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RsvpTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RsvpTable>? orderBy,
    _is.OrderByListBuilder<RsvpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Rsvp>(
      columnValues: columnValues(Rsvp.t.updateTable),
      where: where(Rsvp.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Rsvp.t),
      orderByList: orderByList?.call(Rsvp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Rsvp]s in the list and returns the deleted rows.
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
  Future<List<Rsvp>> delete(
    _is.DatabaseSession session,
    List<Rsvp> rows, {
    _is.OrderByBuilder<RsvpTable>? orderBy,
    _is.OrderByListBuilder<RsvpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Rsvp>(
      rows,
      orderBy: orderBy?.call(Rsvp.t),
      orderByList: orderByList?.call(Rsvp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Rsvp].
  Future<Rsvp> deleteRow(
    _is.DatabaseSession session,
    Rsvp row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Rsvp>(
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
  Future<List<Rsvp>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RsvpTable> where,
    _is.OrderByBuilder<RsvpTable>? orderBy,
    _is.OrderByListBuilder<RsvpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Rsvp>(
      where: where(Rsvp.t),
      orderBy: orderBy?.call(Rsvp.t),
      orderByList: orderByList?.call(Rsvp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RsvpTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Rsvp>(
      where: where?.call(Rsvp.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Rsvp] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RsvpTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Rsvp>(
      where: where(Rsvp.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
