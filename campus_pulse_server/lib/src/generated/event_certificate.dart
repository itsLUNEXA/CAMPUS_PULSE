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

abstract class EventCertificate
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EventCertificate._({
    this.id,
    required this.certificateId,
    required this.eventId,
    required this.authUserId,
    required this.studentName,
    required this.eventName,
    required this.eventDate,
    DateTime? issuedAt,
    this.issuedByUserId,
    required this.verificationUrl,
    required this.status,
    required this.signatureTitle,
  }) : issuedAt = issuedAt ?? DateTime.now();

  factory EventCertificate({
    int? id,
    required String certificateId,
    required int eventId,
    required _is.UuidValue authUserId,
    required String studentName,
    required String eventName,
    required DateTime eventDate,
    DateTime? issuedAt,
    _is.UuidValue? issuedByUserId,
    required String verificationUrl,
    required String status,
    required String signatureTitle,
  }) = _EventCertificateImpl;

  factory EventCertificate.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventCertificate(
      id: jsonSerialization['id'] as int?,
      certificateId: jsonSerialization['certificateId'] as String,
      eventId: jsonSerialization['eventId'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      eventName: jsonSerialization['eventName'] as String,
      eventDate: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['eventDate'],
      ),
      issuedAt: jsonSerialization['issuedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['issuedAt']),
      issuedByUserId: jsonSerialization['issuedByUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['issuedByUserId'],
            ),
      verificationUrl: jsonSerialization['verificationUrl'] as String,
      status: jsonSerialization['status'] as String,
      signatureTitle: jsonSerialization['signatureTitle'] as String,
    );
  }

  static final t = EventCertificateTable();

  static const db = EventCertificateRepository._();

  @override
  int? id;

  String certificateId;

  int eventId;

  _is.UuidValue authUserId;

  String studentName;

  String eventName;

  DateTime eventDate;

  DateTime issuedAt;

  _is.UuidValue? issuedByUserId;

  String verificationUrl;

  String status;

  String signatureTitle;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EventCertificate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EventCertificate copyWith({
    int? id,
    String? certificateId,
    int? eventId,
    _is.UuidValue? authUserId,
    String? studentName,
    String? eventName,
    DateTime? eventDate,
    DateTime? issuedAt,
    _is.UuidValue? issuedByUserId,
    String? verificationUrl,
    String? status,
    String? signatureTitle,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventCertificate',
      if (id != null) 'id': id,
      'certificateId': certificateId,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'eventName': eventName,
      'eventDate': eventDate.toJson(),
      'issuedAt': issuedAt.toJson(),
      if (issuedByUserId != null) 'issuedByUserId': issuedByUserId?.toJson(),
      'verificationUrl': verificationUrl,
      'status': status,
      'signatureTitle': signatureTitle,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventCertificate',
      if (id != null) 'id': id,
      'certificateId': certificateId,
      'eventId': eventId,
      'authUserId': authUserId.toJson(),
      'studentName': studentName,
      'eventName': eventName,
      'eventDate': eventDate.toJson(),
      'issuedAt': issuedAt.toJson(),
      if (issuedByUserId != null) 'issuedByUserId': issuedByUserId?.toJson(),
      'verificationUrl': verificationUrl,
      'status': status,
      'signatureTitle': signatureTitle,
    };
  }

  static EventCertificateInclude include() {
    return EventCertificateInclude._();
  }

  static EventCertificateIncludeList includeList({
    _is.WhereExpressionBuilder<EventCertificateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventCertificateTable>? orderBy,
    _is.OrderByListBuilder<EventCertificateTable>? orderByList,
    EventCertificateInclude? include,
  }) {
    return EventCertificateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventCertificate.t),
      orderByList: orderByList?.call(EventCertificate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventCertificateImpl extends EventCertificate {
  _EventCertificateImpl({
    int? id,
    required String certificateId,
    required int eventId,
    required _is.UuidValue authUserId,
    required String studentName,
    required String eventName,
    required DateTime eventDate,
    DateTime? issuedAt,
    _is.UuidValue? issuedByUserId,
    required String verificationUrl,
    required String status,
    required String signatureTitle,
  }) : super._(
         id: id,
         certificateId: certificateId,
         eventId: eventId,
         authUserId: authUserId,
         studentName: studentName,
         eventName: eventName,
         eventDate: eventDate,
         issuedAt: issuedAt,
         issuedByUserId: issuedByUserId,
         verificationUrl: verificationUrl,
         status: status,
         signatureTitle: signatureTitle,
       );

  /// Returns a shallow copy of this [EventCertificate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EventCertificate copyWith({
    Object? id = _Undefined,
    String? certificateId,
    int? eventId,
    _is.UuidValue? authUserId,
    String? studentName,
    String? eventName,
    DateTime? eventDate,
    DateTime? issuedAt,
    Object? issuedByUserId = _Undefined,
    String? verificationUrl,
    String? status,
    String? signatureTitle,
  }) {
    return EventCertificate(
      id: id is int? ? id : this.id,
      certificateId: certificateId ?? this.certificateId,
      eventId: eventId ?? this.eventId,
      authUserId: authUserId ?? this.authUserId,
      studentName: studentName ?? this.studentName,
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      issuedAt: issuedAt ?? this.issuedAt,
      issuedByUserId: issuedByUserId is _is.UuidValue?
          ? issuedByUserId
          : this.issuedByUserId,
      verificationUrl: verificationUrl ?? this.verificationUrl,
      status: status ?? this.status,
      signatureTitle: signatureTitle ?? this.signatureTitle,
    );
  }
}

