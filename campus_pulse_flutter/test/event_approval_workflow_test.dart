import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:campus_pulse_flutter/client.dart';
import 'package:campus_pulse_flutter/screens/create_event_screen.dart';
import 'package:campus_pulse_flutter/screens/event_detail_screen.dart';
import 'package:campus_pulse_flutter/screens/events_feed_screen.dart';
import 'package:campus_pulse_flutter/screens/master_admin_dashboard_screen.dart';
import 'package:campus_pulse_flutter/services/auth_state.dart';
import 'package:campus_pulse_flutter/services/realtime_service.dart';
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

  group('Event Approval Workflow UI Tests', () {
    testWidgets(
      'CreateEventScreen shows administrative review notice and Submit for Approval button',
      (tester) async {
        final authState = AuthState();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CreateEventScreen(
                authState: authState,
                onEventCreated: () {},
                onCancel: () {},
              ),
            ),
          ),
        );

        await tester.pump();

        // Verify review workflow notice
        expect(
          find.textContaining(
            'All campus events are submitted for administrative review',
          ),
          findsOneWidget,
        );

        // Verify CTA button label
        expect(find.text('Submit for Approval'), findsOneWidget);
      },
    );

    testWidgets(
      'EventDetailScreen shows pending review banner and disables registration',
      (tester) async {
        final authState = AuthState();
        final pendingEvent = CampusEvent(
          id: 99,
          title: 'Quantum Computing Hackathon',
          description: 'Explore quantum algorithms and NISQ quantum circuits.',
          category: 'Tech',
          startTime: DateTime.now().add(const Duration(days: 3)),
          venue: 'Engineering Quad Lab 4',
          organizerAuthUserId: UuidValue.fromString(
            '11111111-1111-1111-1111-111111111111',
          ),
          organizerName: 'Priya Sharma',
          approvalStatus: 'pending',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EventDetailScreen(
                event: pendingEvent,
                authState: authState,
                onBack: () {},
              ),
            ),
          ),
        );

        await tester.pump();

        // Verify Pending Review banner
        expect(find.text('Submitted for Admin Approval'), findsOneWidget);
        expect(
          find.textContaining(
            'This event is currently awaiting administrative review and is not visible in the public feed',
          ),
          findsOneWidget,
        );

        // Verify Register button shows Pending Admin Approval
        expect(find.text('Pending Admin Approval'), findsOneWidget);
      },
    );

    testWidgets('EventDetailScreen shows rejection banner with rejection reason', (
      tester,
    ) async {
      final authState = AuthState();
      final rejectedEvent = CampusEvent(
        id: 100,
        title: 'Late Night Rooftop Party',
        description: 'Music and gatherings on the main terrace.',
        category: 'Cultural',
        startTime: DateTime.now().add(const Duration(days: 4)),
        venue: 'Terrace Level 5',
        organizerAuthUserId: UuidValue.fromString(
          '22222222-2222-2222-2222-222222222222',
        ),
        organizerName: 'Aarav Patel',
        approvalStatus: 'rejected',
        rejectionReason:
            'Rooftop venue requires approved faculty chaperone and safety clearance.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventDetailScreen(
              event: rejectedEvent,
              authState: authState,
              onBack: () {},
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify Rejection banner and reason
      expect(find.text('Event Submission Rejected'), findsOneWidget);
      expect(
        find.textContaining(
          'Reason: Rooftop venue requires approved faculty chaperone and safety clearance.',
        ),
        findsOneWidget,
      );

      // Verify Registration Closed (Rejected)
      expect(find.text('Registration Closed (Rejected)'), findsOneWidget);
    });

    testWidgets(
      'MasterAdminDashboardScreen renders Event Approvals tab and moderation queue',
      (tester) async {
        tester.view.physicalSize = const Size(1280, 960);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final authState = AuthState();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MasterAdminDashboardScreen(
                authState: authState,
                onSignOut: () {},
                onExitToStudentPortal: () {},
              ),
            ),
          ),
        );

        await tester.pump();

        // Verify Event Approvals Tab is present
        expect(find.textContaining('Event Approvals'), findsWidgets);

        // Verify Academic Approvals Tab is distinct
        expect(find.text('Academic Approvals'), findsOneWidget);
      },
    );
  });
}
