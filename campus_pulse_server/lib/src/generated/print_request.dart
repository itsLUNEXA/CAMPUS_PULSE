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

abstract class PrintRequest
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PrintRequest._({
    this.id,
    required this.studentAuthUserId,
    required this.studentName,
    required this.studentBranch,
    required this.studentYear,
    required this.hostelOrLocation,
    required this.fileName,
    required this.fileUrl,
    this.fileSizeBytes,
    required this.pageCount,
    required this.copies,
    required this.totalPages,
    required this.printType,
    required this.paperSize,
    required this.printSide,
    required this.binding,
    required this.deliveryMode,
    required this.counterName,
    required this.amountPaid,
    required this.pointsUsed,
    required this.pointsEarned,
    bool? pointsAwarded,
    required this.paymentStatus,
    this.paymentTransactionId,
    this.paymentFailureReason,
    required this.status,
    this.collectionCode,
    this.collectionQrToken,
    this.statusReason,
    this.processedByStaffName,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.collectedAt,
  }) : pointsAwarded = pointsAwarded ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory PrintRequest({
    int? id,
    required _is.UuidValue studentAuthUserId,
    required String studentName,
    required String studentBranch,
    required int studentYear,
    required String hostelOrLocation,
    required String fileName,
    required String fileUrl,
    int? fileSizeBytes,
    required int pageCount,
    required int copies,
    required int totalPages,
    required String printType,
    required String paperSize,
    required String printSide,
    required String binding,
    required String deliveryMode,
    required String counterName,
    required double amountPaid,
    required int pointsUsed,
    required int pointsEarned,
    bool? pointsAwarded,
    required String paymentStatus,
    String? paymentTransactionId,
    String? paymentFailureReason,
    required String status,
    String? collectionCode,
    String? collectionQrToken,
    String? statusReason,
    String? processedByStaffName,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? collectedAt,
  }) = _PrintRequestImpl;

  factory PrintRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return PrintRequest(
      id: jsonSerialization['id'] as int?,
      studentAuthUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['studentAuthUserId'],
      ),
      studentName: jsonSerialization['studentName'] as String,
      studentBranch: jsonSerialization['studentBranch'] as String,
      studentYear: jsonSerialization['studentYear'] as int,
      hostelOrLocation: jsonSerialization['hostelOrLocation'] as String,
      fileName: jsonSerialization['fileName'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      fileSizeBytes: jsonSerialization['fileSizeBytes'] as int?,
      pageCount: jsonSerialization['pageCount'] as int,
      copies: jsonSerialization['copies'] as int,
      totalPages: jsonSerialization['totalPages'] as int,
      printType: jsonSerialization['printType'] as String,
      paperSize: jsonSerialization['paperSize'] as String,
      printSide: jsonSerialization['printSide'] as String,
      binding: jsonSerialization['binding'] as String,
      deliveryMode: jsonSerialization['deliveryMode'] as String,
      counterName: jsonSerialization['counterName'] as String,
      amountPaid: (jsonSerialization['amountPaid'] as num).toDouble(),
      pointsUsed: jsonSerialization['pointsUsed'] as int,
      pointsEarned: jsonSerialization['pointsEarned'] as int,
      pointsAwarded: jsonSerialization['pointsAwarded'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['pointsAwarded']),
      paymentStatus: jsonSerialization['paymentStatus'] as String,
      paymentTransactionId:
          jsonSerialization['paymentTransactionId'] as String?,
      paymentFailureReason:
          jsonSerialization['paymentFailureReason'] as String?,
      status: jsonSerialization['status'] as String,
      collectionCode: jsonSerialization['collectionCode'] as String?,
      collectionQrToken: jsonSerialization['collectionQrToken'] as String?,
      statusReason: jsonSerialization['statusReason'] as String?,
      processedByStaffName:
          jsonSerialization['processedByStaffName'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      collectedAt: jsonSerialization['collectedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['collectedAt'],
            ),
    );
  }

  static final t = PrintRequestTable();

  static const db = PrintRequestRepository._();

  @override
  int? id;

  _is.UuidValue studentAuthUserId;

  String studentName;

  String studentBranch;

  int studentYear;

  String hostelOrLocation;

  String fileName;

  String fileUrl;

  int? fileSizeBytes;

  int pageCount;

  int copies;

  int totalPages;

  String printType;

  String paperSize;

  String printSide;

  String binding;

  String deliveryMode;

  String counterName;

  double amountPaid;

  int pointsUsed;

  int pointsEarned;

  bool pointsAwarded;

  String paymentStatus;

  String? paymentTransactionId;

  String? paymentFailureReason;

  String status;

  String? collectionCode;

  String? collectionQrToken;

  String? statusReason;

  String? processedByStaffName;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? collectedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PrintRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PrintRequest copyWith({
    int? id,
    _is.UuidValue? studentAuthUserId,
    String? studentName,
    String? studentBranch,
    int? studentYear,
    String? hostelOrLocation,
    String? fileName,
    String? fileUrl,
    int? fileSizeBytes,
    int? pageCount,
    int? copies,
    int? totalPages,
    String? printType,
    String? paperSize,
    String? printSide,
    String? binding,
    String? deliveryMode,
    String? counterName,
    double? amountPaid,
    int? pointsUsed,
    int? pointsEarned,
    bool? pointsAwarded,
    String? paymentStatus,
    String? paymentTransactionId,
    String? paymentFailureReason,
    String? status,
    String? collectionCode,
    String? collectionQrToken,
    String? statusReason,
    String? processedByStaffName,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? collectedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PrintRequest',
      if (id != null) 'id': id,
      'studentAuthUserId': studentAuthUserId.toJson(),
      'studentName': studentName,
      'studentBranch': studentBranch,
      'studentYear': studentYear,
      'hostelOrLocation': hostelOrLocation,
      'fileName': fileName,
      'fileUrl': fileUrl,
      if (fileSizeBytes != null) 'fileSizeBytes': fileSizeBytes,
      'pageCount': pageCount,
      'copies': copies,
      'totalPages': totalPages,
      'printType': printType,
      'paperSize': paperSize,
      'printSide': printSide,
      'binding': binding,
      'deliveryMode': deliveryMode,
      'counterName': counterName,
      'amountPaid': amountPaid,
      'pointsUsed': pointsUsed,
      'pointsEarned': pointsEarned,
      'pointsAwarded': pointsAwarded,
      'paymentStatus': paymentStatus,
      if (paymentTransactionId != null)
        'paymentTransactionId': paymentTransactionId,
      if (paymentFailureReason != null)
        'paymentFailureReason': paymentFailureReason,
      'status': status,
      if (collectionCode != null) 'collectionCode': collectionCode,
      if (collectionQrToken != null) 'collectionQrToken': collectionQrToken,
      if (statusReason != null) 'statusReason': statusReason,
      if (processedByStaffName != null)
        'processedByStaffName': processedByStaffName,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (collectedAt != null) 'collectedAt': collectedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PrintRequest',
      if (id != null) 'id': id,
      'studentAuthUserId': studentAuthUserId.toJson(),
      'studentName': studentName,
      'studentBranch': studentBranch,
      'studentYear': studentYear,
      'hostelOrLocation': hostelOrLocation,
      'fileName': fileName,
      'fileUrl': fileUrl,
      if (fileSizeBytes != null) 'fileSizeBytes': fileSizeBytes,
      'pageCount': pageCount,
      'copies': copies,
      'totalPages': totalPages,
      'printType': printType,
      'paperSize': paperSize,
      'printSide': printSide,
      'binding': binding,
      'deliveryMode': deliveryMode,
      'counterName': counterName,
      'amountPaid': amountPaid,
      'pointsUsed': pointsUsed,
      'pointsEarned': pointsEarned,
      'pointsAwarded': pointsAwarded,
      'paymentStatus': paymentStatus,
      if (paymentTransactionId != null)
        'paymentTransactionId': paymentTransactionId,
      if (paymentFailureReason != null)
        'paymentFailureReason': paymentFailureReason,
      'status': status,
      if (collectionCode != null) 'collectionCode': collectionCode,
      if (collectionQrToken != null) 'collectionQrToken': collectionQrToken,
      if (statusReason != null) 'statusReason': statusReason,
      if (processedByStaffName != null)
        'processedByStaffName': processedByStaffName,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (collectedAt != null) 'collectedAt': collectedAt?.toJson(),
    };
  }

  static PrintRequestInclude include() {
    return PrintRequestInclude._();
  }

  static PrintRequestIncludeList includeList({
    _is.WhereExpressionBuilder<PrintRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PrintRequestTable>? orderBy,
    _is.OrderByListBuilder<PrintRequestTable>? orderByList,
    PrintRequestInclude? include,
  }) {
    return PrintRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PrintRequest.t),
      orderByList: orderByList?.call(PrintRequest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrintRequestImpl extends PrintRequest {
  _PrintRequestImpl({
    int? id,
    required _is.UuidValue studentAuthUserId,
    required String studentName,
    required String studentBranch,
    required int studentYear,
    required String hostelOrLocation,
    required String fileName,
    required String fileUrl,
    int? fileSizeBytes,
    required int pageCount,
    required int copies,
    required int totalPages,
    required String printType,
    required String paperSize,
    required String printSide,
    required String binding,
    required String deliveryMode,
    required String counterName,
    required double amountPaid,
    required int pointsUsed,
    required int pointsEarned,
    bool? pointsAwarded,
    required String paymentStatus,
    String? paymentTransactionId,
    String? paymentFailureReason,
    required String status,
    String? collectionCode,
    String? collectionQrToken,
    String? statusReason,
    String? processedByStaffName,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? collectedAt,
  }) : super._(
         id: id,
         studentAuthUserId: studentAuthUserId,
         studentName: studentName,
         studentBranch: studentBranch,
         studentYear: studentYear,
         hostelOrLocation: hostelOrLocation,
         fileName: fileName,
         fileUrl: fileUrl,
         fileSizeBytes: fileSizeBytes,
         pageCount: pageCount,
         copies: copies,
         totalPages: totalPages,
         printType: printType,
         paperSize: paperSize,
         printSide: printSide,
         binding: binding,
         deliveryMode: deliveryMode,
         counterName: counterName,
         amountPaid: amountPaid,
         pointsUsed: pointsUsed,
         pointsEarned: pointsEarned,
         pointsAwarded: pointsAwarded,
         paymentStatus: paymentStatus,
         paymentTransactionId: paymentTransactionId,
         paymentFailureReason: paymentFailureReason,
         status: status,
         collectionCode: collectionCode,
         collectionQrToken: collectionQrToken,
         statusReason: statusReason,
         processedByStaffName: processedByStaffName,
         createdAt: createdAt,
         updatedAt: updatedAt,
         collectedAt: collectedAt,
       );

  /// Returns a shallow copy of this [PrintRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PrintRequest copyWith({
    Object? id = _Undefined,
    _is.UuidValue? studentAuthUserId,
    String? studentName,
    String? studentBranch,
    int? studentYear,
    String? hostelOrLocation,
    String? fileName,
    String? fileUrl,
    Object? fileSizeBytes = _Undefined,
    int? pageCount,
    int? copies,
    int? totalPages,
    String? printType,
    String? paperSize,
    String? printSide,
    String? binding,
    String? deliveryMode,
    String? counterName,
    double? amountPaid,
    int? pointsUsed,
    int? pointsEarned,
    bool? pointsAwarded,
    String? paymentStatus,
    Object? paymentTransactionId = _Undefined,
    Object? paymentFailureReason = _Undefined,
    String? status,
    Object? collectionCode = _Undefined,
    Object? collectionQrToken = _Undefined,
    Object? statusReason = _Undefined,
    Object? processedByStaffName = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? collectedAt = _Undefined,
  }) {
    return PrintRequest(
      id: id is int? ? id : this.id,
      studentAuthUserId: studentAuthUserId ?? this.studentAuthUserId,
      studentName: studentName ?? this.studentName,
      studentBranch: studentBranch ?? this.studentBranch,
      studentYear: studentYear ?? this.studentYear,
      hostelOrLocation: hostelOrLocation ?? this.hostelOrLocation,
      fileName: fileName ?? this.fileName,
      fileUrl: fileUrl ?? this.fileUrl,
      fileSizeBytes: fileSizeBytes is int? ? fileSizeBytes : this.fileSizeBytes,
      pageCount: pageCount ?? this.pageCount,
      copies: copies ?? this.copies,
      totalPages: totalPages ?? this.totalPages,
      printType: printType ?? this.printType,
      paperSize: paperSize ?? this.paperSize,
      printSide: printSide ?? this.printSide,
      binding: binding ?? this.binding,
      deliveryMode: deliveryMode ?? this.deliveryMode,
      counterName: counterName ?? this.counterName,
      amountPaid: amountPaid ?? this.amountPaid,
      pointsUsed: pointsUsed ?? this.pointsUsed,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      pointsAwarded: pointsAwarded ?? this.pointsAwarded,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentTransactionId: paymentTransactionId is String?
          ? paymentTransactionId
          : this.paymentTransactionId,
      paymentFailureReason: paymentFailureReason is String?
          ? paymentFailureReason
          : this.paymentFailureReason,
      status: status ?? this.status,
      collectionCode: collectionCode is String?
          ? collectionCode
          : this.collectionCode,
      collectionQrToken: collectionQrToken is String?
          ? collectionQrToken
          : this.collectionQrToken,
      statusReason: statusReason is String? ? statusReason : this.statusReason,
      processedByStaffName: processedByStaffName is String?
          ? processedByStaffName
          : this.processedByStaffName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      collectedAt: collectedAt is DateTime? ? collectedAt : this.collectedAt,
    );
  }
}

