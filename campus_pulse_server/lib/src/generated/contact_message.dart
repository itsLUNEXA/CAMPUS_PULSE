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

abstract class ContactMessage
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ContactMessage._({
    this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ContactMessage({
    int? id,
    required String name,
    required String email,
    required String subject,
    required String message,
    DateTime? createdAt,
  }) = _ContactMessageImpl;

  factory ContactMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContactMessage(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      subject: jsonSerialization['subject'] as String,
      message: jsonSerialization['message'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ContactMessageTable();

  static const db = ContactMessageRepository._();

  @override
  int? id;

  String name;

  String email;

  String subject;

  String message;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ContactMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ContactMessage copyWith({
    int? id,
    String? name,
    String? email,
    String? subject,
    String? message,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContactMessage',
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ContactMessage',
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'createdAt': createdAt.toJson(),
    };
  }

  static ContactMessageInclude include() {
    return ContactMessageInclude._();
  }

  static ContactMessageIncludeList includeList({
    _is.WhereExpressionBuilder<ContactMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ContactMessageTable>? orderBy,
    _is.OrderByListBuilder<ContactMessageTable>? orderByList,
    ContactMessageInclude? include,
  }) {
    return ContactMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ContactMessage.t),
      orderByList: orderByList?.call(ContactMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContactMessageImpl extends ContactMessage {
  _ContactMessageImpl({
    int? id,
    required String name,
    required String email,
    required String subject,
    required String message,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         email: email,
         subject: subject,
         message: message,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ContactMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ContactMessage copyWith({
    Object? id = _Undefined,
    String? name,
    String? email,
    String? subject,
    String? message,
    DateTime? createdAt,
  }) {
    return ContactMessage(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ContactMessageUpdateTable extends _is.UpdateTable<ContactMessageTable> {
  ContactMessageUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> email(String value) => _is.ColumnValue(
    table.email,
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

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ContactMessageTable extends _is.Table<int?> {
  ContactMessageTable({super.tableRelation})
    : super(tableName: 'contact_message') {
    updateTable = ContactMessageUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    email = _is.ColumnString(
      'email',
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
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ContactMessageUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString email;

  late final _is.ColumnString subject;

  late final _is.ColumnString message;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    email,
    subject,
    message,
    createdAt,
  ];
}

class ContactMessageInclude extends _is.IncludeObject {
  ContactMessageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ContactMessage.t;
}

class ContactMessageIncludeList extends _is.IncludeList {
  ContactMessageIncludeList._({
    _is.WhereExpressionBuilder<ContactMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ContactMessage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ContactMessage.t;
}

class ContactMessageRepository {
  const ContactMessageRepository._();

  /// Returns a list of [ContactMessage]s matching the given query parameters.
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
  Future<List<ContactMessage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ContactMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ContactMessageTable>? orderBy,
    _is.OrderByListBuilder<ContactMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ContactMessage>(
      where: where?.call(ContactMessage.t),
      orderBy: orderBy?.call(ContactMessage.t),
      orderByList: orderByList?.call(ContactMessage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ContactMessage] matching the given query parameters.
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
  Future<ContactMessage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ContactMessageTable>? where,
    int? offset,
    _is.OrderByBuilder<ContactMessageTable>? orderBy,
    _is.OrderByListBuilder<ContactMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ContactMessage>(
      where: where?.call(ContactMessage.t),
      orderBy: orderBy?.call(ContactMessage.t),
      orderByList: orderByList?.call(ContactMessage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ContactMessage] by its [id] or null if no such row exists.
  Future<ContactMessage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ContactMessage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ContactMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [ContactMessage]s will have their `id` fields set.
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
  Future<List<ContactMessage>> insert(
    _is.DatabaseSession session,
    List<ContactMessage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ContactMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ContactMessage] and returns the inserted row.
  ///
  /// The returned [ContactMessage] will have its `id` field set.
  Future<ContactMessage> insertRow(
    _is.DatabaseSession session,
    ContactMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ContactMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ContactMessage]s in the list and returns the resulting rows.
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
  /// The returned [ContactMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ContactMessage>> upsert(
    _is.DatabaseSession session,
    List<ContactMessage> rows, {
    required _is.ColumnSelections<ContactMessageTable> conflictColumns,
    _is.ColumnSelections<ContactMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<ContactMessageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ContactMessage>(
      rows,
      conflictColumns: conflictColumns(ContactMessage.t),
      updateColumns: updateColumns?.call(ContactMessage.t),
      updateWhere: updateWhere?.call(ContactMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ContactMessage] and returns the resulting row.
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
  /// The returned [ContactMessage] will have its `id` field set.
  Future<ContactMessage?> upsertRow(
    _is.DatabaseSession session,
    ContactMessage row, {
    required _is.ColumnSelections<ContactMessageTable> conflictColumns,
    _is.ColumnSelections<ContactMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<ContactMessageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ContactMessage>(
      row,
      conflictColumns: conflictColumns(ContactMessage.t),
      updateColumns: updateColumns?.call(ContactMessage.t),
      updateWhere: updateWhere?.call(ContactMessage.t),
      transaction: transaction,
    );
  }

  /// Updates all [ContactMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ContactMessage>> update(
    _is.DatabaseSession session,
    List<ContactMessage> rows, {
    _is.ColumnSelections<ContactMessageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ContactMessage>(
      rows,
      columns: columns?.call(ContactMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ContactMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ContactMessage> updateRow(
    _is.DatabaseSession session,
    ContactMessage row, {
    _is.ColumnSelections<ContactMessageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ContactMessage>(
      row,
      columns: columns?.call(ContactMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ContactMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ContactMessage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ContactMessageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ContactMessage>(
      id,
      columnValues: columnValues(ContactMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ContactMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ContactMessage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ContactMessageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ContactMessageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ContactMessageTable>? orderBy,
    _is.OrderByListBuilder<ContactMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ContactMessage>(
      columnValues: columnValues(ContactMessage.t.updateTable),
      where: where(ContactMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ContactMessage.t),
      orderByList: orderByList?.call(ContactMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ContactMessage]s in the list and returns the deleted rows.
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
  Future<List<ContactMessage>> delete(
    _is.DatabaseSession session,
    List<ContactMessage> rows, {
    _is.OrderByBuilder<ContactMessageTable>? orderBy,
    _is.OrderByListBuilder<ContactMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ContactMessage>(
      rows,
      orderBy: orderBy?.call(ContactMessage.t),
      orderByList: orderByList?.call(ContactMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ContactMessage].
  Future<ContactMessage> deleteRow(
    _is.DatabaseSession session,
    ContactMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ContactMessage>(
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
  Future<List<ContactMessage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ContactMessageTable> where,
    _is.OrderByBuilder<ContactMessageTable>? orderBy,
    _is.OrderByListBuilder<ContactMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ContactMessage>(
      where: where(ContactMessage.t),
      orderBy: orderBy?.call(ContactMessage.t),
      orderByList: orderByList?.call(ContactMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ContactMessageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ContactMessage>(
      where: where?.call(ContactMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ContactMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ContactMessageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ContactMessage>(
      where: where(ContactMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
