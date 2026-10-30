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

abstract class SyllabusNode
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SyllabusNode._({
    this.id,
    required this.university,
    required this.course,
    required this.branch,
    required this.semester,
    required this.subjectCode,
    required this.subjectName,
    required this.unitNumber,
    required this.unitTitle,
    required this.topics,
    required this.academicYear,
    required this.version,
  });

  factory SyllabusNode({
    int? id,
    required String university,
    required String course,
    required String branch,
    required int semester,
    required String subjectCode,
    required String subjectName,
    required int unitNumber,
    required String unitTitle,
    required List<String> topics,
    required int academicYear,
    required String version,
  }) = _SyllabusNodeImpl;

  factory SyllabusNode.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyllabusNode(
      id: jsonSerialization['id'] as int?,
      university: jsonSerialization['university'] as String,
      course: jsonSerialization['course'] as String,
      branch: jsonSerialization['branch'] as String,
      semester: jsonSerialization['semester'] as int,
      subjectCode: jsonSerialization['subjectCode'] as String,
      subjectName: jsonSerialization['subjectName'] as String,
      unitNumber: jsonSerialization['unitNumber'] as int,
      unitTitle: jsonSerialization['unitTitle'] as String,
      topics: _i2t5n14n.Protocol().deserialize<List<String>>(
        jsonSerialization['topics'],
      ),
      academicYear: jsonSerialization['academicYear'] as int,
      version: jsonSerialization['version'] as String,
    );
  }

  static final t = SyllabusNodeTable();

  static const db = SyllabusNodeRepository._();

  @override
  int? id;

  String university;

  String course;

  String branch;

  int semester;

  String subjectCode;

  String subjectName;

  int unitNumber;

  String unitTitle;

  List<String> topics;

  int academicYear;

  String version;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SyllabusNode]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyllabusNode copyWith({
    int? id,
    String? university,
    String? course,
    String? branch,
    int? semester,
    String? subjectCode,
    String? subjectName,
    int? unitNumber,
    String? unitTitle,
    List<String>? topics,
    int? academicYear,
    String? version,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyllabusNode',
      if (id != null) 'id': id,
      'university': university,
      'course': course,
      'branch': branch,
      'semester': semester,
      'subjectCode': subjectCode,
      'subjectName': subjectName,
      'unitNumber': unitNumber,
      'unitTitle': unitTitle,
      'topics': topics.toJson(),
      'academicYear': academicYear,
      'version': version,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyllabusNode',
      if (id != null) 'id': id,
      'university': university,
      'course': course,
      'branch': branch,
      'semester': semester,
      'subjectCode': subjectCode,
      'subjectName': subjectName,
      'unitNumber': unitNumber,
      'unitTitle': unitTitle,
      'topics': topics.toJson(),
      'academicYear': academicYear,
      'version': version,
    };
  }

  static SyllabusNodeInclude include() {
    return SyllabusNodeInclude._();
  }

  static SyllabusNodeIncludeList includeList({
    _is.WhereExpressionBuilder<SyllabusNodeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyllabusNodeTable>? orderBy,
    _is.OrderByListBuilder<SyllabusNodeTable>? orderByList,
    SyllabusNodeInclude? include,
  }) {
    return SyllabusNodeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyllabusNode.t),
      orderByList: orderByList?.call(SyllabusNode.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyllabusNodeImpl extends SyllabusNode {
  _SyllabusNodeImpl({
    int? id,
    required String university,
    required String course,
    required String branch,
    required int semester,
    required String subjectCode,
    required String subjectName,
    required int unitNumber,
    required String unitTitle,
    required List<String> topics,
    required int academicYear,
    required String version,
  }) : super._(
         id: id,
         university: university,
         course: course,
         branch: branch,
         semester: semester,
         subjectCode: subjectCode,
         subjectName: subjectName,
         unitNumber: unitNumber,
         unitTitle: unitTitle,
         topics: topics,
         academicYear: academicYear,
         version: version,
       );

  /// Returns a shallow copy of this [SyllabusNode]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyllabusNode copyWith({
    Object? id = _Undefined,
    String? university,
    String? course,
    String? branch,
    int? semester,
    String? subjectCode,
    String? subjectName,
    int? unitNumber,
    String? unitTitle,
    List<String>? topics,
    int? academicYear,
    String? version,
  }) {
    return SyllabusNode(
      id: id is int? ? id : this.id,
      university: university ?? this.university,
      course: course ?? this.course,
      branch: branch ?? this.branch,
      semester: semester ?? this.semester,
      subjectCode: subjectCode ?? this.subjectCode,
      subjectName: subjectName ?? this.subjectName,
      unitNumber: unitNumber ?? this.unitNumber,
      unitTitle: unitTitle ?? this.unitTitle,
      topics: topics ?? this.topics.map((e0) => e0).toList(),
      academicYear: academicYear ?? this.academicYear,
      version: version ?? this.version,
    );
  }
}

