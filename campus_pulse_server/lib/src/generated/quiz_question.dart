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

abstract class QuizQuestion
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  QuizQuestion._({
    this.id,
    required this.subject,
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  factory QuizQuestion({
    int? id,
    required String subject,
    required String question,
    required List<String> options,
    required int correctIndex,
  }) = _QuizQuestionImpl;

  factory QuizQuestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizQuestion(
      id: jsonSerialization['id'] as int?,
      subject: jsonSerialization['subject'] as String,
      question: jsonSerialization['question'] as String,
      options: _i2t5n14n.Protocol()
          .deserialize<List<String>>(jsonSerialization['options']),
      correctIndex: jsonSerialization['correctIndex'] as int,
    );
  }

  static final t = QuizQuestionTable();

  static const db = QuizQuestionRepository._();

  @override
  int? id;

  String subject;

  String question;

  List<String> options;

  int correctIndex;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuizQuestion copyWith({
    int? id,
    String? subject,
    String? question,
    List<String>? options,
    int? correctIndex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizQuestion',
      if (id != null) 'id': id,
      'subject': subject,
      'question': question,
      'options': options.toJson(),
      'correctIndex': correctIndex,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizQuestion',
      if (id != null) 'id': id,
      'subject': subject,
      'question': question,
      'options': options.toJson(),
      'correctIndex': correctIndex,
    };
  }

  static QuizQuestionInclude include() {
    return QuizQuestionInclude._();
  }

  static QuizQuestionIncludeList includeList({
    _is.WhereExpressionBuilder<QuizQuestionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizQuestionTable>? orderBy,
    _is.OrderByListBuilder<QuizQuestionTable>? orderByList,
    QuizQuestionInclude? include,
  }) {
    return QuizQuestionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuizQuestion.t),
      orderByList: orderByList?.call(QuizQuestion.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizQuestionImpl extends QuizQuestion {
  _QuizQuestionImpl({
    int? id,
    required String subject,
    required String question,
    required List<String> options,
    required int correctIndex,
  }) : super._(
          id: id,
          subject: subject,
          question: question,
          options: options,
          correctIndex: correctIndex,
        );

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuizQuestion copyWith({
    Object? id = _Undefined,
    String? subject,
    String? question,
    List<String>? options,
    int? correctIndex,
  }) {
    return QuizQuestion(
      id: id is int? ? id : this.id,
      subject: subject ?? this.subject,
      question: question ?? this.question,
      options: options ?? this.options.map((e0) => e0).toList(),
      correctIndex: correctIndex ?? this.correctIndex,
    );
  }
}

class QuizQuestionUpdateTable extends _is.UpdateTable<QuizQuestionTable> {
  QuizQuestionUpdateTable(super.table);

  _is.ColumnValue<String, String> subject(String value) => _is.ColumnValue(
        table.subject,
        value,
      );

  _is.ColumnValue<String, String> question(String value) => _is.ColumnValue(
        table.question,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> options(List<String> value) =>
      _is.ColumnValue(
        table.options,
        value,
      );

  _is.ColumnValue<int, int> correctIndex(int value) => _is.ColumnValue(
        table.correctIndex,
        value,
      );
}

class QuizQuestionTable extends _is.Table<int?> {
  QuizQuestionTable({super.tableRelation}) : super(tableName: 'quiz_question') {
    updateTable = QuizQuestionUpdateTable(this);
    subject = _is.ColumnString(
      'subject',
      this,
    );
    question = _is.ColumnString(
      'question',
      this,
    );
    options = _is.ColumnSerializable<List<String>>(
      'options',
      this,
    );
    correctIndex = _is.ColumnInt(
      'correctIndex',
      this,
    );
  }

  late final QuizQuestionUpdateTable updateTable;

  late final _is.ColumnString subject;

  late final _is.ColumnString question;

  late final _is.ColumnSerializable<List<String>> options;

  late final _is.ColumnInt correctIndex;

  @override
  List<_is.Column> get columns => [
        id,
        subject,
        question,
        options,
        correctIndex,
      ];
}

class QuizQuestionInclude extends _is.IncludeObject {
  QuizQuestionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => QuizQuestion.t;
}

class QuizQuestionIncludeList extends _is.IncludeList {
  QuizQuestionIncludeList._({
    _is.WhereExpressionBuilder<QuizQuestionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuizQuestion.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => QuizQuestion.t;
}

class QuizQuestionRepository {
  const QuizQuestionRepository._();

  /// Returns a list of [QuizQuestion]s matching the given query parameters.
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
  Future<List<QuizQuestion>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizQuestionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizQuestionTable>? orderBy,
    _is.OrderByListBuilder<QuizQuestionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<QuizQuestion>(
      where: where?.call(QuizQuestion.t),
      orderBy: orderBy?.call(QuizQuestion.t),
      orderByList: orderByList?.call(QuizQuestion.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [QuizQuestion] matching the given query parameters.
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
  Future<QuizQuestion?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizQuestionTable>? where,
    int? offset,
    _is.OrderByBuilder<QuizQuestionTable>? orderBy,
    _is.OrderByListBuilder<QuizQuestionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<QuizQuestion>(
      where: where?.call(QuizQuestion.t),
      orderBy: orderBy?.call(QuizQuestion.t),
      orderByList: orderByList?.call(QuizQuestion.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [QuizQuestion] by its [id] or null if no such row exists.
  Future<QuizQuestion?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<QuizQuestion>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [QuizQuestion]s in the list and returns the inserted rows.
  ///
  /// The returned [QuizQuestion]s will have their `id` fields set.
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
  Future<List<QuizQuestion>> insert(
    _is.DatabaseSession session,
    List<QuizQuestion> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<QuizQuestion>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [QuizQuestion] and returns the inserted row.
  ///
  /// The returned [QuizQuestion] will have its `id` field set.
  Future<QuizQuestion> insertRow(
    _is.DatabaseSession session,
    QuizQuestion row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuizQuestion>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [QuizQuestion]s in the list and returns the resulting rows.
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
  /// The returned [QuizQuestion]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizQuestion>> upsert(
    _is.DatabaseSession session,
    List<QuizQuestion> rows, {
    required _is.ColumnSelections<QuizQuestionTable> conflictColumns,
    _is.ColumnSelections<QuizQuestionTable>? updateColumns,
    _is.WhereExpressionBuilder<QuizQuestionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<QuizQuestion>(
      rows,
      conflictColumns: conflictColumns(QuizQuestion.t),
      updateColumns: updateColumns?.call(QuizQuestion.t),
      updateWhere: updateWhere?.call(QuizQuestion.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [QuizQuestion] and returns the resulting row.
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
  /// The returned [QuizQuestion] will have its `id` field set.
  Future<QuizQuestion?> upsertRow(
    _is.DatabaseSession session,
    QuizQuestion row, {
    required _is.ColumnSelections<QuizQuestionTable> conflictColumns,
    _is.ColumnSelections<QuizQuestionTable>? updateColumns,
    _is.WhereExpressionBuilder<QuizQuestionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<QuizQuestion>(
      row,
      conflictColumns: conflictColumns(QuizQuestion.t),
      updateColumns: updateColumns?.call(QuizQuestion.t),
      updateWhere: updateWhere?.call(QuizQuestion.t),
      transaction: transaction,
    );
  }

  /// Updates all [QuizQuestion]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizQuestion>> update(
    _is.DatabaseSession session,
    List<QuizQuestion> rows, {
    _is.ColumnSelections<QuizQuestionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<QuizQuestion>(
      rows,
      columns: columns?.call(QuizQuestion.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [QuizQuestion]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuizQuestion> updateRow(
    _is.DatabaseSession session,
    QuizQuestion row, {
    _is.ColumnSelections<QuizQuestionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuizQuestion>(
      row,
      columns: columns?.call(QuizQuestion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuizQuestion] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<QuizQuestion?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<QuizQuestionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<QuizQuestion>(
      id,
      columnValues: columnValues(QuizQuestion.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [QuizQuestion]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<QuizQuestion>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<QuizQuestionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<QuizQuestionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuizQuestionTable>? orderBy,
    _is.OrderByListBuilder<QuizQuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<QuizQuestion>(
      columnValues: columnValues(QuizQuestion.t.updateTable),
      where: where(QuizQuestion.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuizQuestion.t),
      orderByList: orderByList?.call(QuizQuestion.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [QuizQuestion]s in the list and returns the deleted rows.
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
  Future<List<QuizQuestion>> delete(
    _is.DatabaseSession session,
    List<QuizQuestion> rows, {
    _is.OrderByBuilder<QuizQuestionTable>? orderBy,
    _is.OrderByListBuilder<QuizQuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<QuizQuestion>(
      rows,
      orderBy: orderBy?.call(QuizQuestion.t),
      orderByList: orderByList?.call(QuizQuestion.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [QuizQuestion].
  Future<QuizQuestion> deleteRow(
    _is.DatabaseSession session,
    QuizQuestion row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuizQuestion>(
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
  Future<List<QuizQuestion>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuizQuestionTable> where,
    _is.OrderByBuilder<QuizQuestionTable>? orderBy,
    _is.OrderByListBuilder<QuizQuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<QuizQuestion>(
      where: where(QuizQuestion.t),
      orderBy: orderBy?.call(QuizQuestion.t),
      orderByList: orderByList?.call(QuizQuestion.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuizQuestionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<QuizQuestion>(
      where: where?.call(QuizQuestion.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [QuizQuestion] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuizQuestionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<QuizQuestion>(
      where: where(QuizQuestion.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
