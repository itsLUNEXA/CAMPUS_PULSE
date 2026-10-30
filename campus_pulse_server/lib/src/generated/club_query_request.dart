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

abstract class ClubQueryRequest
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ClubQueryRequest._({
    this.id,
    required this.clubId,
    required this.clubName,
    required this.targetTeam,
    required this.senderAuthUserId,
    required this.senderName,
    required this.senderEmail,
    required this.senderBranch,
    required this.senderYear,
    required this.category,
    required this.subject,
    required this.message,
    String? status,
    this.responseMessage,
    this.responderName,
    DateTime? createdAt,
    this.respondedAt,
  }) : status = status ?? 'PENDING',
       createdAt = createdAt ?? DateTime.now();

  factory ClubQueryRequest({
    int? id,
    required int clubId,
    required String clubName,
    required String targetTeam,
    required _is.UuidValue senderAuthUserId,
    required String senderName,
    required String senderEmail,
    required String senderBranch,
    required int senderYear,
    required String category,
    required String subject,
    required String message,
    String? status,
    String? responseMessage,
    String? responderName,
    DateTime? createdAt,
    DateTime? respondedAt,
  }) = _ClubQueryRequestImpl;

  factory ClubQueryRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClubQueryRequest(
      id: jsonSerialization['id'] as int?,
      clubId: jsonSerialization['clubId'] as int,
      clubName: jsonSerialization['clubName'] as String,
      targetTeam: jsonSerialization['targetTeam'] as String,
      senderAuthUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['senderAuthUserId'],
      ),
      senderName: jsonSerialization['senderName'] as String,
      senderEmail: jsonSerialization['senderEmail'] as String,
      senderBranch: jsonSerialization['senderBranch'] as String,
      senderYear: jsonSerialization['senderYear'] as int,
      category: jsonSerialization['category'] as String,
      subject: jsonSerialization['subject'] as String,
      message: jsonSerialization['message'] as String,
      status: jsonSerialization['status'] as String?,
      responseMessage: jsonSerialization['responseMessage'] as String?,
      responderName: jsonSerialization['responderName'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      respondedAt: jsonSerialization['respondedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['respondedAt'],
            ),
    );
  }

  static final t = ClubQueryRequestTable();

  static const db = ClubQueryRequestRepository._();

  @override
  int? id;

  int clubId;

  String clubName;

  String targetTeam;

  _is.UuidValue senderAuthUserId;

  String senderName;

  String senderEmail;

  String senderBranch;

  int senderYear;

  String category;

  String subject;

  String message;

  String status;

  String? responseMessage;

  String? responderName;

  DateTime createdAt;

  DateTime? respondedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClubQueryRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ClubQueryRequest copyWith({
    int? id,
    int? clubId,
    String? clubName,
    String? targetTeam,
    _is.UuidValue? senderAuthUserId,
    String? senderName,
    String? senderEmail,
    String? senderBranch,
    int? senderYear,
    String? category,
    String? subject,
    String? message,
    String? status,
    String? responseMessage,
    String? responderName,
    DateTime? createdAt,
    DateTime? respondedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClubQueryRequest',
      if (id != null) 'id': id,
      'clubId': clubId,
      'clubName': clubName,
      'targetTeam': targetTeam,
      'senderAuthUserId': senderAuthUserId.toJson(),
      'senderName': senderName,
      'senderEmail': senderEmail,
      'senderBranch': senderBranch,
      'senderYear': senderYear,
      'category': category,
      'subject': subject,
      'message': message,
      'status': status,
      if (responseMessage != null) 'responseMessage': responseMessage,
      if (responderName != null) 'responderName': responderName,
      'createdAt': createdAt.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClubQueryRequest',
      if (id != null) 'id': id,
      'clubId': clubId,
      'clubName': clubName,
      'targetTeam': targetTeam,
      'senderAuthUserId': senderAuthUserId.toJson(),
      'senderName': senderName,
      'senderEmail': senderEmail,
      'senderBranch': senderBranch,
      'senderYear': senderYear,
      'category': category,
      'subject': subject,
      'message': message,
      'status': status,
      if (responseMessage != null) 'responseMessage': responseMessage,
      if (responderName != null) 'responderName': responderName,
      'createdAt': createdAt.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
    };
  }

  static ClubQueryRequestInclude include() {
    return ClubQueryRequestInclude._();
  }

  static ClubQueryRequestIncludeList includeList({
    _is.WhereExpressionBuilder<ClubQueryRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClubQueryRequestTable>? orderBy,
    _is.OrderByListBuilder<ClubQueryRequestTable>? orderByList,
    ClubQueryRequestInclude? include,
  }) {
    return ClubQueryRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClubQueryRequest.t),
      orderByList: orderByList?.call(ClubQueryRequest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClubQueryRequestImpl extends ClubQueryRequest {
  _ClubQueryRequestImpl({
    int? id,
    required int clubId,
    required String clubName,
    required String targetTeam,
    required _is.UuidValue senderAuthUserId,
    required String senderName,
    required String senderEmail,
    required String senderBranch,
    required int senderYear,
    required String category,
    required String subject,
    required String message,
    String? status,
    String? responseMessage,
    String? responderName,
    DateTime? createdAt,
    DateTime? respondedAt,
  }) : super._(
         id: id,
         clubId: clubId,
         clubName: clubName,
         targetTeam: targetTeam,
         senderAuthUserId: senderAuthUserId,
         senderName: senderName,
         senderEmail: senderEmail,
         senderBranch: senderBranch,
         senderYear: senderYear,
         category: category,
         subject: subject,
         message: message,
         status: status,
         responseMessage: responseMessage,
         responderName: responderName,
         createdAt: createdAt,
         respondedAt: respondedAt,
       );

  /// Returns a shallow copy of this [ClubQueryRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ClubQueryRequest copyWith({
    Object? id = _Undefined,
    int? clubId,
    String? clubName,
    String? targetTeam,
    _is.UuidValue? senderAuthUserId,
    String? senderName,
    String? senderEmail,
    String? senderBranch,
    int? senderYear,
    String? category,
    String? subject,
    String? message,
    String? status,
    Object? responseMessage = _Undefined,
    Object? responderName = _Undefined,
    DateTime? createdAt,
    Object? respondedAt = _Undefined,
  }) {
    return ClubQueryRequest(
      id: id is int? ? id : this.id,
      clubId: clubId ?? this.clubId,
      clubName: clubName ?? this.clubName,
      targetTeam: targetTeam ?? this.targetTeam,
      senderAuthUserId: senderAuthUserId ?? this.senderAuthUserId,
      senderName: senderName ?? this.senderName,
      senderEmail: senderEmail ?? this.senderEmail,
      senderBranch: senderBranch ?? this.senderBranch,
      senderYear: senderYear ?? this.senderYear,
      category: category ?? this.category,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      status: status ?? this.status,
      responseMessage: responseMessage is String?
          ? responseMessage
          : this.responseMessage,
      responderName: responderName is String?
          ? responderName
          : this.responderName,
      createdAt: createdAt ?? this.createdAt,
      respondedAt: respondedAt is DateTime? ? respondedAt : this.respondedAt,
    );
  }
}

