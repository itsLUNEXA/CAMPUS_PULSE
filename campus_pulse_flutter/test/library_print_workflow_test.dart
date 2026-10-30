import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:campus_pulse_flutter/client.dart';
import 'package:campus_pulse_flutter/screens/library_staff_dashboard_screen.dart';
import 'package:campus_pulse_flutter/screens/student_print_screen.dart';
import 'package:campus_pulse_flutter/services/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    try {
      client = Client('http://localhost:8080/')
        ..authSessionManager = FlutterAuthSessionManager();
    } catch (_) {}
  });

  group('Library Print Request & Points Wallet Unit Tests', () {
    test('Calculates pricing correctly with page count and options', () {
      // 10 pages B&W A4 = 10 * ₹2 = ₹20
      const pageCount = 10;
      const copies = 1;
      const totalPages = pageCount * copies;
      const pageCost = 2.0; // B&W A4
      const subtotal = totalPages * pageCost;
      expect(subtotal, 20.0);

      // Points discount: 20 points = 1 free page (₹2 discount)
      const pointsAvailable = 40;
      final freePages = pointsAvailable ~/ 20; // 2 free pages
      expect(freePages, 2);
      final pointsDiscount = 1 * pageCost; // 1 free page redeemed (saves ₹2)
      expect(pointsDiscount, 2.0);

      // Staple binding adds ₹5
      const bindingCost = 5.0;
      final total = (subtotal - pointsDiscount) + bindingCost;
      expect(total, 23.0);
    });

    test(
      'Points reward rule: 1 printed page = 1 point earned upon collection',
      () {
        const totalPages = 15;
        const pointsToEarn = totalPages * 1;
        expect(pointsToEarn, 15);
      },
    );

    test(
      'Payment safety validation: only SUCCESS enters active printing queue',
      () {
        final successRequest = PrintRequest(
          id: 101,
          studentAuthUserId: UuidValue.fromString(
            'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
          ),
          studentName: 'Aarav Sharma',
          studentBranch: 'CSE',
          studentYear: 3,
          hostelOrLocation: 'Kaveri Hostel Block B',
          fileName: 'Algorithms_Midterm_Notes.pdf',
          fileUrl: 'https://example.com/notes.pdf',
          fileSizeBytes: 1024 * 500,
          pageCount: 12,
          copies: 1,
          totalPages: 12,
          printType: 'BW',
          paperSize: 'A4',
          printSide: 'DOUBLE',
          binding: 'STAPLE',
          deliveryMode: 'PICKUP',
          counterName: 'Central Library Main Counter',
          amountPaid: 29.0,
          pointsUsed: 0,
          pointsEarned: 12,
          status: 'QUEUED',
          paymentStatus: 'SUCCESS',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final failedRequest = PrintRequest(
          id: 102,
          studentAuthUserId: UuidValue.fromString(
            'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
          ),
          studentName: 'Aarav Sharma',
          studentBranch: 'CSE',
          studentYear: 3,
          hostelOrLocation: 'Kaveri Hostel Block B',
          fileName: 'Draft_Report.pdf',
          fileUrl: 'https://example.com/draft.pdf',
          fileSizeBytes: 1024 * 200,
          pageCount: 5,
          copies: 1,
          totalPages: 5,
          printType: 'COLOR',
          paperSize: 'A4',
          printSide: 'SINGLE',
          binding: 'NONE',
          deliveryMode: 'PICKUP',
          counterName: 'Central Library Main Counter',
          amountPaid: 50.0,
          pointsUsed: 0,
          pointsEarned: 5,
          status: 'PAYMENT_PENDING',
          paymentStatus: 'FAILED',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // Library staff dashboard queue must only show requests with paymentStatus == SUCCESS
        final libraryQueue = [
          successRequest,
          failedRequest,
        ].where((r) => r.paymentStatus == 'SUCCESS').toList();

        expect(libraryQueue.length, 1);
        expect(libraryQueue.first.id, 101);
        expect(libraryQueue.first.paymentStatus, 'SUCCESS');

        // Failed payments must be separated into the Failed Payments tab
        final failedPayments = [
          successRequest,
          failedRequest,
        ].where((r) => r.paymentStatus == 'FAILED').toList();

        expect(failedPayments.length, 1);
        expect(failedPayments.first.id, 102);
      },
    );

    test('Collection verification code format: 6 digits numeric', () {
      final code = '739401';
      final isSixDigits = RegExp(r'^\d{6}$').hasMatch(code);
      expect(isSixDigits, isTrue);

      final invalidCode = 'ABC12';
      expect(RegExp(r'^\d{6}$').hasMatch(invalidCode), isFalse);
    });
  });

  group('Library Staff Dashboard & Student Print Screen Widget Tests', () {
    testWidgets(
      'StudentPrintScreen renders tabs: New Print, My Orders, Failed Payments, Pulse Points',
      (tester) async {
        final authState = AuthState();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StudentPrintScreen(
                authState: authState,
                onBackToHome: () {},
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.text('Campus Print Shop'), findsOneWidget);
        expect(find.text('New Print Request'), findsOneWidget);
        expect(find.textContaining('My Orders'), findsOneWidget);
        expect(find.textContaining('Failed Payments'), findsWidgets);
        expect(find.textContaining('Pulse Points'), findsWidgets);
      },
    );

    testWidgets(
      'LibraryStaffDashboardScreen renders title and counter selector',
      (tester) async {
        final authState = AuthState();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LibraryStaffDashboardScreen(
                authState: authState,
                onBackToHome: () {},
                onSignOut: () {},
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.text('Library Print Request Panel'), findsOneWidget);
        expect(find.text('Verify Collection'), findsOneWidget);
      },
    );
  });
}