class PrintRequestUpdateTable extends _is.UpdateTable<PrintRequestTable> {
  PrintRequestUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> studentAuthUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.studentAuthUserId,
    value,
  );

  _is.ColumnValue<String, String> studentName(String value) => _is.ColumnValue(
    table.studentName,
    value,
  );

  _is.ColumnValue<String, String> studentBranch(String value) =>
      _is.ColumnValue(
        table.studentBranch,
        value,
      );

  _is.ColumnValue<int, int> studentYear(int value) => _is.ColumnValue(
    table.studentYear,
    value,
  );

  _is.ColumnValue<String, String> hostelOrLocation(String value) =>
      _is.ColumnValue(
        table.hostelOrLocation,
        value,
      );

  _is.ColumnValue<String, String> fileName(String value) => _is.ColumnValue(
    table.fileName,
    value,
  );

  _is.ColumnValue<String, String> fileUrl(String value) => _is.ColumnValue(
    table.fileUrl,
    value,
  );

  _is.ColumnValue<int, int> fileSizeBytes(int? value) => _is.ColumnValue(
    table.fileSizeBytes,
    value,
  );

  _is.ColumnValue<int, int> pageCount(int value) => _is.ColumnValue(
    table.pageCount,
    value,
  );

  _is.ColumnValue<int, int> copies(int value) => _is.ColumnValue(
    table.copies,
    value,
  );

  _is.ColumnValue<int, int> totalPages(int value) => _is.ColumnValue(
    table.totalPages,
    value,
  );

  _is.ColumnValue<String, String> printType(String value) => _is.ColumnValue(
    table.printType,
    value,
  );

  _is.ColumnValue<String, String> paperSize(String value) => _is.ColumnValue(
    table.paperSize,
    value,
  );

  _is.ColumnValue<String, String> printSide(String value) => _is.ColumnValue(
    table.printSide,
    value,
  );

  _is.ColumnValue<String, String> binding(String value) => _is.ColumnValue(
    table.binding,
    value,
  );

  _is.ColumnValue<String, String> deliveryMode(String value) => _is.ColumnValue(
    table.deliveryMode,
    value,
  );

  _is.ColumnValue<String, String> counterName(String value) => _is.ColumnValue(
    table.counterName,
    value,
  );

  _is.ColumnValue<double, double> amountPaid(double value) => _is.ColumnValue(
    table.amountPaid,
    value,
  );

  _is.ColumnValue<int, int> pointsUsed(int value) => _is.ColumnValue(
    table.pointsUsed,
    value,
  );

  _is.ColumnValue<int, int> pointsEarned(int value) => _is.ColumnValue(
    table.pointsEarned,
    value,
  );

  _is.ColumnValue<bool, bool> pointsAwarded(bool value) => _is.ColumnValue(
    table.pointsAwarded,
    value,
  );

  _is.ColumnValue<String, String> paymentStatus(String value) =>
      _is.ColumnValue(
        table.paymentStatus,
        value,
      );

  _is.ColumnValue<String, String> paymentTransactionId(String? value) =>
      _is.ColumnValue(
        table.paymentTransactionId,
        value,
      );

  _is.ColumnValue<String, String> paymentFailureReason(String? value) =>
      _is.ColumnValue(
        table.paymentFailureReason,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> collectionCode(String? value) =>
      _is.ColumnValue(
        table.collectionCode,
        value,
      );

  _is.ColumnValue<String, String> collectionQrToken(String? value) =>
      _is.ColumnValue(
        table.collectionQrToken,
        value,
      );

  _is.ColumnValue<String, String> statusReason(String? value) =>
      _is.ColumnValue(
        table.statusReason,
        value,
      );

  _is.ColumnValue<String, String> processedByStaffName(String? value) =>
      _is.ColumnValue(
        table.processedByStaffName,
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

  _is.ColumnValue<DateTime, DateTime> collectedAt(DateTime? value) =>
      _is.ColumnValue(
        table.collectedAt,
        value,
      );
}

class PrintRequestTable extends _is.Table<int?> {
  PrintRequestTable({super.tableRelation})
    : super(tableName: 'print_requests') {
    updateTable = PrintRequestUpdateTable(this);
    studentAuthUserId = _is.ColumnUuid(
      'studentAuthUserId',
      this,
    );
    studentName = _is.ColumnString(
      'studentName',
      this,
    );
    studentBranch = _is.ColumnString(
      'studentBranch',
      this,
    );
    studentYear = _is.ColumnInt(
      'studentYear',
      this,
    );
    hostelOrLocation = _is.ColumnString(
      'hostelOrLocation',
      this,
    );
    fileName = _is.ColumnString(
      'fileName',
      this,
    );
    fileUrl = _is.ColumnString(
      'fileUrl',
      this,
    );
    fileSizeBytes = _is.ColumnInt(
      'fileSizeBytes',
      this,
    );
    pageCount = _is.ColumnInt(
      'pageCount',
      this,
    );
    copies = _is.ColumnInt(
      'copies',
      this,
    );
    totalPages = _is.ColumnInt(
      'totalPages',
      this,
    );
    printType = _is.ColumnString(
      'printType',
      this,
    );
    paperSize = _is.ColumnString(
      'paperSize',
      this,
    );
    printSide = _is.ColumnString(
      'printSide',
      this,
    );
    binding = _is.ColumnString(
      'binding',
      this,
    );
    deliveryMode = _is.ColumnString(
      'deliveryMode',
      this,
    );
    counterName = _is.ColumnString(
      'counterName',
      this,
    );
    amountPaid = _is.ColumnDouble(
      'amountPaid',
      this,
    );
    pointsUsed = _is.ColumnInt(
      'pointsUsed',
      this,
    );
    pointsEarned = _is.ColumnInt(
      'pointsEarned',
      this,
    );
    pointsAwarded = _is.ColumnBool(
      'pointsAwarded',
      this,
      hasDefault: true,
    );
    paymentStatus = _is.ColumnString(
      'paymentStatus',
      this,
    );
    paymentTransactionId = _is.ColumnString(
      'paymentTransactionId',
      this,
    );
    paymentFailureReason = _is.ColumnString(
      'paymentFailureReason',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    collectionCode = _is.ColumnString(
      'collectionCode',
      this,
    );
    collectionQrToken = _is.ColumnString(
      'collectionQrToken',
      this,
    );
    statusReason = _is.ColumnString(
      'statusReason',
      this,
    );
    processedByStaffName = _is.ColumnString(
      'processedByStaffName',
      this,
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
    collectedAt = _is.ColumnDateTime(
      'collectedAt',
      this,
    );
  }

  late final PrintRequestUpdateTable updateTable;

  late final _is.ColumnUuid studentAuthUserId;

  late final _is.ColumnString studentName;

  late final _is.ColumnString studentBranch;

  late final _is.ColumnInt studentYear;

  late final _is.ColumnString hostelOrLocation;

  late final _is.ColumnString fileName;

  late final _is.ColumnString fileUrl;

  late final _is.ColumnInt fileSizeBytes;

  late final _is.ColumnInt pageCount;

  late final _is.ColumnInt copies;

  late final _is.ColumnInt totalPages;

  late final _is.ColumnString printType;

  late final _is.ColumnString paperSize;

  late final _is.ColumnString printSide;

  late final _is.ColumnString binding;

  late final _is.ColumnString deliveryMode;

  late final _is.ColumnString counterName;

  late final _is.ColumnDouble amountPaid;

  late final _is.ColumnInt pointsUsed;

  late final _is.ColumnInt pointsEarned;

  late final _is.ColumnBool pointsAwarded;

  late final _is.ColumnString paymentStatus;

  late final _is.ColumnString paymentTransactionId;

  late final _is.ColumnString paymentFailureReason;

  late final _is.ColumnString status;

  late final _is.ColumnString collectionCode;

  late final _is.ColumnString collectionQrToken;

  late final _is.ColumnString statusReason;

  late final _is.ColumnString processedByStaffName;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnDateTime collectedAt;

  @override
  List<_is.Column> get columns => [
    id,
    studentAuthUserId,
    studentName,
    studentBranch,
    studentYear,
    hostelOrLocation,
    fileName,
    fileUrl,
    fileSizeBytes,
    pageCount,
    copies,
    totalPages,
    printType,
    paperSize,
    printSide,
    binding,
    deliveryMode,
    counterName,
    amountPaid,
    pointsUsed,
    pointsEarned,
    pointsAwarded,
    paymentStatus,
    paymentTransactionId,
    paymentFailureReason,
    status,
    collectionCode,
    collectionQrToken,
    statusReason,
    processedByStaffName,
    createdAt,
    updatedAt,
    collectedAt,
  ];
}

class PrintRequestInclude extends _is.IncludeObject {
  PrintRequestInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PrintRequest.t;
}

class PrintRequestIncludeList extends _is.IncludeList {
  PrintRequestIncludeList._({
    _is.WhereExpressionBuilder<PrintRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PrintRequest.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PrintRequest.t;
}

class PrintRequestRepository {
  const PrintRequestRepository._();

  /// Returns a list of [PrintRequest]s matching the given query parameters.
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
  Future<List<PrintRequest>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PrintRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PrintRequestTable>? orderBy,
    _is.OrderByListBuilder<PrintRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PrintRequest>(
      where: where?.call(PrintRequest.t),
      orderBy: orderBy?.call(PrintRequest.t),
      orderByList: orderByList?.call(PrintRequest.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PrintRequest] matching the given query parameters.
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
  Future<PrintRequest?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PrintRequestTable>? where,
    int? offset,
    _is.OrderByBuilder<PrintRequestTable>? orderBy,
    _is.OrderByListBuilder<PrintRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PrintRequest>(
      where: where?.call(PrintRequest.t),
      orderBy: orderBy?.call(PrintRequest.t),
      orderByList: orderByList?.call(PrintRequest.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PrintRequest] by its [id] or null if no such row exists.
  Future<PrintRequest?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PrintRequest>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PrintRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [PrintRequest]s will have their `id` fields set.
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
  Future<List<PrintRequest>> insert(
    _is.DatabaseSession session,
    List<PrintRequest> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PrintRequest>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PrintRequest] and returns the inserted row.
  ///
  /// The returned [PrintRequest] will have its `id` field set.
  Future<PrintRequest> insertRow(
    _is.DatabaseSession session,
    PrintRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PrintRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PrintRequest]s in the list and returns the resulting rows.
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
  /// The returned [PrintRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PrintRequest>> upsert(
    _is.DatabaseSession session,
    List<PrintRequest> rows, {
    required _is.ColumnSelections<PrintRequestTable> conflictColumns,
    _is.ColumnSelections<PrintRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<PrintRequestTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PrintRequest>(
      rows,
      conflictColumns: conflictColumns(PrintRequest.t),
      updateColumns: updateColumns?.call(PrintRequest.t),
      updateWhere: updateWhere?.call(PrintRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PrintRequest] and returns the resulting row.
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
  /// The returned [PrintRequest] will have its `id` field set.
  Future<PrintRequest?> upsertRow(
    _is.DatabaseSession session,
    PrintRequest row, {
    required _is.ColumnSelections<PrintRequestTable> conflictColumns,
    _is.ColumnSelections<PrintRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<PrintRequestTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PrintRequest>(
      row,
      conflictColumns: conflictColumns(PrintRequest.t),
      updateColumns: updateColumns?.call(PrintRequest.t),
      updateWhere: updateWhere?.call(PrintRequest.t),
      transaction: transaction,
    );
  }

  /// Updates all [PrintRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PrintRequest>> update(
    _is.DatabaseSession session,
    List<PrintRequest> rows, {
    _is.ColumnSelections<PrintRequestTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PrintRequest>(
      rows,
      columns: columns?.call(PrintRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PrintRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PrintRequest> updateRow(
    _is.DatabaseSession session,
    PrintRequest row, {
    _is.ColumnSelections<PrintRequestTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PrintRequest>(
      row,
      columns: columns?.call(PrintRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PrintRequest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PrintRequest?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PrintRequestUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PrintRequest>(
      id,
      columnValues: columnValues(PrintRequest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PrintRequest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PrintRequest>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PrintRequestUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PrintRequestTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PrintRequestTable>? orderBy,
    _is.OrderByListBuilder<PrintRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PrintRequest>(
      columnValues: columnValues(PrintRequest.t.updateTable),
      where: where(PrintRequest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PrintRequest.t),
      orderByList: orderByList?.call(PrintRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PrintRequest]s in the list and returns the deleted rows.
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
  Future<List<PrintRequest>> delete(
    _is.DatabaseSession session,
    List<PrintRequest> rows, {
    _is.OrderByBuilder<PrintRequestTable>? orderBy,
    _is.OrderByListBuilder<PrintRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PrintRequest>(
      rows,
      orderBy: orderBy?.call(PrintRequest.t),
      orderByList: orderByList?.call(PrintRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PrintRequest].
  Future<PrintRequest> deleteRow(
    _is.DatabaseSession session,
    PrintRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PrintRequest>(
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
  Future<List<PrintRequest>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PrintRequestTable> where,
    _is.OrderByBuilder<PrintRequestTable>? orderBy,
    _is.OrderByListBuilder<PrintRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PrintRequest>(
      where: where(PrintRequest.t),
      orderBy: orderBy?.call(PrintRequest.t),
      orderByList: orderByList?.call(PrintRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PrintRequestTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PrintRequest>(
      where: where?.call(PrintRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PrintRequest] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PrintRequestTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PrintRequest>(
      where: where(PrintRequest.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
