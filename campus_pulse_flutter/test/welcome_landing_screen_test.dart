import 'package:campus_pulse_flutter/screens/welcome_onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Mindly-styled WelcomeOnboardingScreen renders all hero & section elements',
      (tester) async {
    // Set desktop screen size to match reference dimensions
    tester.view.physicalSize = const Size(1280, 960);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    bool getStartedTapped = false;
    bool browseEventsTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeOnboardingScreen(
          onGetStarted: () => getStartedTapped = true,
          onBrowseEvents: () => browseEventsTapped = true,
        ),
      ),
    );

    // Initial pump
    await tester.pump();

    // Verify Brand & Navbar
    expect(find.text('Campus Pulse'), findsAtLeast(1));
    expect(find.text('How It Works'), findsAtLeast(1));
    expect(find.text('Campus Community'), findsAtLeast(1));
    expect(find.text('Events'), findsAtLeast(1));
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Verify Hero Headline & Subtitle
    expect(
      find.text('Your campus life deserves\na place to connect'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Discover campus events, find your study buddies'),
      findsOneWidget,
    );

    // Verify CTAs
    expect(find.text('Explore Campus'), findsOneWidget);
    expect(find.text('Join Your Community'), findsOneWidget);

    // Verify Layered Card Content
    expect(find.textContaining('HackPulse 2026'), findsOneWidget);
    expect(find.textContaining('Looking for a DSA & OS study buddy'), findsOneWidget);
    expect(
      find.textContaining('How do you balance OS coursework'),
      findsOneWidget,
    );

    // Tap CTA
    await tester.tap(find.text('Explore Campus'));
    expect(browseEventsTapped, isTrue);

    await tester.tap(find.text('Get Started'));
    expect(getStartedTapped, isTrue);

    // Verify Below-the-fold sections
    expect(find.text('Everything you need to thrive on campus'), findsOneWidget);
    expect(find.text('Explore Campus Events'), findsOneWidget);
    expect(find.text('Find Your Study Buddy'), findsOneWidget);
    expect(find.text('Master Core Engineering Subjects'), findsOneWidget);
    expect(find.text('Live Campus Leaderboard'), findsOneWidget);
    expect(find.text('Make more of your campus life.'), findsOneWidget);
  });

  testWidgets('Mindly-styled WelcomeOnboardingScreen renders properly on Mobile viewport',
      (tester) async {
    // Mobile viewport dimensions (390 x 844 iPhone 14 / modern smartphone)
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
    expect(find.text('Campus Pulse'), findsAtLeast(1));
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Verify Mobile Hero Text
    expect(
      find.text('Your campus life deserves\na place to connect'),
      findsOneWidget,
    );
    expect(find.text('Explore Campus'), findsOneWidget);
    expect(find.text('Join Your Community'), findsOneWidget);

    // Verify Cards are present in scrollable carousel
    expect(find.textContaining('HackPulse 2026'), findsOneWidget);
  });
}
