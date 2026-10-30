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

abstract class AcademicResource
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AcademicResource._({
    this.id,
    required this.title,
    this.description,
    required this.university,
    required this.course,
    required this.branch,
    required this.academicYear,
    required this.semester,
    required this.subjectCode,
    required this.subjectName,
    this.unitNumber,
    required this.resourceType,
    required this.fileUrl,
    this.fileSize,
    required this.uploadedByUserId,
    required this.uploaderName,
    bool? isApproved,
    this.approvedByUserId,
    this.rejectionReason,
    DateTime? createdAt,
    int? downloadCount,
  }) : isApproved = isApproved ?? false,
       createdAt = createdAt ?? DateTime.now(),
       downloadCount = downloadCount ?? 0;

  factory AcademicResource({
    int? id,
    required String title,
    String? description,
    required String university,
    required String course,
    required String branch,
    required int academicYear,
    required int semester,
    required String subjectCode,
    required String subjectName,
    int? unitNumber,
    required String resourceType,
    required String fileUrl,
    int? fileSize,
    required _is.UuidValue uploadedByUserId,
    required String uploaderName,
    bool? isApproved,
    _is.UuidValue? approvedByUserId,
    String? rejectionReason,
    DateTime? createdAt,
    int? downloadCount,
  }) = _AcademicResourceImpl;

  factory AcademicResource.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcademicResource(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      university: jsonSerialization['university'] as String,
      course: jsonSerialization['course'] as String,
      branch: jsonSerialization['branch'] as String,
      academicYear: jsonSerialization['academicYear'] as int,
      semester: jsonSerialization['semester'] as int,
      subjectCode: jsonSerialization['subjectCode'] as String,
      subjectName: jsonSerialization['subjectName'] as String,
      unitNumber: jsonSerialization['unitNumber'] as int?,
      resourceType: jsonSerialization['resourceType'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      fileSize: jsonSerialization['fileSize'] as int?,
      uploadedByUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['uploadedByUserId'],
      ),
      uploaderName: jsonSerialization['uploaderName'] as String,
      isApproved: jsonSerialization['isApproved'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isApproved']),
      approvedByUserId: jsonSerialization['approvedByUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['approvedByUserId'],
            ),
      rejectionReason: jsonSerialization['rejectionReason'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      downloadCount: jsonSerialization['downloadCount'] as int?,
    );
  }

  static final t = AcademicResourceTable();

  static const db = AcademicResourceRepository._();

  @override
  int? id;

  String title;

  String? description;

  String university;

  String course;

  String branch;

  int academicYear;

  int semester;

  String subjectCode;

  String subjectName;

  int? unitNumber;

  String resourceType;

  String fileUrl;

  int? fileSize;

  _is.UuidValue uploadedByUserId;

  String uploaderName;

  bool isApproved;

  _is.UuidValue? approvedByUserId;

  String? rejectionReason;

  DateTime createdAt;

  int downloadCount;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AcademicResource]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AcademicResource copyWith({
    int? id,
    String? title,
    String? description,
    String? university,
    String? course,
    String? branch,
    int? academicYear,
    int? semester,
    String? subjectCode,
    String? subjectName,
    int? unitNumber,
    String? resourceType,
    String? fileUrl,
    int? fileSize,
    _is.UuidValue? uploadedByUserId,
    String? uploaderName,
    bool? isApproved,
    _is.UuidValue? approvedByUserId,
    String? rejectionReason,
    DateTime? createdAt,
    int? downloadCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AcademicResource',
      if (id != null) 'id': id,
      'title': title,
      if (description != null) 'description': description,
      'university': university,
      'course': course,
      'branch': branch,
      'academicYear': academicYear,
      'semester': semester,
      'subjectCode': subjectCode,
      'subjectName': subjectName,
      if (unitNumber != null) 'unitNumber': unitNumber,
      'resourceType': resourceType,
      'fileUrl': fileUrl,
      if (fileSize != null) 'fileSize': fileSize,
      'uploadedByUserId': uploadedByUserId.toJson(),
      'uploaderName': uploaderName,
      'isApproved': isApproved,
      if (approvedByUserId != null)
        'approvedByUserId': approvedByUserId?.toJson(),
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      'createdAt': createdAt.toJson(),
      'downloadCount': downloadCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AcademicResource',
      if (id != null) 'id': id,
      'title': title,
      if (description != null) 'description': description,
      'university': university,
      'course': course,
      'branch': branch,
      'academicYear': academicYear,
      'semester': semester,
      'subjectCode': subjectCode,
      'subjectName': subjectName,
      if (unitNumber != null) 'unitNumber': unitNumber,
      'resourceType': resourceType,
      'fileUrl': fileUrl,
      if (fileSize != null) 'fileSize': fileSize,
      'uploadedByUserId': uploadedByUserId.toJson(),
      'uploaderName': uploaderName,
      'isApproved': isApproved,
      if (approvedByUserId != null)
        'approvedByUserId': approvedByUserId?.toJson(),
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      'createdAt': createdAt.toJson(),
      'downloadCount': downloadCount,
    };
  }

  static AcademicResourceInclude include() {
    return AcademicResourceInclude._();
  }

  static AcademicResourceIncludeList includeList({
    _is.WhereExpressionBuilder<AcademicResourceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AcademicResourceTable>? orderBy,
    _is.OrderByListBuilder<AcademicResourceTable>? orderByList,
    AcademicResourceInclude? include,
  }) {
    return AcademicResourceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AcademicResource.t),
      orderByList: orderByList?.call(AcademicResource.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AcademicResourceImpl extends AcademicResource {
  _AcademicResourceImpl({
    int? id,
    required String title,
    String? description,
    required String university,
    required String course,
    required String branch,
    required int academicYear,
    required int semester,
    required String subjectCode,
    required String subjectName,
    int? unitNumber,
    required String resourceType,
    required String fileUrl,
    int? fileSize,
    required _is.UuidValue uploadedByUserId,
    required String uploaderName,
    bool? isApproved,
    _is.UuidValue? approvedByUserId,
    String? rejectionReason,
    DateTime? createdAt,
    int? downloadCount,
  }) : super._(
         id: id,
         title: title,
         description: description,
         university: university,
         course: course,
         branch: branch,
         academicYear: academicYear,
         semester: semester,
         subjectCode: subjectCode,
         subjectName: subjectName,
         unitNumber: unitNumber,
         resourceType: resourceType,
         fileUrl: fileUrl,
         fileSize: fileSize,
         uploadedByUserId: uploadedByUserId,
         uploaderName: uploaderName,
         isApproved: isApproved,
         approvedByUserId: approvedByUserId,
         rejectionReason: rejectionReason,
         createdAt: createdAt,
         downloadCount: downloadCount,
       );

  /// Returns a shallow copy of this [AcademicResource]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AcademicResource copyWith({
    Object? id = _Undefined,
    String? title,
    Object? description = _Undefined,
    String? university,
    String? course,
    String? branch,
    int? academicYear,
    int? semester,
    String? subjectCode,
    String? subjectName,
    Object? unitNumber = _Undefined,
    String? resourceType,
    String? fileUrl,
    Object? fileSize = _Undefined,
    _is.UuidValue? uploadedByUserId,
    String? uploaderName,
    bool? isApproved,
    Object? approvedByUserId = _Undefined,
    Object? rejectionReason = _Undefined,
    DateTime? createdAt,
    int? downloadCount,
  }) {
    return AcademicResource(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      university: university ?? this.university,
      course: course ?? this.course,
      branch: branch ?? this.branch,
      academicYear: academicYear ?? this.academicYear,
      semester: semester ?? this.semester,
      subjectCode: subjectCode ?? this.subjectCode,
      subjectName: subjectName ?? this.subjectName,
      unitNumber: unitNumber is int? ? unitNumber : this.unitNumber,
      resourceType: resourceType ?? this.resourceType,
      fileUrl: fileUrl ?? this.fileUrl,
      fileSize: fileSize is int? ? fileSize : this.fileSize,
      uploadedByUserId: uploadedByUserId ?? this.uploadedByUserId,
      uploaderName: uploaderName ?? this.uploaderName,
      isApproved: isApproved ?? this.isApproved,
      approvedByUserId: approvedByUserId is _is.UuidValue?
          ? approvedByUserId
          : this.approvedByUserId,
      rejectionReason: rejectionReason is String?
          ? rejectionReason
          : this.rejectionReason,
      createdAt: createdAt ?? this.createdAt,
      downloadCount: downloadCount ?? this.downloadCount,
    );
  }
}

