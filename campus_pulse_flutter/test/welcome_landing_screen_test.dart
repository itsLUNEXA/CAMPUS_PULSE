import 'package:campus_pulse_flutter/screens/welcome_onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Redesigned WelcomeOnboardingScreen renders all hero, 3D cards, features, and journey elements on desktop',
    (tester) async {
      tester.view.physicalSize = const Size(1280, 960);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      bool getStartedTapped = false;
      bool browseEventsTapped = false;
      String? navigatedRoute;

      await tester.pumpWidget(
        MaterialApp(
          home: WelcomeOnboardingScreen(
            onGetStarted: () => getStartedTapped = true,
            onBrowseEvents: () => browseEventsTapped = true,
            onNavigate: (route) => navigatedRoute = route,
          ),
        ),
      );

      // Initial pump
      await tester.pump();
      expect(navigatedRoute, isNull);
      expect(navigatedRoute, isNull);

      // Verify Sticky Frosted Navbar
      expect(find.text('CAMPULSE'), findsAtLeast(1));
      expect(find.text('Features'), findsAtLeast(1));
      expect(find.text('How It Works'), findsAtLeast(1));
      expect(find.text('About'), findsAtLeast(1));
      expect(find.text('Events'), findsAtLeast(1));
      expect(find.text('Log In'), findsAtLeast(1));
      expect(find.text('Sign Up'), findsAtLeast(1));

      // Verify Hero Section
      expect(find.text('Campus Community Platform'), findsOneWidget);
      expect(find.text('Get Started'), findsAtLeast(1));

      // Verify 3D Campus Illustration Cards
      expect(find.text('HackPulse 2026'), findsOneWidget);
      expect(find.text('Data Structures'), findsOneWidget);
      expect(find.text('CSE Study Hub'), findsOneWidget);
      expect(find.text('Rank #1 in Year 3'), findsOneWidget);

      // Verify 6 Features
      expect(find.text('Events & Registration'), findsAtLeast(1));
      expect(find.text('Library & Notes'), findsAtLeast(1));
      expect(find.text('Community Rooms'), findsAtLeast(1));
      expect(find.text('Study Buddy'), findsAtLeast(1));
      expect(find.text('Syllabus-Based Quizzes'), findsAtLeast(1));
      expect(find.text('Course & Year Leaderboards'), findsAtLeast(1));

      // Verify 3-Step Connected Journey
      expect(find.text('Create your account'), findsOneWidget);
      expect(find.text('Add your course and year'), findsOneWidget);
      expect(find.text('Explore activities & study resources'), findsOneWidget);

      // Verify Final CTA
      expect(find.text('Make the most of your campus.'), findsOneWidget);
      expect(find.text('Create Student Account'), findsOneWidget);

      // Tap CTA buttons
      await tester.tap(find.text('Get Started').first);
      expect(getStartedTapped, isTrue);

      await tester.tap(find.text('Events').last);
      expect(browseEventsTapped, isTrue);
    },
  );

  testWidgets(
    'Redesigned WelcomeOnboardingScreen renders properly on Mobile viewport',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: WelcomeOnboardingScreen(
            onGetStarted: () {},
            onBrowseEvents: () {},
          ),
        ),
      );

      await tester.pump();

      // Verify Brand Logo on mobile
      expect(find.text('CAMPULSE'), findsAtLeast(1));
      expect(find.byIcon(Icons.menu_rounded), findsOneWidget);

      // Verify Hero Elements
      expect(find.text('Campus Community Platform'), findsOneWidget);
      expect(find.text('Get Started'), findsAtLeast(1));

      // Verify 3D Cards exist
      expect(find.text('HackPulse 2026'), findsOneWidget);
      expect(find.text('Data Structures'), findsOneWidget);
    },
  );
}
