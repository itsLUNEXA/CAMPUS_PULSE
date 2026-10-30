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

abstract class UserRole
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserRole._({
    this.id,
    required this.authUserId,
    required this.role,
    this.assignedScope,
    DateTime? grantedAt,
  }) : grantedAt = grantedAt ?? DateTime.now();

  factory UserRole({
    int? id,
    required _is.UuidValue authUserId,
    required String role,
    String? assignedScope,
    DateTime? grantedAt,
  }) = _UserRoleImpl;

  factory UserRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRole(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      role: jsonSerialization['role'] as String,
      assignedScope: jsonSerialization['assignedScope'] as String?,
      grantedAt: jsonSerialization['grantedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['grantedAt']),
    );
  }

  static final t = UserRoleTable();

  static const db = UserRoleRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String role;

  String? assignedScope;

  DateTime grantedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserRole]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserRole copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? role,
    String? assignedScope,
    DateTime? grantedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRole',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'role': role,
      if (assignedScope != null) 'assignedScope': assignedScope,
      'grantedAt': grantedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserRole',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'role': role,
      if (assignedScope != null) 'assignedScope': assignedScope,
      'grantedAt': grantedAt.toJson(),
    };
  }

  static UserRoleInclude include() {
    return UserRoleInclude._();
  }

  static UserRoleIncludeList includeList({
    _is.WhereExpressionBuilder<UserRoleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserRoleTable>? orderBy,
    _is.OrderByListBuilder<UserRoleTable>? orderByList,
    UserRoleInclude? include,
  }) {
    return UserRoleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRole.t),
      orderByList: orderByList?.call(UserRole.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRoleImpl extends UserRole {
  _UserRoleImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String role,
    String? assignedScope,
    DateTime? grantedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         role: role,
         assignedScope: assignedScope,
         grantedAt: grantedAt,
       );

  /// Returns a shallow copy of this [UserRole]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserRole copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? role,
    Object? assignedScope = _Undefined,
    DateTime? grantedAt,
  }) {
    return UserRole(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      role: role ?? this.role,
      assignedScope: assignedScope is String?
          ? assignedScope
          : this.assignedScope,
      grantedAt: grantedAt ?? this.grantedAt,
    );
  }
}

class UserRoleUpdateTable extends _is.UpdateTable<UserRoleTable> {
  UserRoleUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> role(String value) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<String, String> assignedScope(String? value) =>
      _is.ColumnValue(
        table.assignedScope,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> grantedAt(DateTime value) =>
      _is.ColumnValue(
        table.grantedAt,
        value,
      );
}

class UserRoleTable extends _is.Table<int?> {
  UserRoleTable({super.tableRelation}) : super(tableName: 'user_role') {
    updateTable = UserRoleUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    role = _is.ColumnString(
      'role',
      this,
    );
    assignedScope = _is.ColumnString(
      'assignedScope',
      this,
    );
    grantedAt = _is.ColumnDateTime(
      'grantedAt',
      this,
      hasDefault: true,
    );
  }

  late final UserRoleUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString role;

  late final _is.ColumnString assignedScope;

  late final _is.ColumnDateTime grantedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    role,
    assignedScope,
    grantedAt,
  ];
}

class UserRoleInclude extends _is.IncludeObject {
  UserRoleInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UserRole.t;
}

