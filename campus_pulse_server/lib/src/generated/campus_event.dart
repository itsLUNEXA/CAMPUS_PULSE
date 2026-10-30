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

abstract class CampusEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CampusEvent._({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.startTime,
    this.endTime,
    required this.venue,
    this.bannerUrl,
    required this.organizerAuthUserId,
    required this.organizerName,
    int? rsvpCount,
    String? approvalStatus,
    this.rejectionReason,
    this.registrationDeadline,
    bool? isTeamEvent,
    int? minTeamSize,
    int? maxTeamSize,
    int? submissionVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : rsvpCount = rsvpCount ?? 0,
       approvalStatus = approvalStatus ?? 'approved',
       isTeamEvent = isTeamEvent ?? false,
       minTeamSize = minTeamSize ?? 1,
       maxTeamSize = maxTeamSize ?? 1,
       submissionVersion = submissionVersion ?? 1,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory CampusEvent({
    int? id,
    required String title,
    required String description,
    required String category,
    required DateTime startTime,
    DateTime? endTime,
    required String venue,
    String? bannerUrl,
    required _is.UuidValue organizerAuthUserId,
    required String organizerName,
    int? rsvpCount,
    String? approvalStatus,
    String? rejectionReason,
    DateTime? registrationDeadline,
    bool? isTeamEvent,
    int? minTeamSize,
    int? maxTeamSize,
    int? submissionVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CampusEventImpl;

  factory CampusEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusEvent(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: jsonSerialization['category'] as String,
      startTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startTime'],
      ),
      endTime: jsonSerialization['endTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      venue: jsonSerialization['venue'] as String,
      bannerUrl: jsonSerialization['bannerUrl'] as String?,
      organizerAuthUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizerAuthUserId'],
      ),
      organizerName: jsonSerialization['organizerName'] as String,
      rsvpCount: jsonSerialization['rsvpCount'] as int?,
      approvalStatus: jsonSerialization['approvalStatus'] as String?,
      rejectionReason: jsonSerialization['rejectionReason'] as String?,
      registrationDeadline: jsonSerialization['registrationDeadline'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['registrationDeadline'],
            ),
      isTeamEvent: jsonSerialization['isTeamEvent'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isTeamEvent']),
      minTeamSize: jsonSerialization['minTeamSize'] as int?,
      maxTeamSize: jsonSerialization['maxTeamSize'] as int?,
      submissionVersion: jsonSerialization['submissionVersion'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CampusEventTable();

  static const db = CampusEventRepository._();

  @override
  int? id;

  String title;

  String description;

  String category;

  DateTime startTime;

  DateTime? endTime;

  String venue;

  String? bannerUrl;

  _is.UuidValue organizerAuthUserId;

  String organizerName;

  int rsvpCount;

  String approvalStatus;

  String? rejectionReason;

  DateTime? registrationDeadline;

  bool isTeamEvent;

  int minTeamSize;

  int maxTeamSize;

  int submissionVersion;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CampusEvent copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    DateTime? startTime,
    DateTime? endTime,
    String? venue,
    String? bannerUrl,
    _is.UuidValue? organizerAuthUserId,
    String? organizerName,
    int? rsvpCount,
    String? approvalStatus,
    String? rejectionReason,
    DateTime? registrationDeadline,
    bool? isTeamEvent,
    int? minTeamSize,
    int? maxTeamSize,
    int? submissionVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusEvent',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'category': category,
      'startTime': startTime.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      'venue': venue,
      if (bannerUrl != null) 'bannerUrl': bannerUrl,
      'organizerAuthUserId': organizerAuthUserId.toJson(),
      'organizerName': organizerName,
      'rsvpCount': rsvpCount,
      'approvalStatus': approvalStatus,
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      if (registrationDeadline != null)
        'registrationDeadline': registrationDeadline?.toJson(),
      'isTeamEvent': isTeamEvent,
      'minTeamSize': minTeamSize,
      'maxTeamSize': maxTeamSize,
      'submissionVersion': submissionVersion,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusEvent',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'category': category,
      'startTime': startTime.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      'venue': venue,
      if (bannerUrl != null) 'bannerUrl': bannerUrl,
      'organizerAuthUserId': organizerAuthUserId.toJson(),
      'organizerName': organizerName,
      'rsvpCount': rsvpCount,
      'approvalStatus': approvalStatus,
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      if (registrationDeadline != null)
        'registrationDeadline': registrationDeadline?.toJson(),
      'isTeamEvent': isTeamEvent,
      'minTeamSize': minTeamSize,
      'maxTeamSize': maxTeamSize,
      'submissionVersion': submissionVersion,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static CampusEventInclude include() {
    return CampusEventInclude._();
  }

  static CampusEventIncludeList includeList({
    _is.WhereExpressionBuilder<CampusEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusEventTable>? orderBy,
    _is.OrderByListBuilder<CampusEventTable>? orderByList,
    CampusEventInclude? include,
  }) {
    return CampusEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusEvent.t),
      orderByList: orderByList?.call(CampusEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusEventImpl extends CampusEvent {
  _CampusEventImpl({
    int? id,
    required String title,
    required String description,
    required String category,
    required DateTime startTime,
    DateTime? endTime,
    required String venue,
    String? bannerUrl,
    required _is.UuidValue organizerAuthUserId,
    required String organizerName,
    int? rsvpCount,
    String? approvalStatus,
    String? rejectionReason,
    DateTime? registrationDeadline,
    bool? isTeamEvent,
    int? minTeamSize,
    int? maxTeamSize,
    int? submissionVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         title: title,
         description: description,
         category: category,
         startTime: startTime,
         endTime: endTime,
         venue: venue,
         bannerUrl: bannerUrl,
         organizerAuthUserId: organizerAuthUserId,
         organizerName: organizerName,
         rsvpCount: rsvpCount,
         approvalStatus: approvalStatus,
         rejectionReason: rejectionReason,
         registrationDeadline: registrationDeadline,
         isTeamEvent: isTeamEvent,
         minTeamSize: minTeamSize,
         maxTeamSize: maxTeamSize,
         submissionVersion: submissionVersion,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CampusEvent copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    String? category,
    DateTime? startTime,
    Object? endTime = _Undefined,
    String? venue,
    Object? bannerUrl = _Undefined,
    _is.UuidValue? organizerAuthUserId,
    String? organizerName,
    int? rsvpCount,
    String? approvalStatus,
    Object? rejectionReason = _Undefined,
    Object? registrationDeadline = _Undefined,
    bool? isTeamEvent,
    int? minTeamSize,
    int? maxTeamSize,
    int? submissionVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CampusEvent(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      startTime: startTime ?? this.startTime,
      endTime: endTime is DateTime? ? endTime : this.endTime,
      venue: venue ?? this.venue,
      bannerUrl: bannerUrl is String? ? bannerUrl : this.bannerUrl,
      organizerAuthUserId: organizerAuthUserId ?? this.organizerAuthUserId,
      organizerName: organizerName ?? this.organizerName,
      rsvpCount: rsvpCount ?? this.rsvpCount,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      rejectionReason: rejectionReason is String?
          ? rejectionReason
          : this.rejectionReason,
      registrationDeadline: registrationDeadline is DateTime?
          ? registrationDeadline
          : this.registrationDeadline,
      isTeamEvent: isTeamEvent ?? this.isTeamEvent,
      minTeamSize: minTeamSize ?? this.minTeamSize,
      maxTeamSize: maxTeamSize ?? this.maxTeamSize,
      submissionVersion: submissionVersion ?? this.submissionVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CampusEventUpdateTable extends _is.UpdateTable<CampusEventTable> {
  CampusEventUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startTime(DateTime value) =>
      _is.ColumnValue(
        table.startTime,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endTime(DateTime? value) =>
      _is.ColumnValue(
        table.endTime,
        value,
      );

  _is.ColumnValue<String, String> venue(String value) => _is.ColumnValue(
    table.venue,
    value,
  );

  _is.ColumnValue<String, String> bannerUrl(String? value) => _is.ColumnValue(
    table.bannerUrl,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> organizerAuthUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.organizerAuthUserId,
    value,
  );

  _is.ColumnValue<String, String> organizerName(String value) =>
      _is.ColumnValue(
        table.organizerName,
        value,
      );

  _is.ColumnValue<int, int> rsvpCount(int value) => _is.ColumnValue(
    table.rsvpCount,
    value,
  );

  _is.ColumnValue<String, String> approvalStatus(String value) =>
      _is.ColumnValue(
        table.approvalStatus,
        value,
      );

  _is.ColumnValue<String, String> rejectionReason(String? value) =>
      _is.ColumnValue(
        table.rejectionReason,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> registrationDeadline(DateTime? value) =>
      _is.ColumnValue(
        table.registrationDeadline,
        value,
      );

  _is.ColumnValue<bool, bool> isTeamEvent(bool value) => _is.ColumnValue(
    table.isTeamEvent,
    value,
  );

  _is.ColumnValue<int, int> minTeamSize(int value) => _is.ColumnValue(
    table.minTeamSize,
    value,
  );

  _is.ColumnValue<int, int> maxTeamSize(int value) => _is.ColumnValue(
    table.maxTeamSize,
    value,
  );

  _is.ColumnValue<int, int> submissionVersion(int value) => _is.ColumnValue(
    table.submissionVersion,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class CampusEventTable extends _is.Table<int?> {
  CampusEventTable({super.tableRelation}) : super(tableName: 'campus_event') {
    updateTable = CampusEventUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    startTime = _is.ColumnDateTime(
      'startTime',
      this,
    );
    endTime = _is.ColumnDateTime(
      'endTime',
      this,
    );
    venue = _is.ColumnString(
      'venue',
      this,
    );
    bannerUrl = _is.ColumnString(
      'bannerUrl',
      this,
    );
    organizerAuthUserId = _is.ColumnUuid(
      'organizerAuthUserId',
      this,
    );
    organizerName = _is.ColumnString(
      'organizerName',
      this,
    );
    rsvpCount = _is.ColumnInt(
      'rsvpCount',
      this,
      hasDefault: true,
    );
    approvalStatus = _is.ColumnString(
      'approvalStatus',
      this,
      hasDefault: true,
    );
    rejectionReason = _is.ColumnString(
      'rejectionReason',
      this,
    );
    registrationDeadline = _is.ColumnDateTime(
      'registrationDeadline',
      this,
    );
    isTeamEvent = _is.ColumnBool(
      'isTeamEvent',
      this,
      hasDefault: true,
    );
    minTeamSize = _is.ColumnInt(
      'minTeamSize',
      this,
      hasDefault: true,
    );
    maxTeamSize = _is.ColumnInt(
      'maxTeamSize',
      this,
      hasDefault: true,
    );
    submissionVersion = _is.ColumnInt(
      'submissionVersion',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final CampusEventUpdateTable updateTable;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnString category;

  late final _is.ColumnDateTime startTime;

  late final _is.ColumnDateTime endTime;

  late final _is.ColumnString venue;

  late final _is.ColumnString bannerUrl;

  late final _is.ColumnUuid organizerAuthUserId;

  late final _is.ColumnString organizerName;

  late final _is.ColumnInt rsvpCount;

  late final _is.ColumnString approvalStatus;

  late final _is.ColumnString rejectionReason;

  late final _is.ColumnDateTime registrationDeadline;

  late final _is.ColumnBool isTeamEvent;

  late final _is.ColumnInt minTeamSize;

  late final _is.ColumnInt maxTeamSize;

  late final _is.ColumnInt submissionVersion;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    title,
    description,
    category,
    startTime,
    endTime,
    venue,
    bannerUrl,
    organizerAuthUserId,
    organizerName,
    rsvpCount,
    approvalStatus,
    rejectionReason,
    registrationDeadline,
    isTeamEvent,
    minTeamSize,
    maxTeamSize,
    submissionVersion,
    createdAt,
    updatedAt,
  ];
}

class CampusEventInclude extends _is.IncludeObject {
  CampusEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CampusEvent.t;
}

class CampusEventIncludeList extends _is.IncludeList {
  CampusEventIncludeList._({
    _is.WhereExpressionBuilder<CampusEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CampusEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CampusEvent.t;
}

class CampusEventRepository {
  const CampusEventRepository._();

  /// Returns a list of [CampusEvent]s matching the given query parameters.
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
  Future<List<CampusEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusEventTable>? orderBy,
    _is.OrderByListBuilder<CampusEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CampusEvent>(
      where: where?.call(CampusEvent.t),
      orderBy: orderBy?.call(CampusEvent.t),
      orderByList: orderByList?.call(CampusEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CampusEvent] matching the given query parameters.
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
  Future<CampusEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusEventTable>? where,
    int? offset,
    _is.OrderByBuilder<CampusEventTable>? orderBy,
    _is.OrderByListBuilder<CampusEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CampusEvent>(
      where: where?.call(CampusEvent.t),
      orderBy: orderBy?.call(CampusEvent.t),
      orderByList: orderByList?.call(CampusEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CampusEvent] by its [id] or null if no such row exists.
  Future<CampusEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CampusEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CampusEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [CampusEvent]s will have their `id` fields set.
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
  Future<List<CampusEvent>> insert(
    _is.DatabaseSession session,
    List<CampusEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CampusEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CampusEvent] and returns the inserted row.
  ///
  /// The returned [CampusEvent] will have its `id` field set.
  Future<CampusEvent> insertRow(
    _is.DatabaseSession session,
    CampusEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CampusEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CampusEvent]s in the list and returns the resulting rows.
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
  /// The returned [CampusEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusEvent>> upsert(
    _is.DatabaseSession session,
    List<CampusEvent> rows, {
    required _is.ColumnSelections<CampusEventTable> conflictColumns,
    _is.ColumnSelections<CampusEventTable>? updateColumns,
    _is.WhereExpressionBuilder<CampusEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CampusEvent>(
      rows,
      conflictColumns: conflictColumns(CampusEvent.t),
      updateColumns: updateColumns?.call(CampusEvent.t),
      updateWhere: updateWhere?.call(CampusEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CampusEvent] and returns the resulting row.
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
  /// The returned [CampusEvent] will have its `id` field set.
  Future<CampusEvent?> upsertRow(
    _is.DatabaseSession session,
    CampusEvent row, {
    required _is.ColumnSelections<CampusEventTable> conflictColumns,
    _is.ColumnSelections<CampusEventTable>? updateColumns,
    _is.WhereExpressionBuilder<CampusEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CampusEvent>(
      row,
      conflictColumns: conflictColumns(CampusEvent.t),
      updateColumns: updateColumns?.call(CampusEvent.t),
      updateWhere: updateWhere?.call(CampusEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [CampusEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusEvent>> update(
    _is.DatabaseSession session,
    List<CampusEvent> rows, {
    _is.ColumnSelections<CampusEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CampusEvent>(
      rows,
      columns: columns?.call(CampusEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CampusEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CampusEvent> updateRow(
    _is.DatabaseSession session,
    CampusEvent row, {
    _is.ColumnSelections<CampusEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CampusEvent>(
      row,
      columns: columns?.call(CampusEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CampusEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CampusEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CampusEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CampusEvent>(
      id,
      columnValues: columnValues(CampusEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CampusEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CampusEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CampusEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusEventTable>? orderBy,
    _is.OrderByListBuilder<CampusEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CampusEvent>(
      columnValues: columnValues(CampusEvent.t.updateTable),
      where: where(CampusEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusEvent.t),
      orderByList: orderByList?.call(CampusEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CampusEvent]s in the list and returns the deleted rows.
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
  Future<List<CampusEvent>> delete(
    _is.DatabaseSession session,
    List<CampusEvent> rows, {
    _is.OrderByBuilder<CampusEventTable>? orderBy,
    _is.OrderByListBuilder<CampusEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CampusEvent>(
      rows,
      orderBy: orderBy?.call(CampusEvent.t),
      orderByList: orderByList?.call(CampusEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CampusEvent].
  Future<CampusEvent> deleteRow(
    _is.DatabaseSession session,
    CampusEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CampusEvent>(
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
  Future<List<CampusEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CampusEventTable> where,
    _is.OrderByBuilder<CampusEventTable>? orderBy,
    _is.OrderByListBuilder<CampusEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CampusEvent>(
      where: where(CampusEvent.t),
      orderBy: orderBy?.call(CampusEvent.t),
      orderByList: orderByList?.call(CampusEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CampusEvent>(
      where: where?.call(CampusEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CampusEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CampusEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CampusEvent>(
      where: where(CampusEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
