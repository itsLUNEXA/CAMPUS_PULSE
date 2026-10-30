import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens for CAMPULSE adhering to the Mint & Teal brand system:
/// - Page background: #EFF7F7
/// - Cards and surfaces: #FFFFFF
/// - Primary teal: #3E9FA0
/// - Teal hover/active: #308586
/// - Light mint: #BFF1E5
/// - Light cyan: #CEF0F3
/// - Primary text: #0B0E17
/// - Primary button: #080D19
class LineaTokens {
  // Mint & Teal Brand System
  static const Color pageBackground = Color(0xFFEFF7F7);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color primaryTeal = Color(0xFF3E9FA0);
  static const Color tealHover = Color(0xFF308586);
  static const Color lightMint = Color(0xFFBFF1E5);
  static const Color lightCyan = Color(0xFFCEF0F3);
  static const Color lightBlue = Color(0xFFD6ECFA);
  static const Color lightLavender = Color(0xFFECE5FA);
  static const Color primaryText = Color(0xFF0B0E17);
  static const Color secondaryText = Color(0xFF555D65);
  static const Color mutedText = Color(0xFF899398);
  static const Color borderAndDivider = Color(0xFFE3ECEC);
  static const Color primaryButton = Color(0xFF080D19);
  static const Color primaryButtonText = Color(0xFFFFFFFF);
  static const Color highlightBlue = Color(0xFF249ED0);

  // Backward-compatibility aliases
  static const Color lightPink = lightMint;
  static const Color purple = tealHover;
  static const Color deepViolet = primaryTeal;

  // Roles
  static const Color primary = primaryButton;
  static const Color secondary = primaryTeal;
  static const Color accent = highlightBlue;

  // Neutrals
  static const Color neutralDark = primaryText;
  static const Color neutralBlack = primaryButton;
  static const Color neutralBrown = secondaryText;
  static const Color neutralSand = mutedText;
  static const Color neutralSilver = borderAndDivider;
  static const Color neutralSlate = mutedText;

  // Surfaces & Borders
  static const Color surfaceWarm = cardSurface;
  static const Color white = cardSurface;
  static const Color borderSubtle = borderAndDivider;

  // Spacing Scale
  static const double space1 = 1.0;
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space31 = 31.0;
  static const double space36 = 36.0;
  static const double space44 = 44.0;
  static const double space48 = 48.0;
  static const double space51 = 51.0;
  static const double space54 = 54.0;
  static const double space64 = 64.0;
  static const double space72 = 72.0;
  static const double space77 = 77.0;
  static const double space88 = 88.0;
  static const double space102 = 102.0;

  // Modest Radii Scale
  static const double radius2 = 2.0;
  static const double radius11 = 8.0;
  static const double radius14 = 8.0;
  static const double radius20 = 12.0;
  static const double radius28 = 12.0;
  static const double radius34 = 12.0;

  // Motion Durations
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration durationNormal = Duration(milliseconds: 300);

  // Typography
  static TextStyle fontHostGrotesk({
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w400,
    Color color = neutralDark,
    double? height,
    TextDecoration? decoration,
  }) {
    try {
      return GoogleFonts.getFont(
        'Host Grotesk',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        decoration: decoration,
      );
    } catch (_) {
      return GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        decoration: decoration,
      );
    }
  }

  // Pre-configured type styles
  static TextStyle get heroHeading => fontHostGrotesk(
    fontSize: 40.0,
    fontWeight: FontWeight.w800,
    color: neutralDark,
    height: 1.15,
  );

  static TextStyle get sectionHeading => fontHostGrotesk(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    color: neutralDark,
    height: 1.2,
  );

  static TextStyle get cardTitle => fontHostGrotesk(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: neutralDark,
  );

  static TextStyle get body => fontHostGrotesk(
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
    color: neutralBrown,
    height: 1.5,
  );

  static TextStyle get label => fontHostGrotesk(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    color: neutralSlate,
  );

  static TextStyle get buttonText => fontHostGrotesk(
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
