import 'dart:math';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';
import '../services/notification_service.dart';
import 'admin_endpoint.dart';

class LibraryEndpoint extends Endpoint {
  static const List<String> defaultCounters = [
    'Central Library Main Counter',
    'Engineering Block Photocopy Hub',
    'Hostel Cluster B Print Kiosk',
  ];

  // ==================== AUTH & ROLES HELPERS ====================

  /// Checks if the authenticated user has 'library_staff' or 'admin' role
  static Future<bool> isLibraryStaffOrAdmin(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    // Check if master admin
    if (await AdminEndpoint.isAdmin(session)) return true;

    // Check if library_staff role
    final staffRole = await UserRole.db.findFirstRow(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) & t.role.equals('library_staff'),
    );
    return staffRole != null;
  }

  /// Returns assigned counter name for library staff, or null if admin (access to all)
  static Future<String?> getStaffAssignedCounter(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return null;

    if (await AdminEndpoint.isAdmin(session)) return null;

    final staffRole = await UserRole.db.findFirstRow(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) & t.role.equals('library_staff'),
    );
    return staffRole?.assignedScope ?? defaultCounters.first;
  }

  // ==================== STAFF PROFILE & COUNTERS ====================

  /// Returns staff metadata (role, assigned counter)
  Future<Map<String, dynamic>> getStaffProfile(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('Authentication required.');
    }

    final isAdmin = await AdminEndpoint.isAdmin(session);
    final isStaff = await isLibraryStaffOrAdmin(session);
    final assignedCounter = await getStaffAssignedCounter(session);

    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    return {
      'staffName': profile?.fullName ?? 'Library Staff',
      'email': profile?.email ?? '',
      'isAdmin': isAdmin,
      'isStaff': isStaff,
      'assignedCounter': assignedCounter ?? 'All Counters (Admin)',
      'availableCounters': defaultCounters,
    };
  }

  /// List available print counters
  Future<List<String>> getAvailableCounters(Session session) async {
    return defaultCounters;
  }

  // ==================== STAFF PRINT REQUEST DASHBOARD ====================

  /// Fetch paid library print requests for the library staff dashboard
  Future<List<PrintRequest>> getLibraryRequests(
    Session session, {
    String? counterName,
    String? statusFilter,
    String? searchQuery,
    int limit = 100,
    int offset = 0,
  }) async {
    final isAuthorized = await isLibraryStaffOrAdmin(session);
    if (!isAuthorized) {
      throw StateError('Access denied: Library Staff or Admin role required.');
    }

    final staffCounter = await getStaffAssignedCounter(session);
    final effectiveCounter = staffCounter ?? counterName;

    return await PrintRequest.db.find(
      session,
      where: (t) {
        // Enforce payment safety: only paid requests reach the library dashboard
        Expression expr = t.paymentStatus.equals('SUCCESS');

        // Scoped counter filter
        if (effectiveCounter != null &&
            effectiveCounter.isNotEmpty &&
            effectiveCounter != 'All') {
          expr = expr & t.counterName.equals(effectiveCounter);
        }

        // Status filter
        if (statusFilter != null &&
            statusFilter.isNotEmpty &&
            statusFilter.toUpperCase() != 'ALL') {
          expr = expr & t.status.equals(statusFilter.toUpperCase());
        }

        // Search query (student name, request ID, or collection code)
        if (searchQuery != null && searchQuery.trim().isNotEmpty) {
          final q = searchQuery.trim();
          final idNum = int.tryParse(
            q.replaceAll('#PR-', '').replaceAll('#', ''),
          );
          Expression searchExpr =
              t.studentName.ilike('%$q%') |
              t.collectionCode.ilike('%$q%') |
              t.fileName.ilike('%$q%');
          if (idNum != null) {
            searchExpr = searchExpr | t.id.equals(idNum);
          }
          expr = expr & searchExpr;
        }

        return expr;
      },
      orderBy: (t) => t.createdAt.desc(),
      limit: limit.clamp(1, 200),
      offset: offset,
    );
  }

  /// Update print request status: QUEUED -> PRINTING -> READY -> COLLECTED
  Future<PrintRequest> updateRequestStatus(
    Session session, {
    required int requestId,
    required String targetStatus,
    String? reason,
  }) async {
    final isAuthorized = await isLibraryStaffOrAdmin(session);
    if (!isAuthorized) {
      throw StateError('Access denied: Library Staff or Admin role required.');
    }

    final authUserId = session.authenticated!.authUserId;
    final staffProfile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final staffName = staffProfile?.fullName ?? 'Library Staff';

    final normalizedStatus = targetStatus.trim().toUpperCase();
    final allowedStatuses = [
      'QUEUED',
      'PRINTING',
      'READY',
      'COLLECTED',
      'CANCELLED',
      'REFUNDED',
    ];
    if (!allowedStatuses.contains(normalizedStatus)) {
      throw ArgumentError('Invalid status: $targetStatus');
    }

    // Cancellation and refund require mandatory reason
    if (normalizedStatus == 'CANCELLED' || normalizedStatus == 'REFUNDED') {
      if (reason == null || reason.trim().isEmpty) {
        throw ArgumentError(
          'A mandatory reason is required when cancelling or refunding a request.',
        );
      }
    }

    late PrintRequest updated;

    await session.db.transaction((transaction) async {
      final req = await PrintRequest.db.findById(
        session,
        requestId,
        transaction: transaction,
      );
      if (req == null) throw ArgumentError('Print request not found.');

      if (req.status == 'COLLECTED' && normalizedStatus != 'COLLECTED') {
        throw StateError(
          'Cannot modify status of an already collected request.',
        );
      }

      String? newCode = req.collectionCode;
      String? newQr = req.collectionQrToken;

      // When moving to READY, generate unique 6-digit collection code & QR token if not yet present
      if (normalizedStatus == 'READY' && (newCode == null || newCode.isEmpty)) {
        final rand = Random();
        newCode = (100000 + rand.nextInt(900000)).toString();
        newQr = 'CAMPUS-PRINT-$newCode-$requestId';
      }

      // Handle refund of points if request is cancelled/refunded and points were used
      if ((normalizedStatus == 'CANCELLED' || normalizedStatus == 'REFUNDED') &&
          req.pointsUsed > 0 &&
          req.status != 'CANCELLED' &&
          req.status != 'REFUNDED') {
        await _refundPoints(
          session,
          studentAuthUserId: req.studentAuthUserId,
          studentName: req.studentName,
          requestId: req.id!,
          pointsToRefund: req.pointsUsed,
          transaction: transaction,
        );
      }

      final now = DateTime.now().toUtc();
      updated = req.copyWith(
        status: normalizedStatus,
        collectionCode: newCode,
        collectionQrToken: newQr,
        statusReason: reason?.trim() ?? req.statusReason,
        processedByStaffName: staffName,
        updatedAt: now,
      );

      await PrintRequest.db.updateRow(
        session,
        updated,
        transaction: transaction,
      );
    });

    // Notify student on status transitions
    try {
      if (normalizedStatus == 'READY' && updated.collectionCode != null) {
        await NotificationService.sendNotification(
          session,
          authUserId: updated.studentAuthUserId,
          title: 'Document Ready for Collection! 🖨️',
          message:
              'Your document "${updated.fileName}" is printed and ready at ${updated.counterName}. Present Collection Code: ${updated.collectionCode}.',
          type: 'library_print',
          targetRoute: 'print_shop',
          targetId: updated.id.toString(),
          eventIdTag: 'print_ready_${updated.id}',
        );
      } else if (normalizedStatus == 'CANCELLED' ||
          normalizedStatus == 'REFUNDED') {
        await NotificationService.sendNotification(
          session,
          authUserId: updated.studentAuthUserId,
          title: 'Print Request $normalizedStatus',
          message:
              'Print request #${updated.id} (${updated.fileName}) was $normalizedStatus. Reason: ${reason ?? 'Order cancelled.'}',
          type: 'library_print',
          targetRoute: 'print_shop',
          targetId: updated.id.toString(),
          eventIdTag: 'print_cancel_${updated.id}',
        );
      }
    } catch (_) {}

    return updated;
  }

  /// Verify collection code or QR token and mark request as COLLECTED, awarding points
  Future<PrintRequest> verifyCollection(
    Session session, {
    required String collectionCodeOrToken,
  }) async {
    final isAuthorized = await isLibraryStaffOrAdmin(session);
    if (!isAuthorized) {
      throw StateError('Access denied: Library Staff or Admin role required.');
    }

    final cleanInput = collectionCodeOrToken.trim();
    if (cleanInput.isEmpty) {
      throw ArgumentError('Collection code or QR token is required.');
    }

    final authUserId = session.authenticated!.authUserId;
    final staffProfile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final staffName = staffProfile?.fullName ?? 'Library Staff';

    late PrintRequest updated;

    await session.db.transaction((transaction) async {
      // Find request by code or QR token
      final req = await PrintRequest.db.findFirstRow(
        session,
        where: (t) =>
            t.collectionCode.equals(cleanInput) |
            t.collectionQrToken.equals(cleanInput),
        transaction: transaction,
      );

      if (req == null) {
        throw ArgumentError('Invalid collection code or QR token.');
      }

      if (req.status == 'COLLECTED') {
        throw StateError(
          'This print request has already been collected on ${req.collectedAt?.toLocal() ?? 'earlier'}.',
        );
      }

      if (req.status != 'READY') {
        throw StateError(
          'Request is not in READY status (current status: ${req.status}). Must be printed first.',
        );
      }

      final now = DateTime.now().toUtc();

      // Credit student points ONLY IF not previously awarded (idempotency guard)
      if (!req.pointsAwarded && req.pointsEarned > 0) {
        await _creditPoints(
          session,
          studentAuthUserId: req.studentAuthUserId,
          studentName: req.studentName,
          requestId: req.id!,
          pointsToCredit: req.pointsEarned,
          totalPages: req.totalPages,
          transaction: transaction,
        );
      }

      updated = req.copyWith(
        status: 'COLLECTED',
        pointsAwarded: true,
        collectedAt: now,
        processedByStaffName: staffName,
        updatedAt: now,
      );

      await PrintRequest.db.updateRow(
        session,
        updated,
        transaction: transaction,
      );
    });

    // Notify student of collection & points credited
    try {
      await NotificationService.sendNotification(
        session,
        authUserId: updated.studentAuthUserId,
        title: 'Printout Collected! 🎉',
        message:
            'Printout collected. ${updated.pointsEarned} Pulse Points credited to your points wallet.',
        type: 'library_print',
        targetRoute: 'print_shop',
        targetId: updated.id.toString(),
        eventIdTag: 'print_collected_${updated.id}',
      );
    } catch (_) {}

    return updated;
  }

  // ==================== STUDENT PRINT ORDERS ====================

  /// Fetch caller student's print requests
  Future<List<PrintRequest>> getStudentPrintRequests(
    Session session, {
    String? paymentStatusFilter,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated.');
    }

    return await PrintRequest.db.find(
      session,
      where: (t) {
        Expression expr = t.studentAuthUserId.equals(authUserId);
        if (paymentStatusFilter != null &&
            paymentStatusFilter.isNotEmpty &&
            paymentStatusFilter.toUpperCase() != 'ALL') {
          expr =
              expr & t.paymentStatus.equals(paymentStatusFilter.toUpperCase());
        }
        return expr;
      },
      orderBy: (t) => t.createdAt.desc(),
      limit: 100,
    );
  }

  /// Create a new print request with payment gating and optional point redemption
  Future<PrintRequest> createPrintRequest(
    Session session, {
    required String fileName,
    required String fileUrl,
    int? fileSizeBytes,
    required int pageCount,
    required int copies,
    required String printType, // 'Black & White' or 'Colour'
    required String paperSize, // 'A4' or 'A3'
    required String printSide, // 'Single-side' or 'Double-side'
    required String binding, // 'None', 'Staple', 'Spiral'
    required String deliveryMode, // 'Library pickup' or 'Hostel delivery'
    required String counterName,
    required int pointsToRedeem,
    required bool simulatePaymentFailure,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated to create a print request.');
    }

    final student = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final studentName = student?.fullName ?? 'Student';
    final branch = student?.branch ?? 'General';
    final year = student?.academicYear ?? 1;
    final hostel = student?.hostelOrArea ?? 'Campus Resident';

    final safePages = pageCount.clamp(1, 500);
    final safeCopies = copies.clamp(1, 50);
    final totalPages = safePages * safeCopies;

    // Price calculation:
    // B&W A4 = ₹2/page (Double side = ₹1.50/page -> ₹3 for 2 pages)
    // Colour A4 = ₹10/page
    // A3 = 2x multiplier
    double pageCost = (printType == 'Colour')
        ? 10.0
        : (printSide == 'Double-side' ? 1.50 : 2.00);
    if (paperSize == 'A3') pageCost *= 2.0;

    double bindingCost = switch (binding) {
      'Staple' => 5.0,
      'Spiral' => 30.0,
      _ => 0.0,
    };

    double deliveryCost = (deliveryMode == 'Hostel delivery') ? 15.0 : 0.0;

    // Points rule: 20 points = 1 free page
    // Validate points to redeem (must be positive multiple of 20)
    int cleanPoints = (pointsToRedeem ~/ 20) * 20;
    if (cleanPoints < 0) cleanPoints = 0;
    final maxFreePages = cleanPoints ~/ 20;
    final actualFreePages = min(maxFreePages, totalPages);
    final actualPointsUsed = actualFreePages * 20;

    final subtotal = totalPages * pageCost;
    final pointsDiscount = actualFreePages * pageCost;
    final finalAmount = max(
      0.0,
      subtotal - pointsDiscount + bindingCost + deliveryCost,
    );

    // Points earned = 1 point per total page printed
    final pointsEarned = totalPages;

    final now = DateTime.now().toUtc();
    late PrintRequest created;

    await session.db.transaction((transaction) async {
      // 1. Check points balance if redeeming points
      if (actualPointsUsed > 0 && !simulatePaymentFailure) {
        final wallet = await _getOrCreateWallet(
          session,
          authUserId,
          studentName,
          transaction: transaction,
        );
        if (wallet.balance < actualPointsUsed) {
          throw StateError(
            'Insufficient Pulse Points balance. You have ${wallet.balance} points, needed $actualPointsUsed.',
          );
        }

        // Deduct points
        final newBalance = wallet.balance - actualPointsUsed;
        await PrintPointWallet.db.updateRow(
          session,
          wallet.copyWith(
            balance: newBalance,
            lifetimeRedeemed: wallet.lifetimeRedeemed + actualPointsUsed,
            updatedAt: now,
          ),
          transaction: transaction,
        );

        // Record point transaction
        await PrintPointTransaction.db.insertRow(
          session,
          PrintPointTransaction(
            authUserId: authUserId,
            type: 'REDEEMED',
            points: -actualPointsUsed,
            balanceAfter: newBalance,
            description:
                'Used $actualPointsUsed points for $actualFreePages free page(s) on "$fileName"',
            createdAt: now,
          ),
          transaction: transaction,
        );

        // Also record in platform PointsLedger
        await PointsLedger.db.insertRow(
          session,
          PointsLedger(
            authUserId: authUserId,
            studentName: studentName,
            source: 'print_discount',
            points: -actualPointsUsed,
            description: 'Redeemed points for print discount ($fileName)',
            timestamp: now,
          ),
          transaction: transaction,
        );
      }

      // 2. Set Payment & Queue Status
      final paymentStatus = simulatePaymentFailure ? 'FAILED' : 'SUCCESS';
      final status = simulatePaymentFailure ? 'CANCELLED' : 'QUEUED';
      final failureReason = simulatePaymentFailure
          ? 'Card payment failed: Issuing bank declined transaction'
          : null;
      final txnId = simulatePaymentFailure
          ? null
          : 'TXN_${now.millisecondsSinceEpoch}_${Random().nextInt(9999)}';

      final request = PrintRequest(
        studentAuthUserId: authUserId,
        studentName: studentName,
        studentBranch: branch,
        studentYear: year,
        hostelOrLocation: hostel,
        fileName: fileName.trim(),
        fileUrl: fileUrl.trim(),
        fileSizeBytes: fileSizeBytes,
        pageCount: safePages,
        copies: safeCopies,
        totalPages: totalPages,
        printType: printType,
        paperSize: paperSize,
        printSide: printSide,
        binding: binding,
        deliveryMode: deliveryMode,
        counterName: counterName,
        amountPaid: finalAmount,
        pointsUsed: actualPointsUsed,
        pointsEarned: pointsEarned,
        pointsAwarded: false,
        paymentStatus: paymentStatus,
        paymentTransactionId: txnId,
        paymentFailureReason: failureReason,
        status: status,
        createdAt: now,
        updatedAt: now,
      );

      created = await PrintRequest.db.insertRow(
        session,
        request,
        transaction: transaction,
      );
    });

    return created;
  }

  /// Retry failed payment for a print request
  Future<PrintRequest> retryPrintPayment(
    Session session, {
    required int requestId,
    required bool simulatePaymentFailure,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('User must be authenticated.');
    }

    late PrintRequest updated;

    await session.db.transaction((transaction) async {
      final req = await PrintRequest.db.findById(
        session,
        requestId,
        transaction: transaction,
      );
      if (req == null) throw ArgumentError('Print request not found.');

      if (req.studentAuthUserId != authUserId) {
        throw StateError('Unauthorized: Can only retry your own print orders.');
      }

      if (req.paymentStatus == 'SUCCESS') {
        throw StateError('This print request is already paid for.');
      }

      if (simulatePaymentFailure) {
        throw StateError(
          'Payment retry failed. Please try a different payment card.',
        );
      }

      final now = DateTime.now().toUtc();
      final txnId =
          'TXN_RETRY_${now.millisecondsSinceEpoch}_${Random().nextInt(9999)}';

      // Deduct points if request had points applied
      if (req.pointsUsed > 0) {
        final wallet = await _getOrCreateWallet(
          session,
          authUserId,
          req.studentName,
          transaction: transaction,
        );
        if (wallet.balance < req.pointsUsed) {
          throw StateError('Insufficient Pulse Points balance for retry.');
        }

        final newBalance = wallet.balance - req.pointsUsed;
        await PrintPointWallet.db.updateRow(
          session,
          wallet.copyWith(
            balance: newBalance,
            lifetimeRedeemed: wallet.lifetimeRedeemed + req.pointsUsed,
            updatedAt: now,
          ),
          transaction: transaction,
        );

        await PrintPointTransaction.db.insertRow(
          session,
          PrintPointTransaction(
            authUserId: authUserId,
            printRequestId: req.id,
            type: 'REDEEMED',
            points: -req.pointsUsed,
            balanceAfter: newBalance,
            description:
                'Redeemed points on payment retry for "${req.fileName}"',
            createdAt: now,
          ),
          transaction: transaction,
        );
      }

      updated = req.copyWith(
        paymentStatus: 'SUCCESS',
        status: 'QUEUED',
        paymentTransactionId: txnId,
        paymentFailureReason: null,
        updatedAt: now,
      );

      await PrintRequest.db.updateRow(
        session,
        updated,
        transaction: transaction,
      );
    });

    return updated;
  }

  // ==================== POINTS & WALLET ====================

  /// Get student's print points wallet
  Future<PrintPointWallet> getStudentPointWallet(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('Authentication required.');
    }

    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final studentName = profile?.fullName ?? 'Student';

    return await _getOrCreateWallet(session, authUserId, studentName);
  }

  /// Get point transaction history for caller
  Future<List<PrintPointTransaction>> getPointTransactions(
    Session session, {
    int limit = 50,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StateError('Authentication required.');
    }

    return await PrintPointTransaction.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      orderBy: (t) => t.createdAt.desc(),
      limit: limit.clamp(1, 100),
    );
  }

  // ==================== INTERNAL WALLET UTILITIES ====================

  Future<PrintPointWallet> _getOrCreateWallet(
    Session session,
    UuidValue authUserId,
    String studentName, {
    Transaction? transaction,
  }) async {
    final existing = await PrintPointWallet.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      transaction: transaction,
    );
    if (existing != null) return existing;

    final now = DateTime.now().toUtc();
    final newWallet = PrintPointWallet(
      authUserId: authUserId,
      studentName: studentName,
      balance: 40, // Give 40 starter points (worth 2 free pages)
      lifetimeEarned: 40,
      lifetimeRedeemed: 0,
      updatedAt: now,
    );

    return await PrintPointWallet.db.insertRow(
      session,
      newWallet,
      transaction: transaction,
    );
  }

  Future<void> _creditPoints(
    Session session, {
    required UuidValue studentAuthUserId,
    required String studentName,
    required int requestId,
    required int pointsToCredit,
    required int totalPages,
    required Transaction transaction,
  }) async {
    final wallet = await _getOrCreateWallet(
      session,
      studentAuthUserId,
      studentName,
      transaction: transaction,
    );

    final newBalance = wallet.balance + pointsToCredit;
    await PrintPointWallet.db.updateRow(
      session,
      wallet.copyWith(
        balance: newBalance,
        lifetimeEarned: wallet.lifetimeEarned + pointsToCredit,
        updatedAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );

    await PrintPointTransaction.db.insertRow(
      session,
      PrintPointTransaction(
        authUserId: studentAuthUserId,
        printRequestId: requestId,
        type: 'EARNED',
        points: pointsToCredit,
        balanceAfter: newBalance,
        description:
            'Earned $pointsToCredit Pulse Points for $totalPages page(s) collected',
        createdAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );

    // Sync with platform-wide PointsLedger
    await PointsLedger.db.insertRow(
      session,
      PointsLedger(
        authUserId: studentAuthUserId,
        studentName: studentName,
        source: 'print_collection',
        points: pointsToCredit,
        description: 'Earned points for print request #$requestId collection',
        timestamp: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );
  }

  Future<void> _refundPoints(
    Session session, {
    required UuidValue studentAuthUserId,
    required String studentName,
    required int requestId,
    required int pointsToRefund,
    required Transaction transaction,
  }) async {
    final wallet = await _getOrCreateWallet(
      session,
      studentAuthUserId,
      studentName,
      transaction: transaction,
    );

    final newBalance = wallet.balance + pointsToRefund;
    await PrintPointWallet.db.updateRow(
      session,
      wallet.copyWith(
        balance: newBalance,
        lifetimeRedeemed: max(0, wallet.lifetimeRedeemed - pointsToRefund),
        updatedAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );

    await PrintPointTransaction.db.insertRow(
      session,
      PrintPointTransaction(
        authUserId: studentAuthUserId,
        printRequestId: requestId,
        type: 'REFUNDED',
        points: pointsToRefund,
        balanceAfter: newBalance,
        description:
            'Refunded $pointsToRefund points for cancelled order #$requestId',
        createdAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );
  }
}
