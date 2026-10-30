import 'package:campus_pulse_flutter/services/preferences_service.dart';
import 'package:campus_pulse_flutter/widgets/cookie_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Cookie and Privacy Banner Component', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('shows cookie banner when consent is pending', (tester) async {
      final prefs = PreferencesService();
      await prefs.init();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                CookieBanner(preferencesService: prefs),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Privacy & Campus Data Choices'), findsOneWidget);
      expect(find.text('Accept Choices'), findsOneWidget);
      expect(find.text('Reject Optional'), findsOneWidget);

      // Tap Accept Choices
      await tester.tap(find.text('Accept Choices'));
      await tester.pumpAndSettle();

      expect(prefs.cookieConsent, isTrue);
      // Banner hides after consenting
      expect(find.text('Privacy & Campus Data Choices'), findsNothing);
    });
  });
}
