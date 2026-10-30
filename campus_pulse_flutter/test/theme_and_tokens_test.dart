import 'package:campus_pulse_flutter/theme/apple_tokens.dart';
import 'package:campus_pulse_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Apple Design Tokens & Themes', () {
    test('verifies mandatory Apple color token values', () {
      expect(AppleTokens.primaryBlue, const Color(0xFF0071E3));
      expect(AppleTokens.secondaryBlue, const Color(0xFF2997FF));
      expect(AppleTokens.accentBlue, const Color(0xFF24568E));
      expect(AppleTokens.primaryText, const Color(0xFF1D1D1F));
      expect(AppleTokens.black, const Color(0xFF000000));
      expect(AppleTokens.lightNeutral, const Color(0xFFE8E8ED));
      expect(AppleTokens.white, const Color(0xFFFFFFFF));
      expect(AppleTokens.secondaryText, const Color(0xFF86868B));
      expect(AppleTokens.tertiaryText, const Color(0xFF6E6E73));
    });

    test('verifies spacing scale', () {
      expect(AppleTokens.space1, 1.0);
      expect(AppleTokens.space24, 24.0);
      expect(AppleTokens.space26, 26.0);
      expect(AppleTokens.space28, 28.0);
      expect(AppleTokens.space32, 32.0);
      expect(AppleTokens.space40, 40.0);
      expect(AppleTokens.space48, 48.0);
      expect(AppleTokens.space56, 56.0);
    });

    test('verifies radii scale', () {
      expect(AppleTokens.radius5, 5.0);
      expect(AppleTokens.radius8, 8.0);
      expect(AppleTokens.radius50, 50.0);
      expect(AppleTokens.radius980, 980.0);
      expect(AppleTokens.radius999, 999.0);
    });

    test('verifies motion durations', () {
      expect(AppleTokens.duration20.inMilliseconds, 20);
      expect(AppleTokens.duration100.inMilliseconds, 100);
      expect(AppleTokens.duration160.inMilliseconds, 160);
      expect(AppleTokens.duration300.inMilliseconds, 300);
    });

    test('verifies light and dark ThemeData properties', () {
      final light = AppTheme.lightTheme;
      final dark = AppTheme.darkTheme;

      expect(light.brightness, Brightness.light);
      expect(light.colorScheme.primary, AppleTokens.primaryBlue);

      expect(dark.brightness, Brightness.dark);
      expect(dark.colorScheme.primary, AppleTokens.secondaryBlue);
    });
  });
}
