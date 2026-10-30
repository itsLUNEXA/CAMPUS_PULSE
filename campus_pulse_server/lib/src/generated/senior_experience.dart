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

abstract class SeniorExperience
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SeniorExperience._({
    this.id,
    required this.companyName,
    required this.seniorName,
    required this.seniorBranch,
    required this.batchYear,
    required this.placedRole,
    this.packageOffered,
    int? difficultyRating,
    required this.interviewQuestions,
    required this.experienceReview,
    required this.tipsForJuniors,
    this.contactHandle,
    bool? verified,
    DateTime? createdAt,
  }) : difficultyRating = difficultyRating ?? 3,
       verified = verified ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory SeniorExperience({
    int? id,
    required String companyName,
    required String seniorName,
    required String seniorBranch,
    required int batchYear,
    required String placedRole,
    String? packageOffered,
    int? difficultyRating,
    required List<String> interviewQuestions,
    required String experienceReview,
    required String tipsForJuniors,
    String? contactHandle,
    bool? verified,
    DateTime? createdAt,
  }) = _SeniorExperienceImpl;

  factory SeniorExperience.fromJson(Map<String, dynamic> jsonSerialization) {
    return SeniorExperience(
      id: jsonSerialization['id'] as int?,
      companyName: jsonSerialization['companyName'] as String,
      seniorName: jsonSerialization['seniorName'] as String,
      seniorBranch: jsonSerialization['seniorBranch'] as String,
      batchYear: jsonSerialization['batchYear'] as int,
      placedRole: jsonSerialization['placedRole'] as String,
      packageOffered: jsonSerialization['packageOffered'] as String?,
      difficultyRating: jsonSerialization['difficultyRating'] as int?,
      interviewQuestions: _i2t5n14n.Protocol().deserialize<List<String>>(
        jsonSerialization['interviewQuestions'],
      ),
      experienceReview: jsonSerialization['experienceReview'] as String,
      tipsForJuniors: jsonSerialization['tipsForJuniors'] as String,
      contactHandle: jsonSerialization['contactHandle'] as String?,
      verified: jsonSerialization['verified'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['verified']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = SeniorExperienceTable();

  static const db = SeniorExperienceRepository._();

  @override
  int? id;

  String companyName;

  String seniorName;

  String seniorBranch;

  int batchYear;

  String placedRole;

  String? packageOffered;

  int difficultyRating;

  List<String> interviewQuestions;

  String experienceReview;

  String tipsForJuniors;

  String? contactHandle;

  bool verified;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SeniorExperience]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SeniorExperience copyWith({
    int? id,
    String? companyName,
    String? seniorName,
    String? seniorBranch,
    int? batchYear,
    String? placedRole,
    String? packageOffered,
    int? difficultyRating,
    List<String>? interviewQuestions,
    String? experienceReview,
    String? tipsForJuniors,
    String? contactHandle,
    bool? verified,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SeniorExperience',
      if (id != null) 'id': id,
      'companyName': companyName,
      'seniorName': seniorName,
      'seniorBranch': seniorBranch,
      'batchYear': batchYear,
      'placedRole': placedRole,
      if (packageOffered != null) 'packageOffered': packageOffered,
      'difficultyRating': difficultyRating,
      'interviewQuestions': interviewQuestions.toJson(),
      'experienceReview': experienceReview,
      'tipsForJuniors': tipsForJuniors,
      if (contactHandle != null) 'contactHandle': contactHandle,
      'verified': verified,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SeniorExperience',
      if (id != null) 'id': id,
      'companyName': companyName,
      'seniorName': seniorName,
      'seniorBranch': seniorBranch,
      'batchYear': batchYear,
      'placedRole': placedRole,
      if (packageOffered != null) 'packageOffered': packageOffered,
      'difficultyRating': difficultyRating,
      'interviewQuestions': interviewQuestions.toJson(),
      'experienceReview': experienceReview,
      'tipsForJuniors': tipsForJuniors,
      if (contactHandle != null) 'contactHandle': contactHandle,
      'verified': verified,
      'createdAt': createdAt.toJson(),
    };
  }

  static SeniorExperienceInclude include() {
    return SeniorExperienceInclude._();
  }

  static SeniorExperienceIncludeList includeList({
    _is.WhereExpressionBuilder<SeniorExperienceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SeniorExperienceTable>? orderBy,
    _is.OrderByListBuilder<SeniorExperienceTable>? orderByList,
    SeniorExperienceInclude? include,
  }) {
    return SeniorExperienceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SeniorExperience.t),
      orderByList: orderByList?.call(SeniorExperience.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeniorExperienceImpl extends SeniorExperience {
  _SeniorExperienceImpl({
    int? id,
    required String companyName,
    required String seniorName,
    required String seniorBranch,
    required int batchYear,
    required String placedRole,
    String? packageOffered,
    int? difficultyRating,
    required List<String> interviewQuestions,
    required String experienceReview,
    required String tipsForJuniors,
    String? contactHandle,
    bool? verified,
    DateTime? createdAt,
  }) : super._(
         id: id,
         companyName: companyName,
         seniorName: seniorName,
         seniorBranch: seniorBranch,
         batchYear: batchYear,
         placedRole: placedRole,
         packageOffered: packageOffered,
         difficultyRating: difficultyRating,
         interviewQuestions: interviewQuestions,
         experienceReview: experienceReview,
         tipsForJuniors: tipsForJuniors,
         contactHandle: contactHandle,
         verified: verified,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SeniorExperience]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SeniorExperience copyWith({
    Object? id = _Undefined,
    String? companyName,
    String? seniorName,
    String? seniorBranch,
    int? batchYear,
    String? placedRole,
    Object? packageOffered = _Undefined,
    int? difficultyRating,
    List<String>? interviewQuestions,
    String? experienceReview,
    String? tipsForJuniors,
    Object? contactHandle = _Undefined,
    bool? verified,
    DateTime? createdAt,
  }) {
    return SeniorExperience(
      id: id is int? ? id : this.id,
      companyName: companyName ?? this.companyName,
      seniorName: seniorName ?? this.seniorName,
      seniorBranch: seniorBranch ?? this.seniorBranch,
      batchYear: batchYear ?? this.batchYear,
      placedRole: placedRole ?? this.placedRole,
      packageOffered: packageOffered is String?
          ? packageOffered
          : this.packageOffered,
      difficultyRating: difficultyRating ?? this.difficultyRating,
      interviewQuestions:
          interviewQuestions ??
          this.interviewQuestions.map((e0) => e0).toList(),
      experienceReview: experienceReview ?? this.experienceReview,
      tipsForJuniors: tipsForJuniors ?? this.tipsForJuniors,
      contactHandle: contactHandle is String?
          ? contactHandle
          : this.contactHandle,
      verified: verified ?? this.verified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SeniorExperienceUpdateTable
    extends _is.UpdateTable<SeniorExperienceTable> {
  SeniorExperienceUpdateTable(super.table);

  _is.ColumnValue<String, String> companyName(String value) => _is.ColumnValue(
    table.companyName,
    value,
  );

  _is.ColumnValue<String, String> seniorName(String value) => _is.ColumnValue(
    table.seniorName,
    value,
  );

  _is.ColumnValue<String, String> seniorBranch(String value) => _is.ColumnValue(
    table.seniorBranch,
    value,
  );

  _is.ColumnValue<int, int> batchYear(int value) => _is.ColumnValue(
    table.batchYear,
    value,
  );

  _is.ColumnValue<String, String> placedRole(String value) => _is.ColumnValue(
    table.placedRole,
    value,
  );

  _is.ColumnValue<String, String> packageOffered(String? value) =>
      _is.ColumnValue(
        table.packageOffered,
        value,
      );

  _is.ColumnValue<int, int> difficultyRating(int value) => _is.ColumnValue(
    table.difficultyRating,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> interviewQuestions(
    List<String> value,
  ) => _is.ColumnValue(
    table.interviewQuestions,
    value,
  );

  _is.ColumnValue<String, String> experienceReview(String value) =>
      _is.ColumnValue(
        table.experienceReview,
        value,
      );

  _is.ColumnValue<String, String> tipsForJuniors(String value) =>
      _is.ColumnValue(
        table.tipsForJuniors,
        value,
      );

  _is.ColumnValue<String, String> contactHandle(String? value) =>
      _is.ColumnValue(
        table.contactHandle,
        value,
      );

  _is.ColumnValue<bool, bool> verified(bool value) => _is.ColumnValue(
    table.verified,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class SeniorExperienceTable extends _is.Table<int?> {
  SeniorExperienceTable({super.tableRelation})
    : super(tableName: 'senior_experiences') {
    updateTable = SeniorExperienceUpdateTable(this);
    companyName = _is.ColumnString(
      'companyName',
      this,
    );
    seniorName = _is.ColumnString(
      'seniorName',
      this,
    );
    seniorBranch = _is.ColumnString(
      'seniorBranch',
      this,
    );
    batchYear = _is.ColumnInt(
      'batchYear',
      this,
    );
    placedRole = _is.ColumnString(
      'placedRole',
      this,
    );
    packageOffered = _is.ColumnString(
      'packageOffered',
      this,
    );
    difficultyRating = _is.ColumnInt(
      'difficultyRating',
      this,
      hasDefault: true,
    );
    interviewQuestions = _is.ColumnSerializable<List<String>>(
      'interviewQuestions',
      this,
    );
    experienceReview = _is.ColumnString(
      'experienceReview',
      this,
    );
    tipsForJuniors = _is.ColumnString(
      'tipsForJuniors',
      this,
    );
    contactHandle = _is.ColumnString(
      'contactHandle',
      this,
    );
    verified = _is.ColumnBool(
      'verified',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final SeniorExperienceUpdateTable updateTable;

  late final _is.ColumnString companyName;

  late final _is.ColumnString seniorName;

  late final _is.ColumnString seniorBranch;

  late final _is.ColumnInt batchYear;

  late final _is.ColumnString placedRole;

  late final _is.ColumnString packageOffered;

  late final _is.ColumnInt difficultyRating;

  late final _is.ColumnSerializable<List<String>> interviewQuestions;

  late final _is.ColumnString experienceReview;

  late final _is.ColumnString tipsForJuniors;

  late final _is.ColumnString contactHandle;

  late final _is.ColumnBool verified;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    companyName,
    seniorName,
    seniorBranch,
    batchYear,
    placedRole,
    packageOffered,
    difficultyRating,
    interviewQuestions,
    experienceReview,
    tipsForJuniors,
    contactHandle,
    verified,
    createdAt,
  ];
}

class SeniorExperienceInclude extends _is.IncludeObject {
  SeniorExperienceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SeniorExperience.t;
}

class SeniorExperienceIncludeList extends _is.IncludeList {
  SeniorExperienceIncludeList._({
    _is.WhereExpressionBuilder<SeniorExperienceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SeniorExperience.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SeniorExperience.t;
}

class SeniorExperienceRepository {
  const SeniorExperienceRepository._();

  /// Returns a list of [SeniorExperience]s matching the given query parameters.
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
  Future<List<SeniorExperience>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SeniorExperienceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SeniorExperienceTable>? orderBy,
    _is.OrderByListBuilder<SeniorExperienceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SeniorExperience>(
      where: where?.call(SeniorExperience.t),
      orderBy: orderBy?.call(SeniorExperience.t),
      orderByList: orderByList?.call(SeniorExperience.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SeniorExperience] matching the given query parameters.
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
  Future<SeniorExperience?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SeniorExperienceTable>? where,
    int? offset,
    _is.OrderByBuilder<SeniorExperienceTable>? orderBy,
    _is.OrderByListBuilder<SeniorExperienceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SeniorExperience>(
      where: where?.call(SeniorExperience.t),
      orderBy: orderBy?.call(SeniorExperience.t),
      orderByList: orderByList?.call(SeniorExperience.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SeniorExperience] by its [id] or null if no such row exists.
  Future<SeniorExperience?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SeniorExperience>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SeniorExperience]s in the list and returns the inserted rows.
  ///
  /// The returned [SeniorExperience]s will have their `id` fields set.
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
  Future<List<SeniorExperience>> insert(
    _is.DatabaseSession session,
    List<SeniorExperience> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SeniorExperience>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SeniorExperience] and returns the inserted row.
  ///
  /// The returned [SeniorExperience] will have its `id` field set.
  Future<SeniorExperience> insertRow(
    _is.DatabaseSession session,
    SeniorExperience row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SeniorExperience>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SeniorExperience]s in the list and returns the resulting rows.
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
  /// The returned [SeniorExperience]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SeniorExperience>> upsert(
    _is.DatabaseSession session,
    List<SeniorExperience> rows, {
    required _is.ColumnSelections<SeniorExperienceTable> conflictColumns,
    _is.ColumnSelections<SeniorExperienceTable>? updateColumns,
    _is.WhereExpressionBuilder<SeniorExperienceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SeniorExperience>(
      rows,
      conflictColumns: conflictColumns(SeniorExperience.t),
      updateColumns: updateColumns?.call(SeniorExperience.t),
      updateWhere: updateWhere?.call(SeniorExperience.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SeniorExperience] and returns the resulting row.
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
  /// The returned [SeniorExperience] will have its `id` field set.
  Future<SeniorExperience?> upsertRow(
    _is.DatabaseSession session,
    SeniorExperience row, {
    required _is.ColumnSelections<SeniorExperienceTable> conflictColumns,
    _is.ColumnSelections<SeniorExperienceTable>? updateColumns,
    _is.WhereExpressionBuilder<SeniorExperienceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SeniorExperience>(
      row,
      conflictColumns: conflictColumns(SeniorExperience.t),
      updateColumns: updateColumns?.call(SeniorExperience.t),
      updateWhere: updateWhere?.call(SeniorExperience.t),
      transaction: transaction,
    );
  }

  /// Updates all [SeniorExperience]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SeniorExperience>> update(
    _is.DatabaseSession session,
    List<SeniorExperience> rows, {
    _is.ColumnSelections<SeniorExperienceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SeniorExperience>(
      rows,
      columns: columns?.call(SeniorExperience.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SeniorExperience]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SeniorExperience> updateRow(
    _is.DatabaseSession session,
    SeniorExperience row, {
    _is.ColumnSelections<SeniorExperienceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SeniorExperience>(
      row,
      columns: columns?.call(SeniorExperience.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SeniorExperience] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SeniorExperience?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SeniorExperienceUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SeniorExperience>(
      id,
      columnValues: columnValues(SeniorExperience.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SeniorExperience]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SeniorExperience>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SeniorExperienceUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SeniorExperienceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SeniorExperienceTable>? orderBy,
    _is.OrderByListBuilder<SeniorExperienceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SeniorExperience>(
      columnValues: columnValues(SeniorExperience.t.updateTable),
      where: where(SeniorExperience.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SeniorExperience.t),
      orderByList: orderByList?.call(SeniorExperience.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SeniorExperience]s in the list and returns the deleted rows.
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
  Future<List<SeniorExperience>> delete(
    _is.DatabaseSession session,
    List<SeniorExperience> rows, {
    _is.OrderByBuilder<SeniorExperienceTable>? orderBy,
    _is.OrderByListBuilder<SeniorExperienceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SeniorExperience>(
      rows,
      orderBy: orderBy?.call(SeniorExperience.t),
      orderByList: orderByList?.call(SeniorExperience.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SeniorExperience].
  Future<SeniorExperience> deleteRow(
    _is.DatabaseSession session,
    SeniorExperience row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SeniorExperience>(
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
  Future<List<SeniorExperience>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SeniorExperienceTable> where,
    _is.OrderByBuilder<SeniorExperienceTable>? orderBy,
    _is.OrderByListBuilder<SeniorExperienceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SeniorExperience>(
      where: where(SeniorExperience.t),
      orderBy: orderBy?.call(SeniorExperience.t),
      orderByList: orderByList?.call(SeniorExperience.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SeniorExperienceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SeniorExperience>(
      where: where?.call(SeniorExperience.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SeniorExperience] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SeniorExperienceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SeniorExperience>(
      where: where(SeniorExperience.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
