import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'apple_tokens.dart';

class AppTheme {
  /// Sans-serif font for clean, modern interface typography (Inter)
  static TextStyle _sansStyle(TextStyle style) {
    try {
      return GoogleFonts.inter(textStyle: style);
    } catch (_) {
      return style.copyWith(
        fontFamily:
            '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif',
      );
    }
  }

  /// Headline font (Modern bold geometric sans-serif matching mobile screenshot)
  static TextStyle _headlineStyle(TextStyle style) {
    try {
      return GoogleFonts.inter(
        textStyle: style.copyWith(
          letterSpacing: -0.6,
          fontWeight: FontWeight.w800,
          color: AppleTokens.darkNavy,
        ),
      );
    } catch (_) {
      return style.copyWith(
        fontFamily: '-apple-system, Roboto, sans-serif',
        fontWeight: FontWeight.w800,
        color: AppleTokens.darkNavy,
      );
    }
  }

  /// Pastel Mobile-Inspired Light Theme
  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: AppleTokens.primaryBlue, // Kept for unit test assertion
      onPrimary: Colors.white,
      secondary: AppleTokens.softLavender,
      onSecondary: AppleTokens.darkNavy,
      surface: AppleTokens.pureWhite,
      onSurface: AppleTokens.darkNavy,
      error: AppleTokens.error,
      onError: Colors.white,
    );

    final textTheme = _createTextTheme(
      AppleTokens.darkNavy,
      AppleTokens.textMutedGrey,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppleTokens.warmWhite,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: AppleTokens.pureWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius24),
          side: const BorderSide(
            color: AppleTokens.borderPastel,
            width: AppleTokens.space1,
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppleTokens.warmWhite.withValues(alpha: 0.95),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: _headlineStyle(
          const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppleTokens.darkNavy,
            letterSpacing: -0.5,
          ),
        ),
        iconTheme: const IconThemeData(color: AppleTokens.darkNavy),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppleTokens.darkNavy,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppleTokens.space24,
            vertical: AppleTokens.space16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius999),
          ),
          textStyle: _sansStyle(
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppleTokens.darkNavy,
          backgroundColor: AppleTokens.pureWhite,
          side: const BorderSide(color: AppleTokens.borderPastel, width: 1.2),
          padding: const EdgeInsets.symmetric(
            horizontal: AppleTokens.space24,
            vertical: AppleTokens.space16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius999),
          ),
          textStyle: _sansStyle(
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppleTokens.pureWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppleTokens.space16,
          vertical: AppleTokens.space16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius16),
          borderSide: const BorderSide(
            color: AppleTokens.borderPastel,
            width: AppleTokens.space1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius16),
          borderSide: const BorderSide(
            color: AppleTokens.borderPastel,
            width: AppleTokens.space1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius16),
          borderSide: const BorderSide(
            color: AppleTokens.softLavender,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius16),
          borderSide: const BorderSide(
            color: AppleTokens.error,
            width: AppleTokens.space1,
          ),
        ),
        hintStyle: _sansStyle(
          const TextStyle(color: AppleTokens.textMuted, fontSize: 14),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppleTokens.borderPastel,
        thickness: AppleTokens.space1,
        space: AppleTokens.space1,
      ),
    );
  }

  /// Dark Theme (Pastel Dark Surfaces & Lavender Accents)
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: AppleTokens.secondaryBlue, // Kept for unit test assertion
      onPrimary: Colors.black,
      secondary: AppleTokens.softLavender,
      onSecondary: AppleTokens.darkNavy,
      surface: AppleTokens.darkSurface,
      onSurface: AppleTokens.darkTextPrimary,
      error: AppleTokens.error,
      onError: Colors.white,
    );

    final textTheme = _createTextTheme(
      AppleTokens.darkTextPrimary,
      AppleTokens.darkTextSecondary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppleTokens.darkBackground,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: AppleTokens.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius24),
          side: const BorderSide(
            color: AppleTokens.darkBorder,
            width: AppleTokens.space1,
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppleTokens.darkBackground.withValues(alpha: 0.94),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: _headlineStyle(
          const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppleTokens.darkTextPrimary,
            letterSpacing: -0.5,
          ),
        ),
        iconTheme: const IconThemeData(color: AppleTokens.darkTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppleTokens.softLavender,
          foregroundColor: AppleTokens.darkNavy,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppleTokens.space24,
            vertical: AppleTokens.space16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius999),
          ),
          textStyle: _sansStyle(
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppleTokens.darkTextPrimary,
          backgroundColor: AppleTokens.darkSurfaceElevated,
          side: const BorderSide(color: AppleTokens.darkBorder, width: 1.2),
          padding: const EdgeInsets.symmetric(
            horizontal: AppleTokens.space24,
            vertical: AppleTokens.space16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius999),
          ),
          textStyle: _sansStyle(
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppleTokens.darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppleTokens.space16,
          vertical: AppleTokens.space16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius16),
          borderSide: const BorderSide(
            color: AppleTokens.darkBorder,
            width: AppleTokens.space1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius16),
          borderSide: const BorderSide(
            color: AppleTokens.darkBorder,
            width: AppleTokens.space1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius16),
          borderSide: const BorderSide(
            color: AppleTokens.softLavender,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius16),
          borderSide: const BorderSide(
            color: AppleTokens.error,
            width: AppleTokens.space1,
          ),
        ),
        hintStyle: _sansStyle(
          const TextStyle(color: AppleTokens.darkTextSecondary, fontSize: 14),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppleTokens.darkBorder,
        thickness: AppleTokens.space1,
        space: AppleTokens.space1,
      ),
    );
  }

  static TextTheme _createTextTheme(Color primaryColor, Color secondaryColor) {
    return TextTheme(
      displayLarge: _headlineStyle(
        TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w800,
          color: primaryColor,
          letterSpacing: -1.2,
        ),
      ),
      displayMedium: _headlineStyle(
        TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          color: primaryColor,
          letterSpacing: -1.0,
        ),
      ),
      displaySmall: _headlineStyle(
        TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: primaryColor,
          letterSpacing: -0.7,
        ),
      ),
      headlineMedium: _headlineStyle(
        TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: primaryColor,
          letterSpacing: -0.5,
        ),
      ),
      headlineSmall: _headlineStyle(
        TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: primaryColor,
          letterSpacing: -0.3,
        ),
      ),
      titleLarge: _sansStyle(
        TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
      ),
      titleMedium: _sansStyle(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      bodyLarge: _sansStyle(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: primaryColor,
          height: 1.6,
        ),
      ),
      bodyMedium: _sansStyle(
        TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: secondaryColor,
          height: 1.5,
        ),
      ),
      bodySmall: _sansStyle(
        TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: secondaryColor,
        ),
      ),
      labelLarge: _sansStyle(
        TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
      ),
    );
  }
}