class UserRoleIncludeList extends _is.IncludeList {
  UserRoleIncludeList._({
    _is.WhereExpressionBuilder<UserRoleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserRole.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserRole.t;
}

class UserRoleRepository {
  const UserRoleRepository._();

  /// Returns a list of [UserRole]s matching the given query parameters.
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
  Future<List<UserRole>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserRoleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserRoleTable>? orderBy,
    _is.OrderByListBuilder<UserRoleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserRole>(
      where: where?.call(UserRole.t),
      orderBy: orderBy?.call(UserRole.t),
      orderByList: orderByList?.call(UserRole.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserRole] matching the given query parameters.
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
  Future<UserRole?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserRoleTable>? where,
    int? offset,
    _is.OrderByBuilder<UserRoleTable>? orderBy,
    _is.OrderByListBuilder<UserRoleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserRole>(
      where: where?.call(UserRole.t),
      orderBy: orderBy?.call(UserRole.t),
      orderByList: orderByList?.call(UserRole.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserRole] by its [id] or null if no such row exists.
  Future<UserRole?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserRole>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserRole]s in the list and returns the inserted rows.
  ///
  /// The returned [UserRole]s will have their `id` fields set.
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
  Future<List<UserRole>> insert(
    _is.DatabaseSession session,
    List<UserRole> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserRole>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserRole] and returns the inserted row.
  ///
  /// The returned [UserRole] will have its `id` field set.
  Future<UserRole> insertRow(
    _is.DatabaseSession session,
    UserRole row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserRole>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserRole]s in the list and returns the resulting rows.
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
  /// The returned [UserRole]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserRole>> upsert(
    _is.DatabaseSession session,
    List<UserRole> rows, {
    required _is.ColumnSelections<UserRoleTable> conflictColumns,
    _is.ColumnSelections<UserRoleTable>? updateColumns,
    _is.WhereExpressionBuilder<UserRoleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserRole>(
      rows,
      conflictColumns: conflictColumns(UserRole.t),
      updateColumns: updateColumns?.call(UserRole.t),
      updateWhere: updateWhere?.call(UserRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserRole] and returns the resulting row.
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
  /// The returned [UserRole] will have its `id` field set.
  Future<UserRole?> upsertRow(
    _is.DatabaseSession session,
    UserRole row, {
    required _is.ColumnSelections<UserRoleTable> conflictColumns,
    _is.ColumnSelections<UserRoleTable>? updateColumns,
    _is.WhereExpressionBuilder<UserRoleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserRole>(
      row,
      conflictColumns: conflictColumns(UserRole.t),
      updateColumns: updateColumns?.call(UserRole.t),
      updateWhere: updateWhere?.call(UserRole.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserRole]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserRole>> update(
    _is.DatabaseSession session,
    List<UserRole> rows, {
    _is.ColumnSelections<UserRoleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserRole>(
      rows,
      columns: columns?.call(UserRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserRole]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserRole> updateRow(
    _is.DatabaseSession session,
    UserRole row, {
    _is.ColumnSelections<UserRoleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserRole>(
      row,
      columns: columns?.call(UserRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRole] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserRole?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserRoleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserRole>(
      id,
      columnValues: columnValues(UserRole.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserRole]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserRole>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserRoleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<UserRoleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserRoleTable>? orderBy,
    _is.OrderByListBuilder<UserRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserRole>(
      columnValues: columnValues(UserRole.t.updateTable),
      where: where(UserRole.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRole.t),
      orderByList: orderByList?.call(UserRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserRole]s in the list and returns the deleted rows.
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
  Future<List<UserRole>> delete(
    _is.DatabaseSession session,
    List<UserRole> rows, {
    _is.OrderByBuilder<UserRoleTable>? orderBy,
    _is.OrderByListBuilder<UserRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserRole>(
      rows,
      orderBy: orderBy?.call(UserRole.t),
      orderByList: orderByList?.call(UserRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserRole].
  Future<UserRole> deleteRow(
    _is.DatabaseSession session,
    UserRole row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserRole>(
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
  Future<List<UserRole>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserRoleTable> where,
    _is.OrderByBuilder<UserRoleTable>? orderBy,
    _is.OrderByListBuilder<UserRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserRole>(
      where: where(UserRole.t),
      orderBy: orderBy?.call(UserRole.t),
      orderByList: orderByList?.call(UserRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserRoleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserRole>(
      where: where?.call(UserRole.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserRole] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserRoleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserRole>(
      where: where(UserRole.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
