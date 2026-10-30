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

abstract class QuizAttempt
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  QuizAttempt._({
    this.id,
    this.attemptId,
    required this.authUserId,
    required this.studentName,
    required this.studentBranch,
    required this.subject,
    this.quizId,
    required this.score,
    required this.totalQuestions,
    required this.percentage,
    required this.durationSeconds,
    int? attemptNumber,
    bool? isRetake,
    DateTime? completedAt,
  }) : attemptNumber = attemptNumber ?? 1,
       isRetake = isRetake ?? false,
       completedAt = completedAt ?? DateTime.now();

  factory QuizAttempt({
    int? id,
    String? attemptId,
    required _is.UuidValue authUserId,
    required String studentName,
    required String studentBranch,
    required String subject,
    String? quizId,
    required int score,
    required int totalQuestions,
    required double percentage,
    required int durationSeconds,
    int? attemptNumber,
    bool? isRetake,
    DateTime? completedAt,
  }) = _QuizAttemptImpl;

  factory QuizAttempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizAttempt(
      id: jsonSerialization['id'] as int?,
      attemptId: jsonSerialization['attemptId'] as String?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      studentBranch: jsonSerialization['studentBranch'] as String,
      subject: jsonSerialization['subject'] as String,
      quizId: jsonSerialization['quizId'] as String?,
      score: jsonSerialization['score'] as int,
      totalQuestions: jsonSerialization['totalQuestions'] as int,
      percentage: (jsonSerialization['percentage'] as num).toDouble(),
      durationSeconds: jsonSerialization['durationSeconds'] as int,
      attemptNumber: jsonSerialization['attemptNumber'] as int?,
      isRetake: jsonSerialization['isRetake'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isRetake']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  static final t = QuizAttemptTable();

  static const db = QuizAttemptRepository._();

  @override
  int? id;

  String? attemptId;

  _is.UuidValue authUserId;

  String studentName;

  String studentBranch;

  String subject;

  String? quizId;

  int score;

  int totalQuestions;

  double percentage;

  int durationSeconds;

  int attemptNumber;

  bool isRetake;

  DateTime completedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuizAttempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuizAttempt copyWith({
    int? id,
    String? attemptId,
    _is.UuidValue? authUserId,
    String? studentName,
    String? studentBranch,
    String? subject,
    String? quizId,
    int? score,
    int? totalQuestions,
    double? percentage,
    int? durationSeconds,
    int? attemptNumber,
    bool? isRetake,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizAttempt',
      if (id != null) 'id': id,
      if (attemptId != null) 'attemptId': attemptId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'studentBranch': studentBranch,
      'subject': subject,
      if (quizId != null) 'quizId': quizId,
      'score': score,
      'totalQuestions': totalQuestions,
      'percentage': percentage,
      'durationSeconds': durationSeconds,
      'attemptNumber': attemptNumber,
      'isRetake': isRetake,
      'completedAt': completedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizAttempt',
      if (id != null) 'id': id,
      if (attemptId != null) 'attemptId': attemptId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'studentBranch': studentBranch,
      'subject': subject,
      if (quizId != null) 'quizId': quizId,
      'score': score,
      'totalQuestions': totalQuestions,
      'percentage': percentage,
      'durationSeconds': durationSeconds,
      'attemptNumber': attemptNumber,
      'isRetake': isRetake,
      'completedAt': completedAt.toJson(),
    };
  }

  static QuizAttemptInclude include() {
    return QuizAttemptInclude._();
  }

  static QuizAttemptIncludeList includeList({
    _is.WhereExpressionBuilder<QuizAttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    QuizAttemptInclude? include,
  }) {
    return QuizAttemptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizAttemptImpl extends QuizAttempt {
  _QuizAttemptImpl({
    int? id,
    String? attemptId,
    required _is.UuidValue authUserId,
    required String studentName,
    required String studentBranch,
    required String subject,
    String? quizId,
    required int score,
    required int totalQuestions,
    required double percentage,
    required int durationSeconds,
    int? attemptNumber,
    bool? isRetake,
    DateTime? completedAt,
  }) : super._(
         id: id,
         attemptId: attemptId,
         authUserId: authUserId,
         studentName: studentName,
         studentBranch: studentBranch,
         subject: subject,
         quizId: quizId,
         score: score,
         totalQuestions: totalQuestions,
         percentage: percentage,
         durationSeconds: durationSeconds,
         attemptNumber: attemptNumber,
         isRetake: isRetake,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [QuizAttempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuizAttempt copyWith({
    Object? id = _Undefined,
    Object? attemptId = _Undefined,
    _is.UuidValue? authUserId,
    String? studentName,
    String? studentBranch,
    String? subject,
    Object? quizId = _Undefined,
    int? score,
    int? totalQuestions,
    double? percentage,
    int? durationSeconds,
    int? attemptNumber,
    bool? isRetake,
    DateTime? completedAt,
  }) {
    return QuizAttempt(
      id: id is int? ? id : this.id,
      attemptId: attemptId is String? ? attemptId : this.attemptId,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      studentBranch: studentBranch ?? this.studentBranch,
      subject: subject ?? this.subject,
      quizId: quizId is String? ? quizId : this.quizId,
      score: score ?? this.score,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      percentage: percentage ?? this.percentage,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      isRetake: isRetake ?? this.isRetake,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

class QuizAttemptUpdateTable extends _is.UpdateTable<QuizAttemptTable> {
  QuizAttemptUpdateTable(super.table);

  _is.ColumnValue<String, String> attemptId(String? value) => _is.ColumnValue(
    table.attemptId,
    value,
  );

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

  _is.ColumnValue<String, String> studentBranch(String value) =>
      _is.ColumnValue(
        table.studentBranch,
        value,
      );

  _is.ColumnValue<String, String> subject(String value) => _is.ColumnValue(
    table.subject,
    value,
  );

  _is.ColumnValue<String, String> quizId(String? value) => _is.ColumnValue(
    table.quizId,
    value,
  );

  _is.ColumnValue<int, int> score(int value) => _is.ColumnValue(
    table.score,
    value,
  );

  _is.ColumnValue<int, int> totalQuestions(int value) => _is.ColumnValue(
    table.totalQuestions,
    value,
  );

  _is.ColumnValue<double, double> percentage(double value) => _is.ColumnValue(
    table.percentage,
    value,
  );

  _is.ColumnValue<int, int> durationSeconds(int value) => _is.ColumnValue(
    table.durationSeconds,
    value,
  );

  _is.ColumnValue<int, int> attemptNumber(int value) => _is.ColumnValue(
    table.attemptNumber,
    value,
  );

  _is.ColumnValue<bool, bool> isRetake(bool value) => _is.ColumnValue(
    table.isRetake,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );
}

class QuizAttemptTable extends _is.Table<int?> {
  QuizAttemptTable({super.tableRelation}) : super(tableName: 'quiz_attempt') {
    updateTable = QuizAttemptUpdateTable(this);
    attemptId = _is.ColumnString(
      'attemptId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    studentName = _is.ColumnString(
      'studentName',
      this,
    );
    studentBranch = _is.ColumnString(
      'studentBranch',
      this,
    );
    subject = _is.ColumnString(
      'subject',
      this,
    );
    quizId = _is.ColumnString(
      'quizId',
      this,
    );
    score = _is.ColumnInt(
      'score',
      this,
    );
    totalQuestions = _is.ColumnInt(
      'totalQuestions',
      this,
    );
    percentage = _is.ColumnDouble(
      'percentage',
      this,
    );
    durationSeconds = _is.ColumnInt(
      'durationSeconds',
      this,
    );
    attemptNumber = _is.ColumnInt(
      'attemptNumber',
      this,
      hasDefault: true,
    );
    isRetake = _is.ColumnBool(
      'isRetake',
      this,
      hasDefault: true,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
      hasDefault: true,
    );
  }

  late final QuizAttemptUpdateTable updateTable;

  late final _is.ColumnString attemptId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString studentName;

  late final _is.ColumnString studentBranch;

  late final _is.ColumnString subject;

  late final _is.ColumnString quizId;

  late final _is.ColumnInt score;

  late final _is.ColumnInt totalQuestions;

  late final _is.ColumnDouble percentage;

  late final _is.ColumnInt durationSeconds;

  late final _is.ColumnInt attemptNumber;

  late final _is.ColumnBool isRetake;

  late final _is.ColumnDateTime completedAt;

  @override
  List<_is.Column> get columns => [
    id,
    attemptId,
    authUserId,
    studentName,
    studentBranch,
    subject,
    quizId,
    score,
    totalQuestions,
    percentage,
    durationSeconds,
    attemptNumber,
    isRetake,
    completedAt,
  ];
}

class QuizAttemptInclude extends _is.IncludeObject {
  QuizAttemptInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => QuizAttempt.t;
}

class QuizAttemptIncludeList extends _is.IncludeList {
  QuizAttemptIncludeList._({
    _is.WhereExpressionBuilder<QuizAttemptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuizAttempt.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => QuizAttempt.t;
}

class QuizAttemptRepository {
  const QuizAttemptRepository._();

  /// Returns a list of [QuizAttempt]s matching the given query parameters.
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
  Future<List<QuizAttempt>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizAttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<QuizAttempt>(
      where: where?.call(QuizAttempt.t),
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [QuizAttempt] matching the given query parameters.
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
  Future<QuizAttempt?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizAttemptTable>? where,
    int? offset,
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<QuizAttempt>(
      where: where?.call(QuizAttempt.t),
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [QuizAttempt] by its [id] or null if no such row exists.
  Future<QuizAttempt?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<QuizAttempt>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [QuizAttempt]s in the list and returns the inserted rows.
  ///
  /// The returned [QuizAttempt]s will have their `id` fields set.
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
  Future<List<QuizAttempt>> insert(
    _is.DatabaseSession session,
    List<QuizAttempt> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<QuizAttempt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [QuizAttempt] and returns the inserted row.
  ///
  /// The returned [QuizAttempt] will have its `id` field set.
  Future<QuizAttempt> insertRow(
    _is.DatabaseSession session,
    QuizAttempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuizAttempt>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [QuizAttempt]s in the list and returns the resulting rows.
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
  /// The returned [QuizAttempt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizAttempt>> upsert(
    _is.DatabaseSession session,
    List<QuizAttempt> rows, {
    required _is.ColumnSelections<QuizAttemptTable> conflictColumns,
    _is.ColumnSelections<QuizAttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<QuizAttemptTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<QuizAttempt>(
      rows,
      conflictColumns: conflictColumns(QuizAttempt.t),
      updateColumns: updateColumns?.call(QuizAttempt.t),
      updateWhere: updateWhere?.call(QuizAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [QuizAttempt] and returns the resulting row.
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
  /// The returned [QuizAttempt] will have its `id` field set.
  Future<QuizAttempt?> upsertRow(
    _is.DatabaseSession session,
    QuizAttempt row, {
    required _is.ColumnSelections<QuizAttemptTable> conflictColumns,
    _is.ColumnSelections<QuizAttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<QuizAttemptTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<QuizAttempt>(
      row,
      conflictColumns: conflictColumns(QuizAttempt.t),
      updateColumns: updateColumns?.call(QuizAttempt.t),
      updateWhere: updateWhere?.call(QuizAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates all [QuizAttempt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizAttempt>> update(
    _is.DatabaseSession session,
    List<QuizAttempt> rows, {
    _is.ColumnSelections<QuizAttemptTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<QuizAttempt>(
      rows,
      columns: columns?.call(QuizAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [QuizAttempt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuizAttempt> updateRow(
    _is.DatabaseSession session,
    QuizAttempt row, {
    _is.ColumnSelections<QuizAttemptTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuizAttempt>(
      row,
      columns: columns?.call(QuizAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuizAttempt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<QuizAttempt?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<QuizAttemptUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<QuizAttempt>(
      id,
      columnValues: columnValues(QuizAttempt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [QuizAttempt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizAttempt>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<QuizAttemptUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<QuizAttemptTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<QuizAttempt>(
      columnValues: columnValues(QuizAttempt.t.updateTable),
      where: where(QuizAttempt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [QuizAttempt]s in the list and returns the deleted rows.
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
  Future<List<QuizAttempt>> delete(
    _is.DatabaseSession session,
    List<QuizAttempt> rows, {
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<QuizAttempt>(
      rows,
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [QuizAttempt].
  Future<QuizAttempt> deleteRow(
    _is.DatabaseSession session,
    QuizAttempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuizAttempt>(
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
  Future<List<QuizAttempt>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuizAttemptTable> where,
    _is.OrderByBuilder<QuizAttemptTable>? orderBy,
    _is.OrderByListBuilder<QuizAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<QuizAttempt>(
      where: where(QuizAttempt.t),
      orderBy: orderBy?.call(QuizAttempt.t),
      orderByList: orderByList?.call(QuizAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizAttemptTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<QuizAttempt>(
      where: where?.call(QuizAttempt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [QuizAttempt] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuizAttemptTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<QuizAttempt>(
      where: where(QuizAttempt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
