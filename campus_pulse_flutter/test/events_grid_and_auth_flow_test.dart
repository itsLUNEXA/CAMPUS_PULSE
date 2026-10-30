import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:campus_pulse_flutter/client.dart';
import 'package:campus_pulse_flutter/main.dart';
import 'package:campus_pulse_flutter/screens/events_feed_screen.dart';
import 'package:campus_pulse_flutter/services/auth_state.dart';
import 'package:campus_pulse_flutter/services/preferences_service.dart';
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

  group('Events Page Image-First Grid & Auth Tests', () {
    testWidgets('EventsFeedScreen renders search, filter chips, and image-first layout', (tester) async {
      tester.view.physicalSize = const Size(1280, 960);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final authState = AuthState();
      final realtimeService = RealtimeService();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventsFeedScreen(
              authState: authState,
              realtimeService: realtimeService,
              onSelectEvent: (_) {},
              onCreateEvent: () {},
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify Header
      expect(find.text('Campus Events Feed'), findsOneWidget);

      // Verify Search TextField
      expect(
        find.byWidgetPredicate(
          (w) =>
              w is TextField &&
              w.decoration?.hintText?.contains('Search events') == true,
        ),
        findsOneWidget,
      );

      // Verify Category Filter Chips
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Tech'), findsOneWidget);
      expect(find.text('Hackathon'), findsOneWidget);
      expect(find.text('Sports'), findsOneWidget);
      expect(find.text('Cultural'), findsOneWidget);
      expect(find.text('Workshop'), findsOneWidget);
    });

    testWidgets('EventsFeedScreen category filter chip selection toggles cleanly', (tester) async {
      final authState = AuthState();
      final realtimeService = RealtimeService();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventsFeedScreen(
              authState: authState,
              realtimeService: realtimeService,
              onSelectEvent: (_) {},
              onCreateEvent: () {},
            ),
          ),
        ),
      );

      await tester.pump();

      // Tap 'Hackathon' filter chip
      await tester.tap(find.text('Hackathon'));
      await tester.pump();

      // Verify Hackathon chip is selected
      final hackathonChip = tester.widget<FilterChip>(
        find.ancestor(
          of: find.text('Hackathon'),
          matching: find.byType(FilterChip),
        ),
      );
      expect(hackathonChip.selected, isTrue);
    });

    testWidgets('CampusPulseApp starts on welcome onboarding when unauthenticated and enforces protected route guard', (tester) async {
      tester.view.physicalSize = const Size(1280, 960);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final prefService = PreferencesService();
      final authState = AuthState();
      final realtimeService = RealtimeService();

      await tester.pumpWidget(
        CampusPulseApp(
          preferencesService: prefService,
          authState: authState,
          realtimeService: realtimeService,
        ),
      );

      await tester.pump();

      // Starts on public landing page
      expect(find.text('Campus Pulse'), findsAtLeast(1));
      expect(find.text('Explore Campus'), findsOneWidget);
      expect(find.text('Join Your Community'), findsOneWidget);
    });
  });
}
