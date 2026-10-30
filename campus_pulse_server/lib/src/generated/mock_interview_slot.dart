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

abstract class MockInterviewSlot
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MockInterviewSlot._({
    this.id,
    required this.studentAuthUserId,
    required this.studentName,
    required this.studentEmail,
    required this.targetCompany,
    required this.targetRole,
    required this.mockRound,
    required this.preferredDate,
    this.resumeUrl,
    this.notes,
    String? status,
    this.seniorMentorName,
    this.meetingLink,
    this.feedbackNotes,
    DateTime? createdAt,
  }) : status = status ?? 'REQUESTED',
       createdAt = createdAt ?? DateTime.now();

  factory MockInterviewSlot({
    int? id,
    required _is.UuidValue studentAuthUserId,
    required String studentName,
    required String studentEmail,
    required String targetCompany,
    required String targetRole,
    required String mockRound,
    required DateTime preferredDate,
    String? resumeUrl,
    String? notes,
    String? status,
    String? seniorMentorName,
    String? meetingLink,
    String? feedbackNotes,
    DateTime? createdAt,
  }) = _MockInterviewSlotImpl;

  factory MockInterviewSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return MockInterviewSlot(
      id: jsonSerialization['id'] as int?,
      studentAuthUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['studentAuthUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      studentEmail: jsonSerialization['studentEmail'] as String,
      targetCompany: jsonSerialization['targetCompany'] as String,
      targetRole: jsonSerialization['targetRole'] as String,
      mockRound: jsonSerialization['mockRound'] as String,
      preferredDate: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['preferredDate'],
      ),
      resumeUrl: jsonSerialization['resumeUrl'] as String?,
      notes: jsonSerialization['notes'] as String?,
      status: jsonSerialization['status'] as String?,
      seniorMentorName: jsonSerialization['seniorMentorName'] as String?,
      meetingLink: jsonSerialization['meetingLink'] as String?,
      feedbackNotes: jsonSerialization['feedbackNotes'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = MockInterviewSlotTable();

  static const db = MockInterviewSlotRepository._();

  @override
  int? id;

  _is.UuidValue studentAuthUserId;

  String studentName;

  String studentEmail;

  String targetCompany;

  String targetRole;

  String mockRound;

  DateTime preferredDate;

  String? resumeUrl;

  String? notes;

  String status;

  String? seniorMentorName;

  String? meetingLink;

  String? feedbackNotes;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MockInterviewSlot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MockInterviewSlot copyWith({
    int? id,
    _is.UuidValue? studentAuthUserId,
    String? studentName,
    String? studentEmail,
    String? targetCompany,
    String? targetRole,
    String? mockRound,
    DateTime? preferredDate,
    String? resumeUrl,
    String? notes,
    String? status,
    String? seniorMentorName,
    String? meetingLink,
    String? feedbackNotes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MockInterviewSlot',
      if (id != null) 'id': id,
      'studentAuthUserId': studentAuthUserId.toJson(),
      'studentName': studentName,
      'studentEmail': studentEmail,
      'targetCompany': targetCompany,
      'targetRole': targetRole,
      'mockRound': mockRound,
      'preferredDate': preferredDate.toJson(),
      if (resumeUrl != null) 'resumeUrl': resumeUrl,
      if (notes != null) 'notes': notes,
      'status': status,
      if (seniorMentorName != null) 'seniorMentorName': seniorMentorName,
      if (meetingLink != null) 'meetingLink': meetingLink,
      if (feedbackNotes != null) 'feedbackNotes': feedbackNotes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MockInterviewSlot',
      if (id != null) 'id': id,
      'studentAuthUserId': studentAuthUserId.toJson(),
      'studentName': studentName,
      'studentEmail': studentEmail,
      'targetCompany': targetCompany,
      'targetRole': targetRole,
      'mockRound': mockRound,
      'preferredDate': preferredDate.toJson(),
      if (resumeUrl != null) 'resumeUrl': resumeUrl,
      if (notes != null) 'notes': notes,
      'status': status,
      if (seniorMentorName != null) 'seniorMentorName': seniorMentorName,
      if (meetingLink != null) 'meetingLink': meetingLink,
      if (feedbackNotes != null) 'feedbackNotes': feedbackNotes,
      'createdAt': createdAt.toJson(),
    };
  }

  static MockInterviewSlotInclude include() {
    return MockInterviewSlotInclude._();
  }

  static MockInterviewSlotIncludeList includeList({
    _is.WhereExpressionBuilder<MockInterviewSlotTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MockInterviewSlotTable>? orderBy,
    _is.OrderByListBuilder<MockInterviewSlotTable>? orderByList,
    MockInterviewSlotInclude? include,
  }) {
    return MockInterviewSlotIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MockInterviewSlot.t),
      orderByList: orderByList?.call(MockInterviewSlot.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MockInterviewSlotImpl extends MockInterviewSlot {
  _MockInterviewSlotImpl({
    int? id,
    required _is.UuidValue studentAuthUserId,
    required String studentName,
    required String studentEmail,
    required String targetCompany,
    required String targetRole,
    required String mockRound,
    required DateTime preferredDate,
    String? resumeUrl,
    String? notes,
    String? status,
    String? seniorMentorName,
    String? meetingLink,
    String? feedbackNotes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         studentAuthUserId: studentAuthUserId,
         studentName: studentName,
         studentEmail: studentEmail,
         targetCompany: targetCompany,
         targetRole: targetRole,
         mockRound: mockRound,
         preferredDate: preferredDate,
         resumeUrl: resumeUrl,
         notes: notes,
         status: status,
         seniorMentorName: seniorMentorName,
         meetingLink: meetingLink,
         feedbackNotes: feedbackNotes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MockInterviewSlot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MockInterviewSlot copyWith({
    Object? id = _Undefined,
    _is.UuidValue? studentAuthUserId,
    String? studentName,
    String? studentEmail,
    String? targetCompany,
    String? targetRole,
    String? mockRound,
    DateTime? preferredDate,
    Object? resumeUrl = _Undefined,
    Object? notes = _Undefined,
    String? status,
    Object? seniorMentorName = _Undefined,
    Object? meetingLink = _Undefined,
    Object? feedbackNotes = _Undefined,
    DateTime? createdAt,
  }) {
    return MockInterviewSlot(
      id: id is int? ? id : this.id,
      studentAuthUserId: studentAuthUserId ?? this.studentAuthUserId,
      studentName: studentName ?? this.studentName,
      studentEmail: studentEmail ?? this.studentEmail,
      targetCompany: targetCompany ?? this.targetCompany,
      targetRole: targetRole ?? this.targetRole,
      mockRound: mockRound ?? this.mockRound,
      preferredDate: preferredDate ?? this.preferredDate,
      resumeUrl: resumeUrl is String? ? resumeUrl : this.resumeUrl,
      notes: notes is String? ? notes : this.notes,
      status: status ?? this.status,
      seniorMentorName: seniorMentorName is String?
          ? seniorMentorName
          : this.seniorMentorName,
      meetingLink: meetingLink is String? ? meetingLink : this.meetingLink,
      feedbackNotes: feedbackNotes is String?
          ? feedbackNotes
          : this.feedbackNotes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class MockInterviewSlotUpdateTable
    extends _is.UpdateTable<MockInterviewSlotTable> {
  MockInterviewSlotUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> studentAuthUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.studentAuthUserId,
    value,
  );

  _is.ColumnValue<String, String> studentName(String value) => _is.ColumnValue(
    table.studentName,
    value,
  );

  _is.ColumnValue<String, String> studentEmail(String value) => _is.ColumnValue(
    table.studentEmail,
    value,
  );

  _is.ColumnValue<String, String> targetCompany(String value) =>
      _is.ColumnValue(
        table.targetCompany,
        value,
      );

  _is.ColumnValue<String, String> targetRole(String value) => _is.ColumnValue(
    table.targetRole,
    value,
  );

  _is.ColumnValue<String, String> mockRound(String value) => _is.ColumnValue(
    table.mockRound,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> preferredDate(DateTime value) =>
      _is.ColumnValue(
        table.preferredDate,
        value,
      );

  _is.ColumnValue<String, String> resumeUrl(String? value) => _is.ColumnValue(
    table.resumeUrl,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> seniorMentorName(String? value) =>
      _is.ColumnValue(
        table.seniorMentorName,
        value,
      );

  _is.ColumnValue<String, String> meetingLink(String? value) => _is.ColumnValue(
    table.meetingLink,
    value,
  );

  _is.ColumnValue<String, String> feedbackNotes(String? value) =>
      _is.ColumnValue(
        table.feedbackNotes,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class MockInterviewSlotTable extends _is.Table<int?> {
  MockInterviewSlotTable({super.tableRelation})
    : super(tableName: 'mock_interview_slots') {
    updateTable = MockInterviewSlotUpdateTable(this);
    studentAuthUserId = _is.ColumnUuid(
      'studentAuthUserId',
      this,
    );
    studentName = _is.ColumnString(
      'studentName',
      this,
    );
    studentEmail = _is.ColumnString(
      'studentEmail',
      this,
    );
    targetCompany = _is.ColumnString(
      'targetCompany',
      this,
    );
    targetRole = _is.ColumnString(
      'targetRole',
      this,
    );
    mockRound = _is.ColumnString(
      'mockRound',
      this,
    );
    preferredDate = _is.ColumnDateTime(
      'preferredDate',
      this,
    );
    resumeUrl = _is.ColumnString(
      'resumeUrl',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    seniorMentorName = _is.ColumnString(
      'seniorMentorName',
      this,
    );
    meetingLink = _is.ColumnString(
      'meetingLink',
      this,
    );
    feedbackNotes = _is.ColumnString(
      'feedbackNotes',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final MockInterviewSlotUpdateTable updateTable;

  late final _is.ColumnUuid studentAuthUserId;

  late final _is.ColumnString studentName;

  late final _is.ColumnString studentEmail;

  late final _is.ColumnString targetCompany;

  late final _is.ColumnString targetRole;

  late final _is.ColumnString mockRound;

  late final _is.ColumnDateTime preferredDate;

  late final _is.ColumnString resumeUrl;

  late final _is.ColumnString notes;

  late final _is.ColumnString status;

  late final _is.ColumnString seniorMentorName;

  late final _is.ColumnString meetingLink;

  late final _is.ColumnString feedbackNotes;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    studentAuthUserId,
    studentName,
    studentEmail,
    targetCompany,
    targetRole,
    mockRound,
    preferredDate,
    resumeUrl,
    notes,
    status,
    seniorMentorName,
    meetingLink,
    feedbackNotes,
    createdAt,
  ];
}

class MockInterviewSlotInclude extends _is.IncludeObject {
  MockInterviewSlotInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MockInterviewSlot.t;
}

class MockInterviewSlotIncludeList extends _is.IncludeList {
  MockInterviewSlotIncludeList._({
    _is.WhereExpressionBuilder<MockInterviewSlotTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MockInterviewSlot.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MockInterviewSlot.t;
}

class MockInterviewSlotRepository {
  const MockInterviewSlotRepository._();

  /// Returns a list of [MockInterviewSlot]s matching the given query parameters.
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
  Future<List<MockInterviewSlot>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MockInterviewSlotTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MockInterviewSlotTable>? orderBy,
    _is.OrderByListBuilder<MockInterviewSlotTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MockInterviewSlot>(
      where: where?.call(MockInterviewSlot.t),
      orderBy: orderBy?.call(MockInterviewSlot.t),
      orderByList: orderByList?.call(MockInterviewSlot.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MockInterviewSlot] matching the given query parameters.
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
  Future<MockInterviewSlot?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MockInterviewSlotTable>? where,
    int? offset,
    _is.OrderByBuilder<MockInterviewSlotTable>? orderBy,
    _is.OrderByListBuilder<MockInterviewSlotTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MockInterviewSlot>(
      where: where?.call(MockInterviewSlot.t),
      orderBy: orderBy?.call(MockInterviewSlot.t),
      orderByList: orderByList?.call(MockInterviewSlot.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MockInterviewSlot] by its [id] or null if no such row exists.
  Future<MockInterviewSlot?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MockInterviewSlot>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MockInterviewSlot]s in the list and returns the inserted rows.
  ///
  /// The returned [MockInterviewSlot]s will have their `id` fields set.
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
  Future<List<MockInterviewSlot>> insert(
    _is.DatabaseSession session,
    List<MockInterviewSlot> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MockInterviewSlot>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MockInterviewSlot] and returns the inserted row.
  ///
  /// The returned [MockInterviewSlot] will have its `id` field set.
  Future<MockInterviewSlot> insertRow(
    _is.DatabaseSession session,
    MockInterviewSlot row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MockInterviewSlot>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MockInterviewSlot]s in the list and returns the resulting rows.
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
  /// The returned [MockInterviewSlot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MockInterviewSlot>> upsert(
    _is.DatabaseSession session,
    List<MockInterviewSlot> rows, {
    required _is.ColumnSelections<MockInterviewSlotTable> conflictColumns,
    _is.ColumnSelections<MockInterviewSlotTable>? updateColumns,
    _is.WhereExpressionBuilder<MockInterviewSlotTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MockInterviewSlot>(
      rows,
      conflictColumns: conflictColumns(MockInterviewSlot.t),
      updateColumns: updateColumns?.call(MockInterviewSlot.t),
      updateWhere: updateWhere?.call(MockInterviewSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MockInterviewSlot] and returns the resulting row.
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
  /// The returned [MockInterviewSlot] will have its `id` field set.
  Future<MockInterviewSlot?> upsertRow(
    _is.DatabaseSession session,
    MockInterviewSlot row, {
    required _is.ColumnSelections<MockInterviewSlotTable> conflictColumns,
    _is.ColumnSelections<MockInterviewSlotTable>? updateColumns,
    _is.WhereExpressionBuilder<MockInterviewSlotTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MockInterviewSlot>(
      row,
      conflictColumns: conflictColumns(MockInterviewSlot.t),
      updateColumns: updateColumns?.call(MockInterviewSlot.t),
      updateWhere: updateWhere?.call(MockInterviewSlot.t),
      transaction: transaction,
    );
  }

  /// Updates all [MockInterviewSlot]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MockInterviewSlot>> update(
    _is.DatabaseSession session,
    List<MockInterviewSlot> rows, {
    _is.ColumnSelections<MockInterviewSlotTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MockInterviewSlot>(
      rows,
      columns: columns?.call(MockInterviewSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MockInterviewSlot]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MockInterviewSlot> updateRow(
    _is.DatabaseSession session,
    MockInterviewSlot row, {
    _is.ColumnSelections<MockInterviewSlotTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MockInterviewSlot>(
      row,
      columns: columns?.call(MockInterviewSlot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MockInterviewSlot] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MockInterviewSlot?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MockInterviewSlotUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MockInterviewSlot>(
      id,
      columnValues: columnValues(MockInterviewSlot.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MockInterviewSlot]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MockInterviewSlot>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MockInterviewSlotUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<MockInterviewSlotTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MockInterviewSlotTable>? orderBy,
    _is.OrderByListBuilder<MockInterviewSlotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MockInterviewSlot>(
      columnValues: columnValues(MockInterviewSlot.t.updateTable),
      where: where(MockInterviewSlot.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MockInterviewSlot.t),
      orderByList: orderByList?.call(MockInterviewSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MockInterviewSlot]s in the list and returns the deleted rows.
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
  Future<List<MockInterviewSlot>> delete(
    _is.DatabaseSession session,
    List<MockInterviewSlot> rows, {
    _is.OrderByBuilder<MockInterviewSlotTable>? orderBy,
    _is.OrderByListBuilder<MockInterviewSlotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MockInterviewSlot>(
      rows,
      orderBy: orderBy?.call(MockInterviewSlot.t),
      orderByList: orderByList?.call(MockInterviewSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MockInterviewSlot].
  Future<MockInterviewSlot> deleteRow(
    _is.DatabaseSession session,
    MockInterviewSlot row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MockInterviewSlot>(
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
  Future<List<MockInterviewSlot>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MockInterviewSlotTable> where,
    _is.OrderByBuilder<MockInterviewSlotTable>? orderBy,
    _is.OrderByListBuilder<MockInterviewSlotTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MockInterviewSlot>(
      where: where(MockInterviewSlot.t),
      orderBy: orderBy?.call(MockInterviewSlot.t),
      orderByList: orderByList?.call(MockInterviewSlot.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MockInterviewSlotTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MockInterviewSlot>(
      where: where?.call(MockInterviewSlot.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MockInterviewSlot] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MockInterviewSlotTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MockInterviewSlot>(
      where: where(MockInterviewSlot.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