class ClubQueryRequestUpdateTable
    extends _is.UpdateTable<ClubQueryRequestTable> {
  ClubQueryRequestUpdateTable(super.table);

  _is.ColumnValue<int, int> clubId(int value) => _is.ColumnValue(
    table.clubId,
    value,
  );

  _is.ColumnValue<String, String> clubName(String value) => _is.ColumnValue(
    table.clubName,
    value,
  );

  _is.ColumnValue<String, String> targetTeam(String value) => _is.ColumnValue(
    table.targetTeam,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> senderAuthUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.senderAuthUserId,
    value,
  );

  _is.ColumnValue<String, String> senderName(String value) => _is.ColumnValue(
    table.senderName,
    value,
  );

  _is.ColumnValue<String, String> senderEmail(String value) => _is.ColumnValue(
    table.senderEmail,
    value,
  );

  _is.ColumnValue<String, String> senderBranch(String value) => _is.ColumnValue(
    table.senderBranch,
    value,
  );

  _is.ColumnValue<int, int> senderYear(int value) => _is.ColumnValue(
    table.senderYear,
    value,
  );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> subject(String value) => _is.ColumnValue(
    table.subject,
    value,
  );

  _is.ColumnValue<String, String> message(String value) => _is.ColumnValue(
    table.message,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> responseMessage(String? value) =>
      _is.ColumnValue(
        table.responseMessage,
        value,
      );

  _is.ColumnValue<String, String> responderName(String? value) =>
      _is.ColumnValue(
        table.responderName,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> respondedAt(DateTime? value) =>
      _is.ColumnValue(
        table.respondedAt,
        value,
      );
}

class ClubQueryRequestTable extends _is.Table<int?> {
  ClubQueryRequestTable({super.tableRelation})
    : super(tableName: 'club_query_requests') {
    updateTable = ClubQueryRequestUpdateTable(this);
    clubId = _is.ColumnInt(
      'clubId',
      this,
    );
    clubName = _is.ColumnString(
      'clubName',
      this,
    );
    targetTeam = _is.ColumnString(
      'targetTeam',
      this,
    );
    senderAuthUserId = _is.ColumnUuid(
      'senderAuthUserId',
      this,
    );
    senderName = _is.ColumnString(
      'senderName',
      this,
    );
    senderEmail = _is.ColumnString(
      'senderEmail',
      this,
    );
    senderBranch = _is.ColumnString(
      'senderBranch',
      this,
    );
    senderYear = _is.ColumnInt(
      'senderYear',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    subject = _is.ColumnString(
      'subject',
      this,
    );
    message = _is.ColumnString(
      'message',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    responseMessage = _is.ColumnString(
      'responseMessage',
      this,
    );
    responderName = _is.ColumnString(
      'responderName',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    respondedAt = _is.ColumnDateTime(
      'respondedAt',
      this,
    );
  }

  late final ClubQueryRequestUpdateTable updateTable;

  late final _is.ColumnInt clubId;

  late final _is.ColumnString clubName;

  late final _is.ColumnString targetTeam;

  late final _is.ColumnUuid senderAuthUserId;

  late final _is.ColumnString senderName;

  late final _is.ColumnString senderEmail;

  late final _is.ColumnString senderBranch;

  late final _is.ColumnInt senderYear;

  late final _is.ColumnString category;

  late final _is.ColumnString subject;

  late final _is.ColumnString message;

  late final _is.ColumnString status;

  late final _is.ColumnString responseMessage;

  late final _is.ColumnString responderName;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime respondedAt;

  @override
  List<_is.Column> get columns => [
    id,
    clubId,
    clubName,
    targetTeam,
    senderAuthUserId,
    senderName,
    senderEmail,
    senderBranch,
    senderYear,
    category,
    subject,
    message,
    status,
    responseMessage,
    responderName,
    createdAt,
    respondedAt,
  ];
}

class ClubQueryRequestInclude extends _is.IncludeObject {
  ClubQueryRequestInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ClubQueryRequest.t;
}

class ClubQueryRequestIncludeList extends _is.IncludeList {
  ClubQueryRequestIncludeList._({
    _is.WhereExpressionBuilder<ClubQueryRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClubQueryRequest.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ClubQueryRequest.t;
}

class ClubQueryRequestRepository {
  const ClubQueryRequestRepository._();

  /// Returns a list of [ClubQueryRequest]s matching the given query parameters.
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
  Future<List<ClubQueryRequest>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClubQueryRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClubQueryRequestTable>? orderBy,
    _is.OrderByListBuilder<ClubQueryRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ClubQueryRequest>(
      where: where?.call(ClubQueryRequest.t),
      orderBy: orderBy?.call(ClubQueryRequest.t),
      orderByList: orderByList?.call(ClubQueryRequest.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ClubQueryRequest] matching the given query parameters.
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
  Future<ClubQueryRequest?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClubQueryRequestTable>? where,
    int? offset,
    _is.OrderByBuilder<ClubQueryRequestTable>? orderBy,
    _is.OrderByListBuilder<ClubQueryRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ClubQueryRequest>(
      where: where?.call(ClubQueryRequest.t),
      orderBy: orderBy?.call(ClubQueryRequest.t),
      orderByList: orderByList?.call(ClubQueryRequest.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ClubQueryRequest] by its [id] or null if no such row exists.
  Future<ClubQueryRequest?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ClubQueryRequest>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ClubQueryRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [ClubQueryRequest]s will have their `id` fields set.
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
  Future<List<ClubQueryRequest>> insert(
    _is.DatabaseSession session,
    List<ClubQueryRequest> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ClubQueryRequest>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ClubQueryRequest] and returns the inserted row.
  ///
  /// The returned [ClubQueryRequest] will have its `id` field set.
  Future<ClubQueryRequest> insertRow(
    _is.DatabaseSession session,
    ClubQueryRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClubQueryRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ClubQueryRequest]s in the list and returns the resulting rows.
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
  /// The returned [ClubQueryRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClubQueryRequest>> upsert(
    _is.DatabaseSession session,
    List<ClubQueryRequest> rows, {
    required _is.ColumnSelections<ClubQueryRequestTable> conflictColumns,
    _is.ColumnSelections<ClubQueryRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<ClubQueryRequestTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ClubQueryRequest>(
      rows,
      conflictColumns: conflictColumns(ClubQueryRequest.t),
      updateColumns: updateColumns?.call(ClubQueryRequest.t),
      updateWhere: updateWhere?.call(ClubQueryRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ClubQueryRequest] and returns the resulting row.
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
  /// The returned [ClubQueryRequest] will have its `id` field set.
  Future<ClubQueryRequest?> upsertRow(
    _is.DatabaseSession session,
    ClubQueryRequest row, {
    required _is.ColumnSelections<ClubQueryRequestTable> conflictColumns,
    _is.ColumnSelections<ClubQueryRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<ClubQueryRequestTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ClubQueryRequest>(
      row,
      conflictColumns: conflictColumns(ClubQueryRequest.t),
      updateColumns: updateColumns?.call(ClubQueryRequest.t),
      updateWhere: updateWhere?.call(ClubQueryRequest.t),
      transaction: transaction,
    );
  }

  /// Updates all [ClubQueryRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClubQueryRequest>> update(
    _is.DatabaseSession session,
    List<ClubQueryRequest> rows, {
    _is.ColumnSelections<ClubQueryRequestTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ClubQueryRequest>(
      rows,
      columns: columns?.call(ClubQueryRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ClubQueryRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClubQueryRequest> updateRow(
    _is.DatabaseSession session,
    ClubQueryRequest row, {
    _is.ColumnSelections<ClubQueryRequestTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClubQueryRequest>(
      row,
      columns: columns?.call(ClubQueryRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClubQueryRequest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ClubQueryRequest?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ClubQueryRequestUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ClubQueryRequest>(
      id,
      columnValues: columnValues(ClubQueryRequest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ClubQueryRequest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClubQueryRequest>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ClubQueryRequestUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ClubQueryRequestTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClubQueryRequestTable>? orderBy,
    _is.OrderByListBuilder<ClubQueryRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ClubQueryRequest>(
      columnValues: columnValues(ClubQueryRequest.t.updateTable),
      where: where(ClubQueryRequest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClubQueryRequest.t),
      orderByList: orderByList?.call(ClubQueryRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ClubQueryRequest]s in the list and returns the deleted rows.
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
  Future<List<ClubQueryRequest>> delete(
    _is.DatabaseSession session,
    List<ClubQueryRequest> rows, {
    _is.OrderByBuilder<ClubQueryRequestTable>? orderBy,
    _is.OrderByListBuilder<ClubQueryRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ClubQueryRequest>(
      rows,
      orderBy: orderBy?.call(ClubQueryRequest.t),
      orderByList: orderByList?.call(ClubQueryRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ClubQueryRequest].
  Future<ClubQueryRequest> deleteRow(
    _is.DatabaseSession session,
    ClubQueryRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClubQueryRequest>(
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
  Future<List<ClubQueryRequest>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClubQueryRequestTable> where,
    _is.OrderByBuilder<ClubQueryRequestTable>? orderBy,
    _is.OrderByListBuilder<ClubQueryRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ClubQueryRequest>(
      where: where(ClubQueryRequest.t),
      orderBy: orderBy?.call(ClubQueryRequest.t),
      orderByList: orderByList?.call(ClubQueryRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClubQueryRequestTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ClubQueryRequest>(
      where: where?.call(ClubQueryRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ClubQueryRequest] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClubQueryRequestTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ClubQueryRequest>(
      where: where(ClubQueryRequest.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
