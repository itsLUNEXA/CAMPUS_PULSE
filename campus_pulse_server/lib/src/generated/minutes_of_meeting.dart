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

abstract class MinutesOfMeeting
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MinutesOfMeeting._({
    this.id,
    required this.title,
    required this.meetingDate,
    required this.organizerUserId,
    required this.organizerName,
    required this.attendeeNames,
    required this.agenda,
    required this.discussionPoints,
    required this.decisions,
    required this.actionItems,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory MinutesOfMeeting({
    int? id,
    required String title,
    required DateTime meetingDate,
    required _is.UuidValue organizerUserId,
    required String organizerName,
    required List<String> attendeeNames,
    required String agenda,
    required List<String> discussionPoints,
    required List<String> decisions,
    required List<String> actionItems,
    DateTime? createdAt,
  }) = _MinutesOfMeetingImpl;

  factory MinutesOfMeeting.fromJson(Map<String, dynamic> jsonSerialization) {
    return MinutesOfMeeting(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      meetingDate: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['meetingDate'],
      ),
      organizerUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizerUserId'],
      ),
      organizerName: jsonSerialization['organizerName'] as String,
      attendeeNames: _i2t5n14n.Protocol().deserialize<List<String>>(
        jsonSerialization['attendeeNames'],
      ),
      agenda: jsonSerialization['agenda'] as String,
      discussionPoints: _i2t5n14n.Protocol().deserialize<List<String>>(
        jsonSerialization['discussionPoints'],
      ),
      decisions: _i2t5n14n.Protocol().deserialize<List<String>>(
        jsonSerialization['decisions'],
      ),
      actionItems: _i2t5n14n.Protocol().deserialize<List<String>>(
        jsonSerialization['actionItems'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = MinutesOfMeetingTable();

  static const db = MinutesOfMeetingRepository._();

  @override
  int? id;

  String title;

  DateTime meetingDate;

  _is.UuidValue organizerUserId;

  String organizerName;

  List<String> attendeeNames;

  String agenda;

  List<String> discussionPoints;

  List<String> decisions;

  List<String> actionItems;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MinutesOfMeeting]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MinutesOfMeeting copyWith({
    int? id,
    String? title,
    DateTime? meetingDate,
    _is.UuidValue? organizerUserId,
    String? organizerName,
    List<String>? attendeeNames,
    String? agenda,
    List<String>? discussionPoints,
    List<String>? decisions,
    List<String>? actionItems,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MinutesOfMeeting',
      if (id != null) 'id': id,
      'title': title,
      'meetingDate': meetingDate.toJson(),
      'organizerUserId': organizerUserId.toJson(),
      'organizerName': organizerName,
      'attendeeNames': attendeeNames.toJson(),
      'agenda': agenda,
      'discussionPoints': discussionPoints.toJson(),
      'decisions': decisions.toJson(),
      'actionItems': actionItems.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MinutesOfMeeting',
      if (id != null) 'id': id,
      'title': title,
      'meetingDate': meetingDate.toJson(),
      'organizerUserId': organizerUserId.toJson(),
      'organizerName': organizerName,
      'attendeeNames': attendeeNames.toJson(),
      'agenda': agenda,
      'discussionPoints': discussionPoints.toJson(),
      'decisions': decisions.toJson(),
      'actionItems': actionItems.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static MinutesOfMeetingInclude include() {
    return MinutesOfMeetingInclude._();
  }

  static MinutesOfMeetingIncludeList includeList({
    _is.WhereExpressionBuilder<MinutesOfMeetingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MinutesOfMeetingTable>? orderBy,
    _is.OrderByListBuilder<MinutesOfMeetingTable>? orderByList,
    MinutesOfMeetingInclude? include,
  }) {
    return MinutesOfMeetingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MinutesOfMeeting.t),
      orderByList: orderByList?.call(MinutesOfMeeting.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MinutesOfMeetingImpl extends MinutesOfMeeting {
  _MinutesOfMeetingImpl({
    int? id,
    required String title,
    required DateTime meetingDate,
    required _is.UuidValue organizerUserId,
    required String organizerName,
    required List<String> attendeeNames,
    required String agenda,
    required List<String> discussionPoints,
    required List<String> decisions,
    required List<String> actionItems,
    DateTime? createdAt,
  }) : super._(
         id: id,
         title: title,
         meetingDate: meetingDate,
         organizerUserId: organizerUserId,
         organizerName: organizerName,
         attendeeNames: attendeeNames,
         agenda: agenda,
         discussionPoints: discussionPoints,
         decisions: decisions,
         actionItems: actionItems,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MinutesOfMeeting]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MinutesOfMeeting copyWith({
    Object? id = _Undefined,
    String? title,
    DateTime? meetingDate,
    _is.UuidValue? organizerUserId,
    String? organizerName,
    List<String>? attendeeNames,
    String? agenda,
    List<String>? discussionPoints,
    List<String>? decisions,
    List<String>? actionItems,
    DateTime? createdAt,
  }) {
    return MinutesOfMeeting(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      meetingDate: meetingDate ?? this.meetingDate,
      organizerUserId: organizerUserId ?? this.organizerUserId,
      organizerName: organizerName ?? this.organizerName,
      attendeeNames:
          attendeeNames ?? this.attendeeNames.map((e0) => e0).toList(),
      agenda: agenda ?? this.agenda,
      discussionPoints:
          discussionPoints ?? this.discussionPoints.map((e0) => e0).toList(),
      decisions: decisions ?? this.decisions.map((e0) => e0).toList(),
      actionItems: actionItems ?? this.actionItems.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class MinutesOfMeetingUpdateTable
    extends _is.UpdateTable<MinutesOfMeetingTable> {
  MinutesOfMeetingUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> meetingDate(DateTime value) =>
      _is.ColumnValue(
        table.meetingDate,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> organizerUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.organizerUserId,
    value,
  );

  _is.ColumnValue<String, String> organizerName(String value) =>
      _is.ColumnValue(
        table.organizerName,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> attendeeNames(
    List<String> value,
  ) => _is.ColumnValue(
    table.attendeeNames,
    value,
  );

  _is.ColumnValue<String, String> agenda(String value) => _is.ColumnValue(
    table.agenda,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> discussionPoints(
    List<String> value,
  ) => _is.ColumnValue(
    table.discussionPoints,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> decisions(List<String> value) =>
      _is.ColumnValue(
        table.decisions,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> actionItems(List<String> value) =>
      _is.ColumnValue(
        table.actionItems,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class MinutesOfMeetingTable extends _is.Table<int?> {
  MinutesOfMeetingTable({super.tableRelation})
    : super(tableName: 'minutes_of_meeting') {
    updateTable = MinutesOfMeetingUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    meetingDate = _is.ColumnDateTime(
      'meetingDate',
      this,
    );
    organizerUserId = _is.ColumnUuid(
      'organizerUserId',
      this,
    );
    organizerName = _is.ColumnString(
      'organizerName',
      this,
    );
    attendeeNames = _is.ColumnSerializable<List<String>>(
      'attendeeNames',
      this,
    );
    agenda = _is.ColumnString(
      'agenda',
      this,
    );
    discussionPoints = _is.ColumnSerializable<List<String>>(
      'discussionPoints',
      this,
    );
    decisions = _is.ColumnSerializable<List<String>>(
      'decisions',
      this,
    );
    actionItems = _is.ColumnSerializable<List<String>>(
      'actionItems',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final MinutesOfMeetingUpdateTable updateTable;

  late final _is.ColumnString title;

  late final _is.ColumnDateTime meetingDate;

  late final _is.ColumnUuid organizerUserId;

  late final _is.ColumnString organizerName;

  late final _is.ColumnSerializable<List<String>> attendeeNames;

  late final _is.ColumnString agenda;

  late final _is.ColumnSerializable<List<String>> discussionPoints;

  late final _is.ColumnSerializable<List<String>> decisions;

  late final _is.ColumnSerializable<List<String>> actionItems;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    title,
    meetingDate,
    organizerUserId,
    organizerName,
    attendeeNames,
    agenda,
    discussionPoints,
    decisions,
    actionItems,
    createdAt,
  ];
}

class MinutesOfMeetingInclude extends _is.IncludeObject {
  MinutesOfMeetingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MinutesOfMeeting.t;
}

class MinutesOfMeetingIncludeList extends _is.IncludeList {
  MinutesOfMeetingIncludeList._({
    _is.WhereExpressionBuilder<MinutesOfMeetingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MinutesOfMeeting.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MinutesOfMeeting.t;
}

class MinutesOfMeetingRepository {
  const MinutesOfMeetingRepository._();

  /// Returns a list of [MinutesOfMeeting]s matching the given query parameters.
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
  Future<List<MinutesOfMeeting>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MinutesOfMeetingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MinutesOfMeetingTable>? orderBy,
    _is.OrderByListBuilder<MinutesOfMeetingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MinutesOfMeeting>(
      where: where?.call(MinutesOfMeeting.t),
      orderBy: orderBy?.call(MinutesOfMeeting.t),
      orderByList: orderByList?.call(MinutesOfMeeting.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MinutesOfMeeting] matching the given query parameters.
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
  Future<MinutesOfMeeting?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MinutesOfMeetingTable>? where,
    int? offset,
    _is.OrderByBuilder<MinutesOfMeetingTable>? orderBy,
    _is.OrderByListBuilder<MinutesOfMeetingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MinutesOfMeeting>(
      where: where?.call(MinutesOfMeeting.t),
      orderBy: orderBy?.call(MinutesOfMeeting.t),
      orderByList: orderByList?.call(MinutesOfMeeting.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MinutesOfMeeting] by its [id] or null if no such row exists.
  Future<MinutesOfMeeting?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MinutesOfMeeting>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MinutesOfMeeting]s in the list and returns the inserted rows.
  ///
  /// The returned [MinutesOfMeeting]s will have their `id` fields set.
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
  Future<List<MinutesOfMeeting>> insert(
    _is.DatabaseSession session,
    List<MinutesOfMeeting> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MinutesOfMeeting>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MinutesOfMeeting] and returns the inserted row.
  ///
  /// The returned [MinutesOfMeeting] will have its `id` field set.
  Future<MinutesOfMeeting> insertRow(
    _is.DatabaseSession session,
    MinutesOfMeeting row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MinutesOfMeeting>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MinutesOfMeeting]s in the list and returns the resulting rows.
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
  /// The returned [MinutesOfMeeting]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MinutesOfMeeting>> upsert(
    _is.DatabaseSession session,
    List<MinutesOfMeeting> rows, {
    required _is.ColumnSelections<MinutesOfMeetingTable> conflictColumns,
    _is.ColumnSelections<MinutesOfMeetingTable>? updateColumns,
    _is.WhereExpressionBuilder<MinutesOfMeetingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MinutesOfMeeting>(
      rows,
      conflictColumns: conflictColumns(MinutesOfMeeting.t),
      updateColumns: updateColumns?.call(MinutesOfMeeting.t),
      updateWhere: updateWhere?.call(MinutesOfMeeting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MinutesOfMeeting] and returns the resulting row.
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
  /// The returned [MinutesOfMeeting] will have its `id` field set.
  Future<MinutesOfMeeting?> upsertRow(
    _is.DatabaseSession session,
    MinutesOfMeeting row, {
    required _is.ColumnSelections<MinutesOfMeetingTable> conflictColumns,
    _is.ColumnSelections<MinutesOfMeetingTable>? updateColumns,
    _is.WhereExpressionBuilder<MinutesOfMeetingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MinutesOfMeeting>(
      row,
      conflictColumns: conflictColumns(MinutesOfMeeting.t),
      updateColumns: updateColumns?.call(MinutesOfMeeting.t),
      updateWhere: updateWhere?.call(MinutesOfMeeting.t),
      transaction: transaction,
    );
  }

  /// Updates all [MinutesOfMeeting]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MinutesOfMeeting>> update(
    _is.DatabaseSession session,
    List<MinutesOfMeeting> rows, {
    _is.ColumnSelections<MinutesOfMeetingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MinutesOfMeeting>(
      rows,
      columns: columns?.call(MinutesOfMeeting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MinutesOfMeeting]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MinutesOfMeeting> updateRow(
    _is.DatabaseSession session,
    MinutesOfMeeting row, {
    _is.ColumnSelections<MinutesOfMeetingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MinutesOfMeeting>(
      row,
      columns: columns?.call(MinutesOfMeeting.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MinutesOfMeeting] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MinutesOfMeeting?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MinutesOfMeetingUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MinutesOfMeeting>(
      id,
      columnValues: columnValues(MinutesOfMeeting.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MinutesOfMeeting]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MinutesOfMeeting>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MinutesOfMeetingUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<MinutesOfMeetingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MinutesOfMeetingTable>? orderBy,
    _is.OrderByListBuilder<MinutesOfMeetingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MinutesOfMeeting>(
      columnValues: columnValues(MinutesOfMeeting.t.updateTable),
      where: where(MinutesOfMeeting.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MinutesOfMeeting.t),
      orderByList: orderByList?.call(MinutesOfMeeting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MinutesOfMeeting]s in the list and returns the deleted rows.
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
  Future<List<MinutesOfMeeting>> delete(
    _is.DatabaseSession session,
    List<MinutesOfMeeting> rows, {
    _is.OrderByBuilder<MinutesOfMeetingTable>? orderBy,
    _is.OrderByListBuilder<MinutesOfMeetingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MinutesOfMeeting>(
      rows,
      orderBy: orderBy?.call(MinutesOfMeeting.t),
      orderByList: orderByList?.call(MinutesOfMeeting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MinutesOfMeeting].
  Future<MinutesOfMeeting> deleteRow(
    _is.DatabaseSession session,
    MinutesOfMeeting row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MinutesOfMeeting>(
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
  Future<List<MinutesOfMeeting>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MinutesOfMeetingTable> where,
    _is.OrderByBuilder<MinutesOfMeetingTable>? orderBy,
    _is.OrderByListBuilder<MinutesOfMeetingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MinutesOfMeeting>(
      where: where(MinutesOfMeeting.t),
      orderBy: orderBy?.call(MinutesOfMeeting.t),
      orderByList: orderByList?.call(MinutesOfMeeting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MinutesOfMeetingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MinutesOfMeeting>(
      where: where?.call(MinutesOfMeeting.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MinutesOfMeeting] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MinutesOfMeetingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MinutesOfMeeting>(
      where: where(MinutesOfMeeting.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
