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

abstract class EventRsvp
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EventRsvp._({
    this.id,
    required this.eventId,
    required this.authUserId,
    required this.studentName,
    this.teamName,
    this.teamMemberNames,
    this.teamMemberEmails,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory EventRsvp({
    int? id,
    required int eventId,
    required _is.UuidValue authUserId,
    required String studentName,
    String? teamName,
    List<String>? teamMemberNames,
    List<String>? teamMemberEmails,
    DateTime? createdAt,
  }) = _EventRsvpImpl;

  factory EventRsvp.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventRsvp(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      teamName: jsonSerialization['teamName'] as String?,
      teamMemberNames: jsonSerialization['teamMemberNames'] == null
          ? null
          : _i2t5n14n.Protocol().deserialize<List<String>>(
              jsonSerialization['teamMemberNames'],
            ),
      teamMemberEmails: jsonSerialization['teamMemberEmails'] == null
          ? null
          : _i2t5n14n.Protocol().deserialize<List<String>>(
              jsonSerialization['teamMemberEmails'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = EventRsvpTable();

  static const db = EventRsvpRepository._();

  @override
  int? id;

  int eventId;

  _is.UuidValue authUserId;

  String studentName;

  String? teamName;

  List<String>? teamMemberNames;

  List<String>? teamMemberEmails;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EventRsvp]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EventRsvp copyWith({
    int? id,
    int? eventId,
    _is.UuidValue? authUserId,
    String? studentName,
    String? teamName,
    List<String>? teamMemberNames,
    List<String>? teamMemberEmails,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventRsvp',
      if (id != null) 'id': id,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      if (teamName != null) 'teamName': teamName,
      if (teamMemberNames != null) 'teamMemberNames': teamMemberNames?.toJson(),
      if (teamMemberEmails != null)
        'teamMemberEmails': teamMemberEmails?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventRsvp',
      if (id != null) 'id': id,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      if (teamName != null) 'teamName': teamName,
      if (teamMemberNames != null) 'teamMemberNames': teamMemberNames?.toJson(),
      if (teamMemberEmails != null)
        'teamMemberEmails': teamMemberEmails?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static EventRsvpInclude include() {
    return EventRsvpInclude._();
  }

  static EventRsvpIncludeList includeList({
    _is.WhereExpressionBuilder<EventRsvpTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventRsvpTable>? orderBy,
    _is.OrderByListBuilder<EventRsvpTable>? orderByList,
    EventRsvpInclude? include,
  }) {
    return EventRsvpIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventRsvp.t),
      orderByList: orderByList?.call(EventRsvp.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventRsvpImpl extends EventRsvp {
  _EventRsvpImpl({
    int? id,
    required int eventId,
    required _is.UuidValue authUserId,
    required String studentName,
    String? teamName,
    List<String>? teamMemberNames,
    List<String>? teamMemberEmails,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         authUserId: authUserId,
         studentName: studentName,
         teamName: teamName,
         teamMemberNames: teamMemberNames,
         teamMemberEmails: teamMemberEmails,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EventRsvp]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EventRsvp copyWith({
    Object? id = _Undefined,
    int? eventId,
    _is.UuidValue? authUserId,
    String? studentName,
    Object? teamName = _Undefined,
    Object? teamMemberNames = _Undefined,
    Object? teamMemberEmails = _Undefined,
    DateTime? createdAt,
  }) {
    return EventRsvp(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      teamName: teamName is String? ? teamName : this.teamName,
      teamMemberNames: teamMemberNames is List<String>?
          ? teamMemberNames
          : this.teamMemberNames?.map((e0) => e0).toList(),
      teamMemberEmails: teamMemberEmails is List<String>?
          ? teamMemberEmails
          : this.teamMemberEmails?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class EventRsvpUpdateTable extends _is.UpdateTable<EventRsvpTable> {
  EventRsvpUpdateTable(super.table);

  _is.ColumnValue<int, int> eventId(int value) => _is.ColumnValue(
    table.eventId,
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

  _is.ColumnValue<String, String> teamName(String? value) => _is.ColumnValue(
    table.teamName,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> teamMemberNames(
    List<String>? value,
  ) => _is.ColumnValue(
    table.teamMemberNames,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> teamMemberEmails(
    List<String>? value,
  ) => _is.ColumnValue(
    table.teamMemberEmails,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class EventRsvpTable extends _is.Table<int?> {
  EventRsvpTable({super.tableRelation}) : super(tableName: 'event_rsvp') {
    updateTable = EventRsvpUpdateTable(this);
    eventId = _is.ColumnInt(
      'eventId',
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
    teamName = _is.ColumnString(
      'teamName',
      this,
    );
    teamMemberNames = _is.ColumnSerializable<List<String>>(
      'teamMemberNames',
      this,
    );
    teamMemberEmails = _is.ColumnSerializable<List<String>>(
      'teamMemberEmails',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final EventRsvpUpdateTable updateTable;

  late final _is.ColumnInt eventId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString studentName;

  late final _is.ColumnString teamName;

  late final _is.ColumnSerializable<List<String>> teamMemberNames;

  late final _is.ColumnSerializable<List<String>> teamMemberEmails;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    authUserId,
    studentName,
    teamName,
    teamMemberNames,
    teamMemberEmails,
    createdAt,
  ];
}

class EventRsvpInclude extends _is.IncludeObject {
  EventRsvpInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EventRsvp.t;
}

class EventRsvpIncludeList extends _is.IncludeList {
  EventRsvpIncludeList._({
    _is.WhereExpressionBuilder<EventRsvpTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EventRsvp.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EventRsvp.t;
}

class EventRsvpRepository {
  const EventRsvpRepository._();

  /// Returns a list of [EventRsvp]s matching the given query parameters.
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
  Future<List<EventRsvp>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventRsvpTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventRsvpTable>? orderBy,
    _is.OrderByListBuilder<EventRsvpTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EventRsvp>(
      where: where?.call(EventRsvp.t),
      orderBy: orderBy?.call(EventRsvp.t),
      orderByList: orderByList?.call(EventRsvp.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EventRsvp] matching the given query parameters.
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
  Future<EventRsvp?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventRsvpTable>? where,
    int? offset,
    _is.OrderByBuilder<EventRsvpTable>? orderBy,
    _is.OrderByListBuilder<EventRsvpTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EventRsvp>(
      where: where?.call(EventRsvp.t),
      orderBy: orderBy?.call(EventRsvp.t),
      orderByList: orderByList?.call(EventRsvp.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EventRsvp] by its [id] or null if no such row exists.
  Future<EventRsvp?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EventRsvp>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EventRsvp]s in the list and returns the inserted rows.
  ///
  /// The returned [EventRsvp]s will have their `id` fields set.
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
  Future<List<EventRsvp>> insert(
    _is.DatabaseSession session,
    List<EventRsvp> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EventRsvp>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EventRsvp] and returns the inserted row.
  ///
  /// The returned [EventRsvp] will have its `id` field set.
  Future<EventRsvp> insertRow(
    _is.DatabaseSession session,
    EventRsvp row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EventRsvp>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EventRsvp]s in the list and returns the resulting rows.
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
  /// The returned [EventRsvp]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventRsvp>> upsert(
    _is.DatabaseSession session,
    List<EventRsvp> rows, {
    required _is.ColumnSelections<EventRsvpTable> conflictColumns,
    _is.ColumnSelections<EventRsvpTable>? updateColumns,
    _is.WhereExpressionBuilder<EventRsvpTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EventRsvp>(
      rows,
      conflictColumns: conflictColumns(EventRsvp.t),
      updateColumns: updateColumns?.call(EventRsvp.t),
      updateWhere: updateWhere?.call(EventRsvp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EventRsvp] and returns the resulting row.
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
  /// The returned [EventRsvp] will have its `id` field set.
  Future<EventRsvp?> upsertRow(
    _is.DatabaseSession session,
    EventRsvp row, {
    required _is.ColumnSelections<EventRsvpTable> conflictColumns,
    _is.ColumnSelections<EventRsvpTable>? updateColumns,
    _is.WhereExpressionBuilder<EventRsvpTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EventRsvp>(
      row,
      conflictColumns: conflictColumns(EventRsvp.t),
      updateColumns: updateColumns?.call(EventRsvp.t),
      updateWhere: updateWhere?.call(EventRsvp.t),
      transaction: transaction,
    );
  }

  /// Updates all [EventRsvp]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventRsvp>> update(
    _is.DatabaseSession session,
    List<EventRsvp> rows, {
    _is.ColumnSelections<EventRsvpTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EventRsvp>(
      rows,
      columns: columns?.call(EventRsvp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EventRsvp]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EventRsvp> updateRow(
    _is.DatabaseSession session,
    EventRsvp row, {
    _is.ColumnSelections<EventRsvpTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EventRsvp>(
      row,
      columns: columns?.call(EventRsvp.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EventRsvp] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EventRsvp?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EventRsvpUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EventRsvp>(
      id,
      columnValues: columnValues(EventRsvp.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EventRsvp]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventRsvp>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EventRsvpUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EventRsvpTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventRsvpTable>? orderBy,
    _is.OrderByListBuilder<EventRsvpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EventRsvp>(
      columnValues: columnValues(EventRsvp.t.updateTable),
      where: where(EventRsvp.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventRsvp.t),
      orderByList: orderByList?.call(EventRsvp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EventRsvp]s in the list and returns the deleted rows.
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
  Future<List<EventRsvp>> delete(
    _is.DatabaseSession session,
    List<EventRsvp> rows, {
    _is.OrderByBuilder<EventRsvpTable>? orderBy,
    _is.OrderByListBuilder<EventRsvpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EventRsvp>(
      rows,
      orderBy: orderBy?.call(EventRsvp.t),
      orderByList: orderByList?.call(EventRsvp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EventRsvp].
  Future<EventRsvp> deleteRow(
    _is.DatabaseSession session,
    EventRsvp row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EventRsvp>(
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
  Future<List<EventRsvp>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventRsvpTable> where,
    _is.OrderByBuilder<EventRsvpTable>? orderBy,
    _is.OrderByListBuilder<EventRsvpTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EventRsvp>(
      where: where(EventRsvp.t),
      orderBy: orderBy?.call(EventRsvp.t),
      orderByList: orderByList?.call(EventRsvp.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventRsvpTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EventRsvp>(
      where: where?.call(EventRsvp.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EventRsvp] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventRsvpTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EventRsvp>(
      where: where(EventRsvp.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
