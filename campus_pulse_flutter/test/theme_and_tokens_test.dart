import 'package:campus_pulse_flutter/theme/apple_tokens.dart';
import 'package:campus_pulse_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Campus Pulse Mint & Teal Tokens & Themes', () {
    test('verifies primary Mint & Teal brand color token values', () {
      expect(AppleTokens.primaryTeal, const Color(0xFF3E9FA0));
      expect(AppleTokens.tealHover, const Color(0xFF308586));
      expect(AppleTokens.lightMint, const Color(0xFFBFF1E5));
      expect(AppleTokens.lightCyan, const Color(0xFFCEF0F3));
      expect(AppleTokens.primaryText, const Color(0xFF0B0E17));
      expect(AppleTokens.secondaryText, const Color(0xFF555D65));
      expect(AppleTokens.mutedText, const Color(0xFF899398));
      expect(AppleTokens.border, const Color(0xFFE3ECEC));
      expect(AppleTokens.primaryButton, const Color(0xFF080D19));
      expect(AppleTokens.primaryButtonText, const Color(0xFFFFFFFF));
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
      expect(AppleTokens.radius5, 4.0);
      expect(AppleTokens.radius8, 8.0);
      expect(AppleTokens.radius50, 12.0);
      expect(AppleTokens.radius980, 12.0);
      expect(AppleTokens.radius999, 8.0);
    });

    test('verifies motion durations', () {
      expect(AppleTokens.duration300.inMilliseconds, 300);
      expect(AppleTokens.durationFast.inMilliseconds, 200);
      expect(AppleTokens.durationNormal.inMilliseconds, 300);
    });

    test('verifies light and dark ThemeData properties', () {
      final light = AppTheme.lightTheme;
      final dark = AppTheme.darkTheme;

      expect(light.brightness, Brightness.light);
      expect(light.colorScheme.primary, AppleTokens.primaryTeal);

      expect(dark.brightness, Brightness.dark);
      expect(dark.colorScheme.primary, AppleTokens.darkTeal);
    });
  });
}
