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

abstract class Student
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Student._({
    this.id,
    required this.name,
    required this.email,
    this.passwordHash,
    required this.branch,
    required this.year,
    required this.interests,
    required this.hostelArea,
  });

  factory Student({
    int? id,
    required String name,
    required String email,
    String? passwordHash,
    required String branch,
    required int year,
    required List<String> interests,
    required String hostelArea,
  }) = _StudentImpl;

  factory Student.fromJson(Map<String, dynamic> jsonSerialization) {
    return Student(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String?,
      branch: jsonSerialization['branch'] as String,
      year: jsonSerialization['year'] as int,
      interests: _i2t5n14n.Protocol()
          .deserialize<List<String>>(jsonSerialization['interests']),
      hostelArea: jsonSerialization['hostelArea'] as String,
    );
  }

  static final t = StudentTable();

  static const db = StudentRepository._();

  @override
  int? id;

  String name;

  String email;

  String? passwordHash;

  String branch;

  int year;

  List<String> interests;

  String hostelArea;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Student]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Student copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
    String? branch,
    int? year,
    List<String>? interests,
    String? hostelArea,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Student',
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      if (passwordHash != null) 'passwordHash': passwordHash,
      'branch': branch,
      'year': year,
      'interests': interests.toJson(),
      'hostelArea': hostelArea,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Student',
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      if (passwordHash != null) 'passwordHash': passwordHash,
      'branch': branch,
      'year': year,
      'interests': interests.toJson(),
      'hostelArea': hostelArea,
    };
  }

  static StudentInclude include() {
    return StudentInclude._();
  }

  static StudentIncludeList includeList({
    _is.WhereExpressionBuilder<StudentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentTable>? orderBy,
    _is.OrderByListBuilder<StudentTable>? orderByList,
    StudentInclude? include,
  }) {
    return StudentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Student.t),
      orderByList: orderByList?.call(Student.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentImpl extends Student {
  _StudentImpl({
    int? id,
    required String name,
    required String email,
    String? passwordHash,
    required String branch,
    required int year,
    required List<String> interests,
    required String hostelArea,
  }) : super._(
          id: id,
          name: name,
          email: email,
          passwordHash: passwordHash,
          branch: branch,
          year: year,
          interests: interests,
          hostelArea: hostelArea,
        );

  /// Returns a shallow copy of this [Student]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Student copyWith({
    Object? id = _Undefined,
    String? name,
    String? email,
    Object? passwordHash = _Undefined,
    String? branch,
    int? year,
    List<String>? interests,
    String? hostelArea,
  }) {
    return Student(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash is String? ? passwordHash : this.passwordHash,
      branch: branch ?? this.branch,
      year: year ?? this.year,
      interests: interests ?? this.interests.map((e0) => e0).toList(),
      hostelArea: hostelArea ?? this.hostelArea,
    );
  }
}

class StudentUpdateTable extends _is.UpdateTable<StudentTable> {
  StudentUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
        table.name,
        value,
      );

  _is.ColumnValue<String, String> email(String value) => _is.ColumnValue(
        table.email,
        value,
      );

  _is.ColumnValue<String, String> passwordHash(String? value) =>
      _is.ColumnValue(
        table.passwordHash,
        value,
      );

  _is.ColumnValue<String, String> branch(String value) => _is.ColumnValue(
        table.branch,
        value,
      );

  _is.ColumnValue<int, int> year(int value) => _is.ColumnValue(
        table.year,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> interests(List<String> value) =>
      _is.ColumnValue(
        table.interests,
        value,
      );

  _is.ColumnValue<String, String> hostelArea(String value) => _is.ColumnValue(
        table.hostelArea,
        value,
      );
}

class StudentTable extends _is.Table<int?> {
  StudentTable({super.tableRelation}) : super(tableName: 'student') {
    updateTable = StudentUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    email = _is.ColumnString(
      'email',
      this,
    );
    passwordHash = _is.ColumnString(
      'passwordHash',
      this,
    );
    branch = _is.ColumnString(
      'branch',
      this,
    );
    year = _is.ColumnInt(
      'year',
      this,
    );
    interests = _is.ColumnSerializable<List<String>>(
      'interests',
      this,
    );
    hostelArea = _is.ColumnString(
      'hostelArea',
      this,
    );
  }

  late final StudentUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString email;

  late final _is.ColumnString passwordHash;

  late final _is.ColumnString branch;

  late final _is.ColumnInt year;

