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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class PrintRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _isc.UuidValue studentAuthUserId,
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
      studentAuthUserId: _isc.UuidValueJsonExtension.fromJson(
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
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['pointsAwarded']),
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      collectedAt: jsonSerialization['collectedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['collectedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue studentAuthUserId;

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

  /// Returns a shallow copy of this [PrintRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PrintRequest copyWith({
    int? id,
    _isc.UuidValue? studentAuthUserId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrintRequestImpl extends PrintRequest {
  _PrintRequestImpl({
    int? id,
    required _isc.UuidValue studentAuthUserId,
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
  @_isc.useResult
  @override
  PrintRequest copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? studentAuthUserId,
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