class SyllabusNodeUpdateTable extends _is.UpdateTable<SyllabusNodeTable> {
  SyllabusNodeUpdateTable(super.table);

  _is.ColumnValue<String, String> university(String value) => _is.ColumnValue(
    table.university,
    value,
  );

  _is.ColumnValue<String, String> course(String value) => _is.ColumnValue(
    table.course,
    value,
  );

  _is.ColumnValue<String, String> branch(String value) => _is.ColumnValue(
    table.branch,
    value,
  );

  _is.ColumnValue<int, int> semester(int value) => _is.ColumnValue(
    table.semester,
    value,
  );

  _is.ColumnValue<String, String> subjectCode(String value) => _is.ColumnValue(
    table.subjectCode,
    value,
  );

  _is.ColumnValue<String, String> subjectName(String value) => _is.ColumnValue(
    table.subjectName,
    value,
  );

  _is.ColumnValue<int, int> unitNumber(int value) => _is.ColumnValue(
    table.unitNumber,
    value,
  );

  _is.ColumnValue<String, String> unitTitle(String value) => _is.ColumnValue(
    table.unitTitle,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> topics(List<String> value) =>
      _is.ColumnValue(
        table.topics,
        value,
      );

  _is.ColumnValue<int, int> academicYear(int value) => _is.ColumnValue(
    table.academicYear,
    value,
  );

  _is.ColumnValue<String, String> version(String value) => _is.ColumnValue(
    table.version,
    value,
  );
}

class SyllabusNodeTable extends _is.Table<int?> {
  SyllabusNodeTable({super.tableRelation}) : super(tableName: 'syllabus_node') {
    updateTable = SyllabusNodeUpdateTable(this);
    university = _is.ColumnString(
      'university',
      this,
    );
    course = _is.ColumnString(
      'course',
      this,
    );
    branch = _is.ColumnString(
      'branch',
      this,
    );
    semester = _is.ColumnInt(
      'semester',
      this,
    );
    subjectCode = _is.ColumnString(
      'subjectCode',
      this,
    );
    subjectName = _is.ColumnString(
      'subjectName',
      this,
    );
    unitNumber = _is.ColumnInt(
      'unitNumber',
      this,
    );
    unitTitle = _is.ColumnString(
      'unitTitle',
      this,
    );
    topics = _is.ColumnSerializable<List<String>>(
      'topics',
      this,
    );
    academicYear = _is.ColumnInt(
      'academicYear',
      this,
    );
    version = _is.ColumnString(
      'version',
      this,
    );
  }

  late final SyllabusNodeUpdateTable updateTable;

  late final _is.ColumnString university;

  late final _is.ColumnString course;

  late final _is.ColumnString branch;

  late final _is.ColumnInt semester;

  late final _is.ColumnString subjectCode;

  late final _is.ColumnString subjectName;

  late final _is.ColumnInt unitNumber;

  late final _is.ColumnString unitTitle;

  late final _is.ColumnSerializable<List<String>> topics;

  late final _is.ColumnInt academicYear;

  late final _is.ColumnString version;