  late final _is.ColumnSerializable<List<String>> interests;

  late final _is.ColumnString hostelArea;

  @override
  List<_is.Column> get columns => [
        id,
        name,
        email,
        passwordHash,
        branch,
        year,
        interests,
        hostelArea,
      ];
}

class StudentInclude extends _is.IncludeObject {
  StudentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Student.t;
}

class StudentIncludeList extends _is.IncludeList {
  StudentIncludeList._({
    _is.WhereExpressionBuilder<StudentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Student.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Student.t;
}

class StudentRepository {
  const StudentRepository._();

  /// Returns a list of [Student]s matching the given query parameters.
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
  Future<List<Student>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentTable>? orderBy,
    _is.OrderByListBuilder<StudentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Student>(
      where: where?.call(Student.t),
      orderBy: orderBy?.call(Student.t),
      orderByList: orderByList?.call(Student.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Student] matching the given query parameters.
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
  Future<Student?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentTable>? where,
    int? offset,
    _is.OrderByBuilder<StudentTable>? orderBy,
    _is.OrderByListBuilder<StudentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Student>(
      where: where?.call(Student.t),
      orderBy: orderBy?.call(Student.t),
      orderByList: orderByList?.call(Student.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Student] by its [id] or null if no such row exists.
  Future<Student?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Student>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Student]s in the list and returns the inserted rows.
  ///
  /// The returned [Student]s will have their `id` fields set.
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
  Future<List<Student>> insert(
    _is.DatabaseSession session,
    List<Student> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Student>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Student] and returns the inserted row.
  ///
  /// The returned [Student] will have its `id` field set.
  Future<Student> insertRow(
    _is.DatabaseSession session,
    Student row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Student>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Student]s in the list and returns the resulting rows.
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
  /// The returned [Student]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Student>> upsert(
    _is.DatabaseSession session,
    List<Student> rows, {
    required _is.ColumnSelections<StudentTable> conflictColumns,
    _is.ColumnSelections<StudentTable>? updateColumns,
    _is.WhereExpressionBuilder<StudentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Student>(
      rows,
      conflictColumns: conflictColumns(Student.t),
      updateColumns: updateColumns?.call(Student.t),
      updateWhere: updateWhere?.call(Student.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Student] and returns the resulting row.
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
  /// The returned [Student] will have its `id` field set.
  Future<Student?> upsertRow(
    _is.DatabaseSession session,
    Student row, {
    required _is.ColumnSelections<StudentTable> conflictColumns,
    _is.ColumnSelections<StudentTable>? updateColumns,
    _is.WhereExpressionBuilder<StudentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Student>(
      row,
      conflictColumns: conflictColumns(Student.t),
      updateColumns: updateColumns?.call(Student.t),
      updateWhere: updateWhere?.call(Student.t),
      transaction: transaction,
    );
  }

  /// Updates all [Student]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Student>> update(
    _is.DatabaseSession session,
    List<Student> rows, {
    _is.ColumnSelections<StudentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Student>(
      rows,
      columns: columns?.call(Student.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Student]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Student> updateRow(
    _is.DatabaseSession session,
    Student row, {
    _is.ColumnSelections<StudentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Student>(
      row,
      columns: columns?.call(Student.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Student] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Student?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StudentUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Student>(
      id,
      columnValues: columnValues(Student.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Student]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Student>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StudentUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StudentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentTable>? orderBy,
    _is.OrderByListBuilder<StudentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Student>(
      columnValues: columnValues(Student.t.updateTable),
      where: where(Student.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Student.t),
      orderByList: orderByList?.call(Student.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Student]s in the list and returns the deleted rows.
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
  Future<List<Student>> delete(
    _is.DatabaseSession session,
    List<Student> rows, {
    _is.OrderByBuilder<StudentTable>? orderBy,
    _is.OrderByListBuilder<StudentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Student>(
      rows,
      orderBy: orderBy?.call(Student.t),
      orderByList: orderByList?.call(Student.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Student].
  Future<Student> deleteRow(
    _is.DatabaseSession session,
    Student row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Student>(
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
  Future<List<Student>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudentTable> where,
    _is.OrderByBuilder<StudentTable>? orderBy,
    _is.OrderByListBuilder<StudentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Student>(
      where: where(Student.t),
      orderBy: orderBy?.call(Student.t),
      orderByList: orderByList?.call(Student.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Student>(
      where: where?.call(Student.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Student] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Student>(
      where: where(Student.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
