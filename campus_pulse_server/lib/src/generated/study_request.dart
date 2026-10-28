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

abstract class StudyRequest
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StudyRequest._({
    this.id,
    required this.studentId,
    this.studentName,
    this.branch,
    required this.subject,
    required this.location,
    String? status,
    required this.createdAt,
  }) : status = status ?? 'open';

  factory StudyRequest({
    int? id,
    required int studentId,
    String? studentName,
    String? branch,
    required String subject,
    required String location,
    String? status,
    required DateTime createdAt,
  }) = _StudyRequestImpl;

  factory StudyRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyRequest(
      id: jsonSerialization['id'] as int?,
      studentId: jsonSerialization['studentId'] as int,
      studentName: jsonSerialization['studentName'] as String?,
      branch: jsonSerialization['branch'] as String?,
      subject: jsonSerialization['subject'] as String,
      location: jsonSerialization['location'] as String,
      status: jsonSerialization['status'] as String?,
      createdAt:
          _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = StudyRequestTable();

  static const db = StudyRequestRepository._();

  @override
  int? id;

  int studentId;

  String? studentName;

  String? branch;

  String subject;

  String location;

  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudyRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudyRequest copyWith({
    int? id,
    int? studentId,
    String? studentName,
    String? branch,
    String? subject,
    String? location,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyRequest',
      if (id != null) 'id': id,
      'studentId': studentId,
      if (studentName != null) 'studentName': studentName,
      if (branch != null) 'branch': branch,
      'subject': subject,
      'location': location,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyRequest',
      if (id != null) 'id': id,
      'studentId': studentId,
      if (studentName != null) 'studentName': studentName,
      if (branch != null) 'branch': branch,
      'subject': subject,
      'location': location,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static StudyRequestInclude include() {
    return StudyRequestInclude._();
  }

  static StudyRequestIncludeList includeList({
    _is.WhereExpressionBuilder<StudyRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudyRequestTable>? orderBy,
    _is.OrderByListBuilder<StudyRequestTable>? orderByList,
    StudyRequestInclude? include,
  }) {
    return StudyRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyRequest.t),
      orderByList: orderByList?.call(StudyRequest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyRequestImpl extends StudyRequest {
  _StudyRequestImpl({
    int? id,
    required int studentId,
    String? studentName,
    String? branch,
    required String subject,
    required String location,
    String? status,
    required DateTime createdAt,
  }) : super._(
          id: id,
          studentId: studentId,
          studentName: studentName,
          branch: branch,
          subject: subject,
          location: location,
          status: status,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [StudyRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudyRequest copyWith({
    Object? id = _Undefined,
    int? studentId,
    Object? studentName = _Undefined,
    Object? branch = _Undefined,
    String? subject,
    String? location,
    String? status,
    DateTime? createdAt,
  }) {
    return StudyRequest(
      id: id is int? ? id : this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName is String? ? studentName : this.studentName,
      branch: branch is String? ? branch : this.branch,
      subject: subject ?? this.subject,
      location: location ?? this.location,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class StudyRequestUpdateTable extends _is.UpdateTable<StudyRequestTable> {
  StudyRequestUpdateTable(super.table);

  _is.ColumnValue<int, int> studentId(int value) => _is.ColumnValue(
        table.studentId,
        value,
      );

  _is.ColumnValue<String, String> studentName(String? value) => _is.ColumnValue(
        table.studentName,
        value,
      );

  _is.ColumnValue<String, String> branch(String? value) => _is.ColumnValue(
        table.branch,
        value,
      );

  _is.ColumnValue<String, String> subject(String value) => _is.ColumnValue(
        table.subject,
        value,
      );

  _is.ColumnValue<String, String> location(String value) => _is.ColumnValue(
        table.location,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
        table.status,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class StudyRequestTable extends _is.Table<int?> {
  StudyRequestTable({super.tableRelation}) : super(tableName: 'study_request') {
    updateTable = StudyRequestUpdateTable(this);
    studentId = _is.ColumnInt(
      'studentId',
      this,
    );
    studentName = _is.ColumnString(
      'studentName',
      this,
    );
    branch = _is.ColumnString(
      'branch',
      this,
    );
    subject = _is.ColumnString(
      'subject',
      this,
    );
    location = _is.ColumnString(
      'location',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final StudyRequestUpdateTable updateTable;

  late final _is.ColumnInt studentId;

  late final _is.ColumnString studentName;

  late final _is.ColumnString branch;

  late final _is.ColumnString subject;

  late final _is.ColumnString location;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
        id,
        studentId,
        studentName,
        branch,
        subject,
        location,
        status,
        createdAt,
      ];
}

class StudyRequestInclude extends _is.IncludeObject {
  StudyRequestInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StudyRequest.t;
}

class StudyRequestIncludeList extends _is.IncludeList {
  StudyRequestIncludeList._({
    _is.WhereExpressionBuilder<StudyRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudyRequest.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StudyRequest.t;
}

class StudyRequestRepository {
  const StudyRequestRepository._();

  /// Returns a list of [StudyRequest]s matching the given query parameters.
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
  Future<List<StudyRequest>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudyRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudyRequestTable>? orderBy,
    _is.OrderByListBuilder<StudyRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudyRequest>(
      where: where?.call(StudyRequest.t),
      orderBy: orderBy?.call(StudyRequest.t),
      orderByList: orderByList?.call(StudyRequest.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudyRequest] matching the given query parameters.
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
  Future<StudyRequest?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudyRequestTable>? where,
    int? offset,
    _is.OrderByBuilder<StudyRequestTable>? orderBy,
    _is.OrderByListBuilder<StudyRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudyRequest>(
      where: where?.call(StudyRequest.t),
      orderBy: orderBy?.call(StudyRequest.t),
      orderByList: orderByList?.call(StudyRequest.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudyRequest] by its [id] or null if no such row exists.
  Future<StudyRequest?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudyRequest>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudyRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [StudyRequest]s will have their `id` fields set.
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
  Future<List<StudyRequest>> insert(
    _is.DatabaseSession session,
    List<StudyRequest> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StudyRequest>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StudyRequest] and returns the inserted row.
  ///
  /// The returned [StudyRequest] will have its `id` field set.
  Future<StudyRequest> insertRow(
    _is.DatabaseSession session,
    StudyRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudyRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StudyRequest]s in the list and returns the resulting rows.
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
  /// The returned [StudyRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyRequest>> upsert(
    _is.DatabaseSession session,
    List<StudyRequest> rows, {
    required _is.ColumnSelections<StudyRequestTable> conflictColumns,
    _is.ColumnSelections<StudyRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<StudyRequestTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StudyRequest>(
      rows,
      conflictColumns: conflictColumns(StudyRequest.t),
      updateColumns: updateColumns?.call(StudyRequest.t),
      updateWhere: updateWhere?.call(StudyRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StudyRequest] and returns the resulting row.
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
  /// The returned [StudyRequest] will have its `id` field set.
  Future<StudyRequest?> upsertRow(
    _is.DatabaseSession session,
    StudyRequest row, {
    required _is.ColumnSelections<StudyRequestTable> conflictColumns,
    _is.ColumnSelections<StudyRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<StudyRequestTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StudyRequest>(
      row,
      conflictColumns: conflictColumns(StudyRequest.t),
      updateColumns: updateColumns?.call(StudyRequest.t),
      updateWhere: updateWhere?.call(StudyRequest.t),
      transaction: transaction,
    );
  }

  /// Updates all [StudyRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyRequest>> update(
    _is.DatabaseSession session,
    List<StudyRequest> rows, {
    _is.ColumnSelections<StudyRequestTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StudyRequest>(
      rows,
      columns: columns?.call(StudyRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StudyRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudyRequest> updateRow(
    _is.DatabaseSession session,
    StudyRequest row, {
    _is.ColumnSelections<StudyRequestTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudyRequest>(
      row,
      columns: columns?.call(StudyRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudyRequest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudyRequest?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StudyRequestUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StudyRequest>(
      id,
      columnValues: columnValues(StudyRequest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudyRequest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudyRequest>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StudyRequestUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StudyRequestTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudyRequestTable>? orderBy,
    _is.OrderByListBuilder<StudyRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StudyRequest>(
      columnValues: columnValues(StudyRequest.t.updateTable),
      where: where(StudyRequest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyRequest.t),
      orderByList: orderByList?.call(StudyRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StudyRequest]s in the list and returns the deleted rows.
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
  Future<List<StudyRequest>> delete(
    _is.DatabaseSession session,
    List<StudyRequest> rows, {
    _is.OrderByBuilder<StudyRequestTable>? orderBy,
    _is.OrderByListBuilder<StudyRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StudyRequest>(
      rows,
      orderBy: orderBy?.call(StudyRequest.t),
      orderByList: orderByList?.call(StudyRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StudyRequest].
  Future<StudyRequest> deleteRow(
    _is.DatabaseSession session,
    StudyRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudyRequest>(
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
  Future<List<StudyRequest>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudyRequestTable> where,
    _is.OrderByBuilder<StudyRequestTable>? orderBy,
    _is.OrderByListBuilder<StudyRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StudyRequest>(
      where: where(StudyRequest.t),
      orderBy: orderBy?.call(StudyRequest.t),
      orderByList: orderByList?.call(StudyRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudyRequestTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StudyRequest>(
      where: where?.call(StudyRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudyRequest] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudyRequestTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudyRequest>(
      where: where(StudyRequest.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