class AcademicResourceUpdateTable
    extends _is.UpdateTable<AcademicResourceTable> {
  AcademicResourceUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> university(String value) => _is.ColumnValue(
    table.university,
    value,
  );

  _is.ColumnValue<String, String> course(String value) => _is.ColumnValue(
    table.course,
    value,
  );

  _is.ColumnValue<String, String> branch(String value) => _is.ColumnValue(
    table.branch,
    value,
  );

  _is.ColumnValue<int, int> academicYear(int value) => _is.ColumnValue(
    table.academicYear,
    value,
  );

  _is.ColumnValue<int, int> semester(int value) => _is.ColumnValue(
    table.semester,
    value,
  );

  _is.ColumnValue<String, String> subjectCode(String value) => _is.ColumnValue(
    table.subjectCode,
    value,
  );

  _is.ColumnValue<String, String> subjectName(String value) => _is.ColumnValue(
    table.subjectName,
    value,
  );

  _is.ColumnValue<int, int> unitNumber(int? value) => _is.ColumnValue(
    table.unitNumber,
    value,
  );

  _is.ColumnValue<String, String> resourceType(String value) => _is.ColumnValue(
    table.resourceType,
    value,
  );

  _is.ColumnValue<String, String> fileUrl(String value) => _is.ColumnValue(
    table.fileUrl,
    value,
  );

  _is.ColumnValue<int, int> fileSize(int? value) => _is.ColumnValue(
    table.fileSize,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> uploadedByUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.uploadedByUserId,
    value,
  );

  _is.ColumnValue<String, String> uploaderName(String value) => _is.ColumnValue(
    table.uploaderName,
    value,
  );

  _is.ColumnValue<bool, bool> isApproved(bool value) => _is.ColumnValue(
    table.isApproved,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> approvedByUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.approvedByUserId,
    value,
  );

  _is.ColumnValue<String, String> rejectionReason(String? value) =>
      _is.ColumnValue(
        table.rejectionReason,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<int, int> downloadCount(int value) => _is.ColumnValue(
    table.downloadCount,
    value,
  );
}

class AcademicResourceTable extends _is.Table<int?> {
  AcademicResourceTable({super.tableRelation})
    : super(tableName: 'academic_resource') {
    updateTable = AcademicResourceUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    university = _is.ColumnString(
      'university',
      this,
    );
    course = _is.ColumnString(
      'course',
      this,
    );
    branch = _is.ColumnString(
      'branch',
      this,
    );
    academicYear = _is.ColumnInt(
      'academicYear',
      this,
    );
    semester = _is.ColumnInt(
      'semester',
      this,
    );
    subjectCode = _is.ColumnString(
      'subjectCode',
      this,
    );
    subjectName = _is.ColumnString(
      'subjectName',
      this,
    );
    unitNumber = _is.ColumnInt(
      'unitNumber',
      this,
    );
    resourceType = _is.ColumnString(
      'resourceType',
      this,
    );
    fileUrl = _is.ColumnString(
      'fileUrl',
      this,
    );
    fileSize = _is.ColumnInt(
      'fileSize',
      this,
    );
    uploadedByUserId = _is.ColumnUuid(
      'uploadedByUserId',
      this,
    );
    uploaderName = _is.ColumnString(
      'uploaderName',
      this,
    );
    isApproved = _is.ColumnBool(
      'isApproved',
      this,
      hasDefault: true,
    );
    approvedByUserId = _is.ColumnUuid(
      'approvedByUserId',
      this,
    );
    rejectionReason = _is.ColumnString(
      'rejectionReason',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    downloadCount = _is.ColumnInt(
      'downloadCount',
      this,
      hasDefault: true,
    );
  }

  late final AcademicResourceUpdateTable updateTable;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnString university;

  late final _is.ColumnString course;

  late final _is.ColumnString branch;

  late final _is.ColumnInt academicYear;

  late final _is.ColumnInt semester;

  late final _is.ColumnString subjectCode;

  late final _is.ColumnString subjectName;

  late final _is.ColumnInt unitNumber;

  late final _is.ColumnString resourceType;

  late final _is.ColumnString fileUrl;

  late final _is.ColumnInt fileSize;

  late final _is.ColumnUuid uploadedByUserId;

  late final _is.ColumnString uploaderName;

  late final _is.ColumnBool isApproved;

  late final _is.ColumnUuid approvedByUserId;

  late final _is.ColumnString rejectionReason;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnInt downloadCount;

  @override
  List<_is.Column> get columns => [
    id,
    title,
    description,
    university,
    course,
    branch,
    academicYear,
    semester,
    subjectCode,
    subjectName,
    unitNumber,
    resourceType,
    fileUrl,
    fileSize,
    uploadedByUserId,
    uploaderName,
    isApproved,
    approvedByUserId,
    rejectionReason,
    createdAt,
    downloadCount,
  ];
}

class AcademicResourceInclude extends _is.IncludeObject {
  AcademicResourceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AcademicResource.t;
}

class AcademicResourceIncludeList extends _is.IncludeList {
  AcademicResourceIncludeList._({
    _is.WhereExpressionBuilder<AcademicResourceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AcademicResource.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AcademicResource.t;
}

class AcademicResourceRepository {
  const AcademicResourceRepository._();

  /// Returns a list of [AcademicResource]s matching the given query parameters.
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
  Future<List<AcademicResource>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AcademicResourceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AcademicResourceTable>? orderBy,
    _is.OrderByListBuilder<AcademicResourceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AcademicResource>(
      where: where?.call(AcademicResource.t),
      orderBy: orderBy?.call(AcademicResource.t),
      orderByList: orderByList?.call(AcademicResource.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AcademicResource] matching the given query parameters.
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
  Future<AcademicResource?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AcademicResourceTable>? where,
    int? offset,
    _is.OrderByBuilder<AcademicResourceTable>? orderBy,
    _is.OrderByListBuilder<AcademicResourceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AcademicResource>(
      where: where?.call(AcademicResource.t),
      orderBy: orderBy?.call(AcademicResource.t),
      orderByList: orderByList?.call(AcademicResource.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AcademicResource] by its [id] or null if no such row exists.
  Future<AcademicResource?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AcademicResource>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AcademicResource]s in the list and returns the inserted rows.
  ///
  /// The returned [AcademicResource]s will have their `id` fields set.
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
  Future<List<AcademicResource>> insert(
    _is.DatabaseSession session,
    List<AcademicResource> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AcademicResource>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AcademicResource] and returns the inserted row.
  ///
  /// The returned [AcademicResource] will have its `id` field set.
  Future<AcademicResource> insertRow(
    _is.DatabaseSession session,
    AcademicResource row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AcademicResource>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AcademicResource]s in the list and returns the resulting rows.
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
  /// The returned [AcademicResource]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AcademicResource>> upsert(
    _is.DatabaseSession session,
    List<AcademicResource> rows, {
    required _is.ColumnSelections<AcademicResourceTable> conflictColumns,
    _is.ColumnSelections<AcademicResourceTable>? updateColumns,
    _is.WhereExpressionBuilder<AcademicResourceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AcademicResource>(
      rows,
      conflictColumns: conflictColumns(AcademicResource.t),
      updateColumns: updateColumns?.call(AcademicResource.t),
      updateWhere: updateWhere?.call(AcademicResource.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AcademicResource] and returns the resulting row.
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
  /// The returned [AcademicResource] will have its `id` field set.
  Future<AcademicResource?> upsertRow(
    _is.DatabaseSession session,
    AcademicResource row, {
    required _is.ColumnSelections<AcademicResourceTable> conflictColumns,
    _is.ColumnSelections<AcademicResourceTable>? updateColumns,
    _is.WhereExpressionBuilder<AcademicResourceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AcademicResource>(
      row,
      conflictColumns: conflictColumns(AcademicResource.t),
      updateColumns: updateColumns?.call(AcademicResource.t),
      updateWhere: updateWhere?.call(AcademicResource.t),
      transaction: transaction,
    );
  }

  /// Updates all [AcademicResource]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AcademicResource>> update(
    _is.DatabaseSession session,
    List<AcademicResource> rows, {
    _is.ColumnSelections<AcademicResourceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AcademicResource>(
      rows,
      columns: columns?.call(AcademicResource.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AcademicResource]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AcademicResource> updateRow(
    _is.DatabaseSession session,
    AcademicResource row, {
    _is.ColumnSelections<AcademicResourceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AcademicResource>(
      row,
      columns: columns?.call(AcademicResource.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AcademicResource] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AcademicResource?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AcademicResourceUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AcademicResource>(
      id,
      columnValues: columnValues(AcademicResource.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AcademicResource]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AcademicResource>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AcademicResourceUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<AcademicResourceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AcademicResourceTable>? orderBy,
    _is.OrderByListBuilder<AcademicResourceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AcademicResource>(
      columnValues: columnValues(AcademicResource.t.updateTable),
      where: where(AcademicResource.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AcademicResource.t),
      orderByList: orderByList?.call(AcademicResource.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AcademicResource]s in the list and returns the deleted rows.
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
  Future<List<AcademicResource>> delete(
    _is.DatabaseSession session,
    List<AcademicResource> rows, {
    _is.OrderByBuilder<AcademicResourceTable>? orderBy,
    _is.OrderByListBuilder<AcademicResourceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AcademicResource>(
      rows,
      orderBy: orderBy?.call(AcademicResource.t),
      orderByList: orderByList?.call(AcademicResource.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AcademicResource].
  Future<AcademicResource> deleteRow(
    _is.DatabaseSession session,
    AcademicResource row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AcademicResource>(
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
  Future<List<AcademicResource>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AcademicResourceTable> where,
    _is.OrderByBuilder<AcademicResourceTable>? orderBy,
    _is.OrderByListBuilder<AcademicResourceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AcademicResource>(
      where: where(AcademicResource.t),
      orderBy: orderBy?.call(AcademicResource.t),
      orderByList: orderByList?.call(AcademicResource.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AcademicResourceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AcademicResource>(
      where: where?.call(AcademicResource.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AcademicResource] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AcademicResourceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AcademicResource>(
      where: where(AcademicResource.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
