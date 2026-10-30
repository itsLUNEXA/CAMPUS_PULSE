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

abstract class CampusClub
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CampusClub._({
    this.id,
    required this.name,
    required this.tagline,
    required this.category,
    required this.description,
    this.logoUrl,
    required this.leadName,
    required this.leadEmail,
    required this.techTeamLead,
    required this.techTeamEmail,
    required this.managementLead,
    required this.managementEmail,
    int? membersCount,
    bool? recruitmentOpen,
    this.meetingSchedule,
    DateTime? createdAt,
  }) : membersCount = membersCount ?? 0,
       recruitmentOpen = recruitmentOpen ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory CampusClub({
    int? id,
    required String name,
    required String tagline,
    required String category,
    required String description,
    String? logoUrl,
    required String leadName,
    required String leadEmail,
    required String techTeamLead,
    required String techTeamEmail,
    required String managementLead,
    required String managementEmail,
    int? membersCount,
    bool? recruitmentOpen,
    String? meetingSchedule,
    DateTime? createdAt,
  }) = _CampusClubImpl;

  factory CampusClub.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusClub(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      tagline: jsonSerialization['tagline'] as String,
      category: jsonSerialization['category'] as String,
      description: jsonSerialization['description'] as String,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      leadName: jsonSerialization['leadName'] as String,
      leadEmail: jsonSerialization['leadEmail'] as String,
      techTeamLead: jsonSerialization['techTeamLead'] as String,
      techTeamEmail: jsonSerialization['techTeamEmail'] as String,
      managementLead: jsonSerialization['managementLead'] as String,
      managementEmail: jsonSerialization['managementEmail'] as String,
      membersCount: jsonSerialization['membersCount'] as int?,
      recruitmentOpen: jsonSerialization['recruitmentOpen'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['recruitmentOpen'],
            ),
      meetingSchedule: jsonSerialization['meetingSchedule'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CampusClubTable();

  static const db = CampusClubRepository._();

  @override
  int? id;

  String name;

  String tagline;

  String category;

  String description;

  String? logoUrl;

  String leadName;

  String leadEmail;

  String techTeamLead;

  String techTeamEmail;

  String managementLead;

  String managementEmail;

  int membersCount;

  bool recruitmentOpen;

  String? meetingSchedule;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CampusClub]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CampusClub copyWith({
    int? id,
    String? name,
    String? tagline,
    String? category,
    String? description,
    String? logoUrl,
    String? leadName,
    String? leadEmail,
    String? techTeamLead,
    String? techTeamEmail,
    String? managementLead,
    String? managementEmail,
    int? membersCount,
    bool? recruitmentOpen,
    String? meetingSchedule,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusClub',
      if (id != null) 'id': id,
      'name': name,
      'tagline': tagline,
      'category': category,
      'description': description,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'leadName': leadName,
      'leadEmail': leadEmail,
      'techTeamLead': techTeamLead,
      'techTeamEmail': techTeamEmail,
      'managementLead': managementLead,
      'managementEmail': managementEmail,
      'membersCount': membersCount,
      'recruitmentOpen': recruitmentOpen,
      if (meetingSchedule != null) 'meetingSchedule': meetingSchedule,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusClub',
      if (id != null) 'id': id,
      'name': name,
      'tagline': tagline,
      'category': category,
      'description': description,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'leadName': leadName,
      'leadEmail': leadEmail,
      'techTeamLead': techTeamLead,
      'techTeamEmail': techTeamEmail,
      'managementLead': managementLead,
      'managementEmail': managementEmail,
      'membersCount': membersCount,
      'recruitmentOpen': recruitmentOpen,
      if (meetingSchedule != null) 'meetingSchedule': meetingSchedule,
      'createdAt': createdAt.toJson(),
    };
  }

  static CampusClubInclude include() {
    return CampusClubInclude._();
  }

  static CampusClubIncludeList includeList({
    _is.WhereExpressionBuilder<CampusClubTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusClubTable>? orderBy,
    _is.OrderByListBuilder<CampusClubTable>? orderByList,
    CampusClubInclude? include,
  }) {
    return CampusClubIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusClub.t),
      orderByList: orderByList?.call(CampusClub.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusClubImpl extends CampusClub {
  _CampusClubImpl({
    int? id,
    required String name,
    required String tagline,
    required String category,
    required String description,
    String? logoUrl,
    required String leadName,
    required String leadEmail,
    required String techTeamLead,
    required String techTeamEmail,
    required String managementLead,
    required String managementEmail,
    int? membersCount,
    bool? recruitmentOpen,
    String? meetingSchedule,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         tagline: tagline,
         category: category,
         description: description,
         logoUrl: logoUrl,
         leadName: leadName,
         leadEmail: leadEmail,
         techTeamLead: techTeamLead,
         techTeamEmail: techTeamEmail,
         managementLead: managementLead,
         managementEmail: managementEmail,
         membersCount: membersCount,
         recruitmentOpen: recruitmentOpen,
         meetingSchedule: meetingSchedule,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CampusClub]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CampusClub copyWith({
    Object? id = _Undefined,
    String? name,
    String? tagline,
    String? category,
    String? description,
    Object? logoUrl = _Undefined,
    String? leadName,
    String? leadEmail,
    String? techTeamLead,
    String? techTeamEmail,
    String? managementLead,
    String? managementEmail,
    int? membersCount,
    bool? recruitmentOpen,
    Object? meetingSchedule = _Undefined,
    DateTime? createdAt,
  }) {
    return CampusClub(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      category: category ?? this.category,
      description: description ?? this.description,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      leadName: leadName ?? this.leadName,
      leadEmail: leadEmail ?? this.leadEmail,
      techTeamLead: techTeamLead ?? this.techTeamLead,
      techTeamEmail: techTeamEmail ?? this.techTeamEmail,
      managementLead: managementLead ?? this.managementLead,
      managementEmail: managementEmail ?? this.managementEmail,
      membersCount: membersCount ?? this.membersCount,
      recruitmentOpen: recruitmentOpen ?? this.recruitmentOpen,
      meetingSchedule: meetingSchedule is String?
          ? meetingSchedule
          : this.meetingSchedule,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CampusClubUpdateTable extends _is.UpdateTable<CampusClubTable> {
  CampusClubUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> tagline(String value) => _is.ColumnValue(
    table.tagline,
    value,
  );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> logoUrl(String? value) => _is.ColumnValue(
    table.logoUrl,
    value,
  );

  _is.ColumnValue<String, String> leadName(String value) => _is.ColumnValue(
    table.leadName,
    value,
  );

  _is.ColumnValue<String, String> leadEmail(String value) => _is.ColumnValue(
    table.leadEmail,
    value,
  );

  _is.ColumnValue<String, String> techTeamLead(String value) => _is.ColumnValue(
    table.techTeamLead,
    value,
  );

  _is.ColumnValue<String, String> techTeamEmail(String value) =>
      _is.ColumnValue(
        table.techTeamEmail,
        value,
      );

  _is.ColumnValue<String, String> managementLead(String value) =>
      _is.ColumnValue(
        table.managementLead,
        value,
      );

  _is.ColumnValue<String, String> managementEmail(String value) =>
      _is.ColumnValue(
        table.managementEmail,
        value,
      );

  _is.ColumnValue<int, int> membersCount(int value) => _is.ColumnValue(
    table.membersCount,
    value,
  );

  _is.ColumnValue<bool, bool> recruitmentOpen(bool value) => _is.ColumnValue(
    table.recruitmentOpen,
    value,
  );

  _is.ColumnValue<String, String> meetingSchedule(String? value) =>
      _is.ColumnValue(
        table.meetingSchedule,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class CampusClubTable extends _is.Table<int?> {
  CampusClubTable({super.tableRelation}) : super(tableName: 'campus_clubs') {
    updateTable = CampusClubUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    tagline = _is.ColumnString(
      'tagline',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    logoUrl = _is.ColumnString(
      'logoUrl',
      this,
    );
    leadName = _is.ColumnString(
      'leadName',
      this,
    );
    leadEmail = _is.ColumnString(
      'leadEmail',
      this,
    );
    techTeamLead = _is.ColumnString(
      'techTeamLead',
      this,
    );
    techTeamEmail = _is.ColumnString(
      'techTeamEmail',
      this,
    );
    managementLead = _is.ColumnString(
      'managementLead',
      this,
    );
    managementEmail = _is.ColumnString(
      'managementEmail',
      this,
    );
    membersCount = _is.ColumnInt(
      'membersCount',
      this,
      hasDefault: true,
    );
    recruitmentOpen = _is.ColumnBool(
      'recruitmentOpen',
      this,
      hasDefault: true,
    );
    meetingSchedule = _is.ColumnString(
      'meetingSchedule',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CampusClubUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString tagline;

  late final _is.ColumnString category;

  late final _is.ColumnString description;

  late final _is.ColumnString logoUrl;

  late final _is.ColumnString leadName;

  late final _is.ColumnString leadEmail;

  late final _is.ColumnString techTeamLead;

  late final _is.ColumnString techTeamEmail;

  late final _is.ColumnString managementLead;

  late final _is.ColumnString managementEmail;

  late final _is.ColumnInt membersCount;

  late final _is.ColumnBool recruitmentOpen;

  late final _is.ColumnString meetingSchedule;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    tagline,
    category,
    description,
    logoUrl,
    leadName,
    leadEmail,
    techTeamLead,
    techTeamEmail,
    managementLead,
    managementEmail,
    membersCount,
    recruitmentOpen,
    meetingSchedule,
    createdAt,
  ];
}

class CampusClubInclude extends _is.IncludeObject {
  CampusClubInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CampusClub.t;
}

class CampusClubIncludeList extends _is.IncludeList {
  CampusClubIncludeList._({
    _is.WhereExpressionBuilder<CampusClubTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CampusClub.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CampusClub.t;
}

class CampusClubRepository {
  const CampusClubRepository._();

  /// Returns a list of [CampusClub]s matching the given query parameters.
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
  Future<List<CampusClub>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusClubTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusClubTable>? orderBy,
    _is.OrderByListBuilder<CampusClubTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CampusClub>(
      where: where?.call(CampusClub.t),
      orderBy: orderBy?.call(CampusClub.t),
      orderByList: orderByList?.call(CampusClub.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CampusClub] matching the given query parameters.
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
  Future<CampusClub?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusClubTable>? where,
    int? offset,
    _is.OrderByBuilder<CampusClubTable>? orderBy,
    _is.OrderByListBuilder<CampusClubTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CampusClub>(
      where: where?.call(CampusClub.t),
      orderBy: orderBy?.call(CampusClub.t),
      orderByList: orderByList?.call(CampusClub.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CampusClub] by its [id] or null if no such row exists.
  Future<CampusClub?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CampusClub>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CampusClub]s in the list and returns the inserted rows.
  ///
  /// The returned [CampusClub]s will have their `id` fields set.
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
  Future<List<CampusClub>> insert(
    _is.DatabaseSession session,
    List<CampusClub> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CampusClub>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CampusClub] and returns the inserted row.
  ///
  /// The returned [CampusClub] will have its `id` field set.
  Future<CampusClub> insertRow(
    _is.DatabaseSession session,
    CampusClub row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CampusClub>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CampusClub]s in the list and returns the resulting rows.
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
  /// The returned [CampusClub]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusClub>> upsert(
    _is.DatabaseSession session,
    List<CampusClub> rows, {
    required _is.ColumnSelections<CampusClubTable> conflictColumns,
    _is.ColumnSelections<CampusClubTable>? updateColumns,
    _is.WhereExpressionBuilder<CampusClubTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CampusClub>(
      rows,
      conflictColumns: conflictColumns(CampusClub.t),
      updateColumns: updateColumns?.call(CampusClub.t),
      updateWhere: updateWhere?.call(CampusClub.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CampusClub] and returns the resulting row.
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
  /// The returned [CampusClub] will have its `id` field set.
  Future<CampusClub?> upsertRow(
    _is.DatabaseSession session,
    CampusClub row, {
    required _is.ColumnSelections<CampusClubTable> conflictColumns,
    _is.ColumnSelections<CampusClubTable>? updateColumns,
    _is.WhereExpressionBuilder<CampusClubTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CampusClub>(
      row,
      conflictColumns: conflictColumns(CampusClub.t),
      updateColumns: updateColumns?.call(CampusClub.t),
      updateWhere: updateWhere?.call(CampusClub.t),
      transaction: transaction,
    );
  }

  /// Updates all [CampusClub]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusClub>> update(
    _is.DatabaseSession session,
    List<CampusClub> rows, {
    _is.ColumnSelections<CampusClubTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CampusClub>(
      rows,
      columns: columns?.call(CampusClub.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CampusClub]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CampusClub> updateRow(
    _is.DatabaseSession session,
    CampusClub row, {
    _is.ColumnSelections<CampusClubTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CampusClub>(
      row,
      columns: columns?.call(CampusClub.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CampusClub] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CampusClub?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CampusClubUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CampusClub>(
      id,
      columnValues: columnValues(CampusClub.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CampusClub]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CampusClub>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CampusClubUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CampusClubTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CampusClubTable>? orderBy,
    _is.OrderByListBuilder<CampusClubTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CampusClub>(
      columnValues: columnValues(CampusClub.t.updateTable),
      where: where(CampusClub.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusClub.t),
      orderByList: orderByList?.call(CampusClub.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CampusClub]s in the list and returns the deleted rows.
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
  Future<List<CampusClub>> delete(
    _is.DatabaseSession session,
    List<CampusClub> rows, {
    _is.OrderByBuilder<CampusClubTable>? orderBy,
    _is.OrderByListBuilder<CampusClubTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CampusClub>(
      rows,
      orderBy: orderBy?.call(CampusClub.t),
      orderByList: orderByList?.call(CampusClub.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CampusClub].
  Future<CampusClub> deleteRow(
    _is.DatabaseSession session,
    CampusClub row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CampusClub>(
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
  Future<List<CampusClub>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CampusClubTable> where,
    _is.OrderByBuilder<CampusClubTable>? orderBy,
    _is.OrderByListBuilder<CampusClubTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CampusClub>(
      where: where(CampusClub.t),
      orderBy: orderBy?.call(CampusClub.t),
      orderByList: orderByList?.call(CampusClub.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CampusClubTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CampusClub>(
      where: where?.call(CampusClub.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CampusClub] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CampusClubTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CampusClub>(
      where: where(CampusClub.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
