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

abstract class QuizScore
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  QuizScore._({
    this.id,
    required this.studentId,
    required this.subject,
    required this.score,
    required this.createdAt,
  });

  factory QuizScore({
    int? id,
    required int studentId,
    required String subject,
    required int score,
    required DateTime createdAt,
  }) = _QuizScoreImpl;

  factory QuizScore.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizScore(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      subject: jsonSerialization['subject'] as String,
      score: jsonSerialization['score'] as int,
      createdAt:
          _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = QuizScoreTable();

  static const db = QuizScoreRepository._();

  @override
  int? id;

  int studentId;

  String subject;

  int score;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuizScore]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuizScore copyWith({
    int? id,
    int? studentId,
    String? subject,
    int? score,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizScore',
      if (id != null) 'id': id,
      'studentId': studentId,
      'subject': subject,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizScore',
      if (id != null) 'id': id,
      'studentId': studentId,
      'subject': subject,
      'score': score,
      'createdAt': createdAt.toJson(),
    };
  }

  static QuizScoreInclude include() {
    return QuizScoreInclude._();
  }

  static QuizScoreIncludeList includeList({
    _is.WhereExpressionBuilder<QuizScoreTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizScoreTable>? orderBy,
    _is.OrderByListBuilder<QuizScoreTable>? orderByList,
    QuizScoreInclude? include,
  }) {
    return QuizScoreIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuizScore.t),
      orderByList: orderByList?.call(QuizScore.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizScoreImpl extends QuizScore {
  _QuizScoreImpl({
    int? id,
    required int studentId,
    required String subject,
    required int score,
    required DateTime createdAt,
  }) : super._(
          id: id,
          studentId: studentId,
          subject: subject,
          score: score,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [QuizScore]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuizScore copyWith({
    Object? id = _Undefined,
    int? studentId,
    String? subject,
    int? score,
    DateTime? createdAt,
  }) {
    return QuizScore(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      subject: subject ?? this.subject,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class QuizScoreUpdateTable extends _is.UpdateTable<QuizScoreTable> {
  QuizScoreUpdateTable(super.table);

  _is.ColumnValue<int, int> studentId(int value) => _is.ColumnValue(
        table.studentId,
        value,
      );

  _is.ColumnValue<String, String> subject(String value) => _is.ColumnValue(
        table.subject,
        value,
      );

  _is.ColumnValue<int, int> score(int value) => _is.ColumnValue(
        table.score,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class QuizScoreTable extends _is.Table<int?> {
  QuizScoreTable({super.tableRelation}) : super(tableName: 'quiz_score') {
    updateTable = QuizScoreUpdateTable(this);
    studentId = _is.ColumnInt(
      'studentId',
      this,
    );
    subject = _is.ColumnString(
      'subject',
      this,
    );
    score = _is.ColumnInt(
      'score',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final QuizScoreUpdateTable updateTable;

  late final _is.ColumnInt studentId;

  late final _is.ColumnString subject;

  late final _is.ColumnInt score;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
        id,
        studentId,
        subject,
        score,
        createdAt,
      ];
}

class QuizScoreInclude extends _is.IncludeObject {
  QuizScoreInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => QuizScore.t;
}

class QuizScoreIncludeList extends _is.IncludeList {
  QuizScoreIncludeList._({
    _is.WhereExpressionBuilder<QuizScoreTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuizScore.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => QuizScore.t;
}

class QuizScoreRepository {
  const QuizScoreRepository._();

  /// Returns a list of [QuizScore]s matching the given query parameters.
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
  Future<List<QuizScore>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizScoreTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizScoreTable>? orderBy,
    _is.OrderByListBuilder<QuizScoreTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<QuizScore>(
      where: where?.call(QuizScore.t),
      orderBy: orderBy?.call(QuizScore.t),
      orderByList: orderByList?.call(QuizScore.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [QuizScore] matching the given query parameters.
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
  Future<QuizScore?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizScoreTable>? where,
    int? offset,
    _is.OrderByBuilder<QuizScoreTable>? orderBy,
    _is.OrderByListBuilder<QuizScoreTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<QuizScore>(
      where: where?.call(QuizScore.t),
      orderBy: orderBy?.call(QuizScore.t),
      orderByList: orderByList?.call(QuizScore.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [QuizScore] by its [id] or null if no such row exists.
  Future<QuizScore?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<QuizScore>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [QuizScore]s in the list and returns the inserted rows.
  ///
  /// The returned [QuizScore]s will have their `id` fields set.
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
  Future<List<QuizScore>> insert(
    _is.DatabaseSession session,
    List<QuizScore> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<QuizScore>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [QuizScore] and returns the inserted row.
  ///
  /// The returned [QuizScore] will have its `id` field set.
  Future<QuizScore> insertRow(
    _is.DatabaseSession session,
    QuizScore row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuizScore>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [QuizScore]s in the list and returns the resulting rows.
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
  /// The returned [QuizScore]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizScore>> upsert(
    _is.DatabaseSession session,
    List<QuizScore> rows, {
    required _is.ColumnSelections<QuizScoreTable> conflictColumns,
    _is.ColumnSelections<QuizScoreTable>? updateColumns,
    _is.WhereExpressionBuilder<QuizScoreTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<QuizScore>(
      rows,
      conflictColumns: conflictColumns(QuizScore.t),
      updateColumns: updateColumns?.call(QuizScore.t),
      updateWhere: updateWhere?.call(QuizScore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [QuizScore] and returns the resulting row.
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
  /// The returned [QuizScore] will have its `id` field set.
  Future<QuizScore?> upsertRow(
    _is.DatabaseSession session,
    QuizScore row, {
    required _is.ColumnSelections<QuizScoreTable> conflictColumns,
    _is.ColumnSelections<QuizScoreTable>? updateColumns,
    _is.WhereExpressionBuilder<QuizScoreTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<QuizScore>(
      row,
      conflictColumns: conflictColumns(QuizScore.t),
      updateColumns: updateColumns?.call(QuizScore.t),
      updateWhere: updateWhere?.call(QuizScore.t),
      transaction: transaction,
    );
  }

  /// Updates all [QuizScore]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizScore>> update(
    _is.DatabaseSession session,
    List<QuizScore> rows, {
    _is.ColumnSelections<QuizScoreTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<QuizScore>(
      rows,
      columns: columns?.call(QuizScore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [QuizScore]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuizScore> updateRow(
    _is.DatabaseSession session,
    QuizScore row, {
    _is.ColumnSelections<QuizScoreTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuizScore>(
      row,
      columns: columns?.call(QuizScore.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuizScore] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<QuizScore?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<QuizScoreUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<QuizScore>(
      id,
      columnValues: columnValues(QuizScore.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [QuizScore]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizScore>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<QuizScoreUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<QuizScoreTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizScoreTable>? orderBy,
    _is.OrderByListBuilder<QuizScoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<QuizScore>(
      columnValues: columnValues(QuizScore.t.updateTable),
      where: where(QuizScore.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuizScore.t),
      orderByList: orderByList?.call(QuizScore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [QuizScore]s in the list and returns the deleted rows.
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
  Future<List<QuizScore>> delete(
    _is.DatabaseSession session,
    List<QuizScore> rows, {
    _is.OrderByBuilder<QuizScoreTable>? orderBy,
    _is.OrderByListBuilder<QuizScoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<QuizScore>(
      rows,
      orderBy: orderBy?.call(QuizScore.t),
      orderByList: orderByList?.call(QuizScore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [QuizScore].
  Future<QuizScore> deleteRow(
    _is.DatabaseSession session,
    QuizScore row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuizScore>(
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
  Future<List<QuizScore>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuizScoreTable> where,
    _is.OrderByBuilder<QuizScoreTable>? orderBy,
    _is.OrderByListBuilder<QuizScoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<QuizScore>(
      where: where(QuizScore.t),
      orderBy: orderBy?.call(QuizScore.t),
      orderByList: orderByList?.call(QuizScore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizScoreTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<QuizScore>(
      where: where?.call(QuizScore.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [QuizScore] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuizScoreTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<QuizScore>(
      where: where(QuizScore.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