  @override
  List<_is.Column> get columns => [
    id,
    university,
    course,
    branch,
    semester,
    subjectCode,
    subjectName,
    unitNumber,
    unitTitle,
    topics,
    academicYear,
    version,
  ];
}

class SyllabusNodeInclude extends _is.IncludeObject {
  SyllabusNodeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SyllabusNode.t;
}

class SyllabusNodeIncludeList extends _is.IncludeList {
  SyllabusNodeIncludeList._({
    _is.WhereExpressionBuilder<SyllabusNodeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SyllabusNode.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SyllabusNode.t;
}

class SyllabusNodeRepository {
  const SyllabusNodeRepository._();

  /// Returns a list of [SyllabusNode]s matching the given query parameters.
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
  Future<List<SyllabusNode>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyllabusNodeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyllabusNodeTable>? orderBy,
    _is.OrderByListBuilder<SyllabusNodeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SyllabusNode>(
      where: where?.call(SyllabusNode.t),
      orderBy: orderBy?.call(SyllabusNode.t),
      orderByList: orderByList?.call(SyllabusNode.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SyllabusNode] matching the given query parameters.
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
  Future<SyllabusNode?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyllabusNodeTable>? where,
    int? offset,
    _is.OrderByBuilder<SyllabusNodeTable>? orderBy,
    _is.OrderByListBuilder<SyllabusNodeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SyllabusNode>(
      where: where?.call(SyllabusNode.t),
      orderBy: orderBy?.call(SyllabusNode.t),
      orderByList: orderByList?.call(SyllabusNode.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SyllabusNode] by its [id] or null if no such row exists.
  Future<SyllabusNode?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SyllabusNode>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SyllabusNode]s in the list and returns the inserted rows.
  ///
  /// The returned [SyllabusNode]s will have their `id` fields set.
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
  Future<List<SyllabusNode>> insert(
    _is.DatabaseSession session,
    List<SyllabusNode> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SyllabusNode>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SyllabusNode] and returns the inserted row.
  ///
  /// The returned [SyllabusNode] will have its `id` field set.
  Future<SyllabusNode> insertRow(
    _is.DatabaseSession session,
    SyllabusNode row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SyllabusNode>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SyllabusNode]s in the list and returns the resulting rows.
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
  /// The returned [SyllabusNode]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyllabusNode>> upsert(
    _is.DatabaseSession session,
    List<SyllabusNode> rows, {
    required _is.ColumnSelections<SyllabusNodeTable> conflictColumns,
    _is.ColumnSelections<SyllabusNodeTable>? updateColumns,
    _is.WhereExpressionBuilder<SyllabusNodeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SyllabusNode>(
      rows,
      conflictColumns: conflictColumns(SyllabusNode.t),
      updateColumns: updateColumns?.call(SyllabusNode.t),
      updateWhere: updateWhere?.call(SyllabusNode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SyllabusNode] and returns the resulting row.
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
  /// The returned [SyllabusNode] will have its `id` field set.
  Future<SyllabusNode?> upsertRow(
    _is.DatabaseSession session,
    SyllabusNode row, {
    required _is.ColumnSelections<SyllabusNodeTable> conflictColumns,
    _is.ColumnSelections<SyllabusNodeTable>? updateColumns,
    _is.WhereExpressionBuilder<SyllabusNodeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SyllabusNode>(
      row,
      conflictColumns: conflictColumns(SyllabusNode.t),
      updateColumns: updateColumns?.call(SyllabusNode.t),
      updateWhere: updateWhere?.call(SyllabusNode.t),
      transaction: transaction,
    );
  }

  /// Updates all [SyllabusNode]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyllabusNode>> update(
    _is.DatabaseSession session,
    List<SyllabusNode> rows, {
    _is.ColumnSelections<SyllabusNodeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SyllabusNode>(
      rows,
      columns: columns?.call(SyllabusNode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SyllabusNode]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SyllabusNode> updateRow(
    _is.DatabaseSession session,
    SyllabusNode row, {
    _is.ColumnSelections<SyllabusNodeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SyllabusNode>(
      row,
      columns: columns?.call(SyllabusNode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SyllabusNode] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SyllabusNode?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SyllabusNodeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SyllabusNode>(
      id,
      columnValues: columnValues(SyllabusNode.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SyllabusNode]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SyllabusNode>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SyllabusNodeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SyllabusNodeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SyllabusNodeTable>? orderBy,
    _is.OrderByListBuilder<SyllabusNodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SyllabusNode>(
      columnValues: columnValues(SyllabusNode.t.updateTable),
      where: where(SyllabusNode.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SyllabusNode.t),
      orderByList: orderByList?.call(SyllabusNode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SyllabusNode]s in the list and returns the deleted rows.
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
  Future<List<SyllabusNode>> delete(
    _is.DatabaseSession session,
    List<SyllabusNode> rows, {
    _is.OrderByBuilder<SyllabusNodeTable>? orderBy,
    _is.OrderByListBuilder<SyllabusNodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SyllabusNode>(
      rows,
      orderBy: orderBy?.call(SyllabusNode.t),
      orderByList: orderByList?.call(SyllabusNode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SyllabusNode].
  Future<SyllabusNode> deleteRow(
    _is.DatabaseSession session,
    SyllabusNode row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SyllabusNode>(
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
  Future<List<SyllabusNode>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyllabusNodeTable> where,
    _is.OrderByBuilder<SyllabusNodeTable>? orderBy,
    _is.OrderByListBuilder<SyllabusNodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SyllabusNode>(
      where: where(SyllabusNode.t),
      orderBy: orderBy?.call(SyllabusNode.t),
      orderByList: orderByList?.call(SyllabusNode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SyllabusNodeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SyllabusNode>(
      where: where?.call(SyllabusNode.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SyllabusNode] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SyllabusNodeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SyllabusNode>(
      where: where(SyllabusNode.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