class EventCertificateUpdateTable
    extends _is.UpdateTable<EventCertificateTable> {
  EventCertificateUpdateTable(super.table);

  _is.ColumnValue<String, String> certificateId(String value) =>
      _is.ColumnValue(
        table.certificateId,
        value,
      );

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

  _is.ColumnValue<String, String> eventName(String value) => _is.ColumnValue(
    table.eventName,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> eventDate(DateTime value) =>
      _is.ColumnValue(
        table.eventDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> issuedAt(DateTime value) =>
      _is.ColumnValue(
        table.issuedAt,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> issuedByUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.issuedByUserId,
    value,
  );

  _is.ColumnValue<String, String> verificationUrl(String value) =>
      _is.ColumnValue(
        table.verificationUrl,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> signatureTitle(String value) =>
      _is.ColumnValue(
        table.signatureTitle,
        value,
      );
}

class EventCertificateTable extends _is.Table<int?> {
  EventCertificateTable({super.tableRelation})
    : super(tableName: 'event_certificate') {
    updateTable = EventCertificateUpdateTable(this);
    certificateId = _is.ColumnString(
      'certificateId',
      this,
    );
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
    eventName = _is.ColumnString(
      'eventName',
      this,
    );
    eventDate = _is.ColumnDateTime(
      'eventDate',
      this,
    );
    issuedAt = _is.ColumnDateTime(
      'issuedAt',
      this,
      hasDefault: true,
    );
    issuedByUserId = _is.ColumnUuid(
      'issuedByUserId',
      this,
    );
    verificationUrl = _is.ColumnString(
      'verificationUrl',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    signatureTitle = _is.ColumnString(
      'signatureTitle',
      this,
    );
  }

  late final EventCertificateUpdateTable updateTable;

  late final _is.ColumnString certificateId;

  late final _is.ColumnInt eventId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString studentName;

  late final _is.ColumnString eventName;

  late final _is.ColumnDateTime eventDate;

  late final _is.ColumnDateTime issuedAt;

  late final _is.ColumnUuid issuedByUserId;

  late final _is.ColumnString verificationUrl;

  late final _is.ColumnString status;

  late final _is.ColumnString signatureTitle;

  @override
  List<_is.Column> get columns => [
    id,
    certificateId,
    eventId,
    authUserId,
    studentName,
    eventName,
    eventDate,
    issuedAt,
    issuedByUserId,
    verificationUrl,
    status,
    signatureTitle,
  ];
}

class EventCertificateInclude extends _is.IncludeObject {
  EventCertificateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EventCertificate.t;
}

class EventCertificateIncludeList extends _is.IncludeList {
  EventCertificateIncludeList._({
    _is.WhereExpressionBuilder<EventCertificateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EventCertificate.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EventCertificate.t;
}

class EventCertificateRepository {
  const EventCertificateRepository._();

  /// Returns a list of [EventCertificate]s matching the given query parameters.
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
  Future<List<EventCertificate>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventCertificateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventCertificateTable>? orderBy,
    _is.OrderByListBuilder<EventCertificateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EventCertificate>(
      where: where?.call(EventCertificate.t),
      orderBy: orderBy?.call(EventCertificate.t),
      orderByList: orderByList?.call(EventCertificate.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EventCertificate] matching the given query parameters.
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
  Future<EventCertificate?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventCertificateTable>? where,
    int? offset,
    _is.OrderByBuilder<EventCertificateTable>? orderBy,
    _is.OrderByListBuilder<EventCertificateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EventCertificate>(
      where: where?.call(EventCertificate.t),
      orderBy: orderBy?.call(EventCertificate.t),
      orderByList: orderByList?.call(EventCertificate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EventCertificate] by its [id] or null if no such row exists.
  Future<EventCertificate?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EventCertificate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EventCertificate]s in the list and returns the inserted rows.
  ///
  /// The returned [EventCertificate]s will have their `id` fields set.
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
  Future<List<EventCertificate>> insert(
    _is.DatabaseSession session,
    List<EventCertificate> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EventCertificate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EventCertificate] and returns the inserted row.
  ///
  /// The returned [EventCertificate] will have its `id` field set.
  Future<EventCertificate> insertRow(
    _is.DatabaseSession session,
    EventCertificate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EventCertificate>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EventCertificate]s in the list and returns the resulting rows.
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
  /// The returned [EventCertificate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventCertificate>> upsert(
    _is.DatabaseSession session,
    List<EventCertificate> rows, {
    required _is.ColumnSelections<EventCertificateTable> conflictColumns,
    _is.ColumnSelections<EventCertificateTable>? updateColumns,
    _is.WhereExpressionBuilder<EventCertificateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EventCertificate>(
      rows,
      conflictColumns: conflictColumns(EventCertificate.t),
      updateColumns: updateColumns?.call(EventCertificate.t),
      updateWhere: updateWhere?.call(EventCertificate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EventCertificate] and returns the resulting row.
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
  /// The returned [EventCertificate] will have its `id` field set.
  Future<EventCertificate?> upsertRow(
    _is.DatabaseSession session,
    EventCertificate row, {
    required _is.ColumnSelections<EventCertificateTable> conflictColumns,
    _is.ColumnSelections<EventCertificateTable>? updateColumns,
    _is.WhereExpressionBuilder<EventCertificateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EventCertificate>(
      row,
      conflictColumns: conflictColumns(EventCertificate.t),
      updateColumns: updateColumns?.call(EventCertificate.t),
      updateWhere: updateWhere?.call(EventCertificate.t),
      transaction: transaction,
    );
  }

  /// Updates all [EventCertificate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventCertificate>> update(
    _is.DatabaseSession session,
    List<EventCertificate> rows, {
    _is.ColumnSelections<EventCertificateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EventCertificate>(
      rows,
      columns: columns?.call(EventCertificate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EventCertificate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EventCertificate> updateRow(
    _is.DatabaseSession session,
    EventCertificate row, {
    _is.ColumnSelections<EventCertificateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EventCertificate>(
      row,
      columns: columns?.call(EventCertificate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EventCertificate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EventCertificate?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EventCertificateUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EventCertificate>(
      id,
      columnValues: columnValues(EventCertificate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EventCertificate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EventCertificate>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EventCertificateUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<EventCertificateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EventCertificateTable>? orderBy,
    _is.OrderByListBuilder<EventCertificateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EventCertificate>(
      columnValues: columnValues(EventCertificate.t.updateTable),
      where: where(EventCertificate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventCertificate.t),
      orderByList: orderByList?.call(EventCertificate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EventCertificate]s in the list and returns the deleted rows.
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
  Future<List<EventCertificate>> delete(
    _is.DatabaseSession session,
    List<EventCertificate> rows, {
    _is.OrderByBuilder<EventCertificateTable>? orderBy,
    _is.OrderByListBuilder<EventCertificateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EventCertificate>(
      rows,
      orderBy: orderBy?.call(EventCertificate.t),
      orderByList: orderByList?.call(EventCertificate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EventCertificate].
  Future<EventCertificate> deleteRow(
    _is.DatabaseSession session,
    EventCertificate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EventCertificate>(
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
  Future<List<EventCertificate>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventCertificateTable> where,
    _is.OrderByBuilder<EventCertificateTable>? orderBy,
    _is.OrderByListBuilder<EventCertificateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EventCertificate>(
      where: where(EventCertificate.t),
      orderBy: orderBy?.call(EventCertificate.t),
      orderByList: orderByList?.call(EventCertificate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EventCertificateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EventCertificate>(
      where: where?.call(EventCertificate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EventCertificate] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EventCertificateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EventCertificate>(
      where: where(EventCertificate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
