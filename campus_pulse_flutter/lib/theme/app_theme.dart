import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'apple_tokens.dart';

/// Central application theme adhering to the CAMPULSE three-color brand system:
/// - Light Pink: #FFE4F6
/// - Purple: #B26CFF
/// - Deep Violet: #705EFF
class AppTheme {
  /// Sans-serif body font
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

  /// Headline font (Clean, modern sans)
  static TextStyle _headlineStyle(TextStyle style) {
    try {
      return GoogleFonts.inter(
        textStyle: style.copyWith(
          color: AppleTokens.neutralDark,
          letterSpacing: -0.3,
        ),
      );
    } catch (_) {
      return style.copyWith(
        fontFamily: '-apple-system, BlinkMacSystemFont, Roboto, sans-serif',
        color: AppleTokens.neutralDark,
        letterSpacing: -0.3,
      );
    }
  }

  /// CAMPULSE Light Theme
  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: AppleTokens.primaryTeal,
      onPrimary: Colors.white,
      secondary: AppleTokens.tealHover,
      onSecondary: Colors.white,
      surface: AppleTokens.cardSurface,
      onSurface: AppleTokens.primaryText,
      outline: AppleTokens.borderAndDivider,
      outlineVariant: AppleTokens.borderAndDivider,
      error: AppleTokens.error,
      onError: Colors.white,
    );

    final textTheme = _createTextTheme(
      AppleTokens.primaryText,
      AppleTokens.secondaryText,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppleTokens.pageBackground,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: AppleTokens.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius12),
          side: const BorderSide(
            color: AppleTokens.borderAndDivider,
            width: AppleTokens.space1,
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppleTokens.cardSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: _headlineStyle(
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppleTokens.primaryText,
          ),
        ),
        iconTheme: const IconThemeData(color: AppleTokens.primaryText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppleTokens.primaryButton,
          foregroundColor: AppleTokens.primaryButtonText,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius8),
          ),
          textStyle: _sansStyle(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppleTokens.primaryText,
          backgroundColor: AppleTokens.cardSurface,
          side: const BorderSide(
            color: AppleTokens.borderAndDivider,
            width: AppleTokens.space1,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius8),
          ),
          textStyle: _sansStyle(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppleTokens.primaryTeal,
          textStyle: _sansStyle(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppleTokens.cardSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          borderSide: const BorderSide(
            color: AppleTokens.borderAndDivider,
            width: AppleTokens.space1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          borderSide: const BorderSide(
            color: AppleTokens.borderAndDivider,
            width: AppleTokens.space1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          borderSide: const BorderSide(
            color: AppleTokens.primaryTeal,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          borderSide: const BorderSide(
            color: AppleTokens.error,
            width: AppleTokens.space1,
          ),
        ),
        hintStyle: _sansStyle(
          const TextStyle(color: AppleTokens.mutedText, fontSize: 14),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppleTokens.borderAndDivider,
        thickness: AppleTokens.space1,
        space: AppleTokens.space1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppleTokens.lightMint,
        labelStyle: _sansStyle(
          const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppleTokens.primaryTeal,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          side: BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppleTokens.primaryTeal,
        linearTrackColor: AppleTokens.lightCyan,
        circularTrackColor: AppleTokens.lightCyan,
      ),
    );
  }

  /// CAMPULSE Dark Theme
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: AppleTokens.darkTeal,
      onPrimary: Color(0xFF080D19),
      secondary: AppleTokens.primaryTeal,
      onSecondary: Colors.white,
      surface: AppleTokens.darkSurface,
      onSurface: AppleTokens.darkTextPrimary,
      outline: AppleTokens.darkBorder,
      outlineVariant: AppleTokens.darkBorder,
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
          borderRadius: BorderRadius.circular(AppleTokens.radius12),
          side: const BorderSide(
            color: AppleTokens.darkBorder,
            width: AppleTokens.space1,
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppleTokens.darkSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppleTokens.darkTextPrimary,
        ),
        iconTheme: IconThemeData(color: AppleTokens.darkTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppleTokens.primaryButton,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius8),
          ),
          textStyle: _sansStyle(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppleTokens.darkTextPrimary,
          backgroundColor: Colors.transparent,
          side: const BorderSide(
            color: AppleTokens.darkBorder,
            width: AppleTokens.space1,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius8),
          ),
          textStyle: _sansStyle(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppleTokens.darkTeal,
          textStyle: _sansStyle(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppleTokens.darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          borderSide: const BorderSide(
            color: AppleTokens.darkBorder,
            width: AppleTokens.space1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          borderSide: const BorderSide(
            color: AppleTokens.darkBorder,
            width: AppleTokens.space1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          borderSide: const BorderSide(
            color: AppleTokens.deepViolet,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
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
      chipTheme: ChipThemeData(
        backgroundColor: AppleTokens.darkSurfaceElevated,
        labelStyle: _sansStyle(
          const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppleTokens.purple,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          side: BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),
    );
  }

  static TextTheme _createTextTheme(Color primaryColor, Color secondaryColor) {
    return TextTheme(
      displayLarge: _headlineStyle(
        TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w800,
          color: primaryColor,
        ),
      ),
      displayMedium: _headlineStyle(
        TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: primaryColor,
        ),
      ),
      displaySmall: _headlineStyle(
        TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
      ),
      headlineMedium: _headlineStyle(
        TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
      ),
      headlineSmall: _headlineStyle(
        TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      titleLarge: _sansStyle(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      titleMedium: _sansStyle(
        TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      bodyLarge: _sansStyle(
        TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: primaryColor,
          height: 1.5,
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
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    );
  }
}
