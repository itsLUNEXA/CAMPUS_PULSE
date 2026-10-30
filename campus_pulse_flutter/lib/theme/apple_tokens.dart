import 'package:flutter/material.dart';

/// Centralized Design System Tokens for Campus Pulse.
/// Inspired by the DesignCode cosmic midnight-violet and vibrant sunset gradient visual aesthetic.
class AppleTokens {
  // --- MANDATORY APPLE COLOR TOKENS (Preserved for backwards compatibility with tests) ---
  static const Color primaryBlue = Color(0xFF0071E3);
  static const Color secondaryBlue = Color(0xFF2997FF);
  static const Color accentBlue = Color(0xFF24568E);
  static const Color primaryText = Color(0xFF1D1D1F);
  static const Color black = Color(0xFF000000);
  static const Color lightNeutral = Color(0xFFE8E8ED);
  static const Color white = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFF86868B);
  static const Color tertiaryText = Color(0xFF6E6E73);

  // --- CORE PASTEL MOBILE DESIGN SYSTEM (Inspired by Reference Screenshot) ---
  static const Color lavenderBg = Color(0xFFE6DFFF); // Soft lavender canvas & decorative surfaces: #E6DFFF
  static const Color softLavender = Color(0xFFB9A0FF); // Featured cards & hero highlights: #B9A0FF
  static const Color paleLavender = Color(0xFFF1EDFF); // Soft sections, tags, pill highlights: #F1EDFF
  static const Color warmWhite = Color(0xFFFAFAF8); // Main content background & card surfaces: #FAFAF8
  static const Color pastelYellow = Color(0xFFFFC45B); // Featured events & plan card: #FFC45B
  static const Color pastelBlue = Color(0xFFA9CCFF); // Secondary cards & info panels: #A9CCFF
  static const Color pastelPink = Color(0xFFF18CE5); // Community accents & social actions: #F18CE5
  static const Color darkNavy = Color(0xFF10111C); // Main text, headings, floating nav: #10111C
  static const Color textMutedGrey = Color(0xFF777783); // Secondary text, metadata: #777783
  static const Color borderPastel = Color(0xFFE9E6EF); // Subtle input borders & dividers: #E9E6EF
  static const Color pureWhite = Color(0xFFFFFFFF); // Card surfaces & contrast elements: #FFFFFF

  // --- GLOBAL SYSTEM TOKENS ---
  static const Color primary = softLavender;
  static const Color primaryContainer = paleLavender;
  static const Color secondary = pastelBlue;
  static const Color accent = pastelYellow;
  static const Color background = warmWhite; // #FAFAF8
  static const Color canvasAlt = lavenderBg; // #E6DFFF
  static const Color cardBg = pureWhite; // #FFFFFF
  static const Color cardElevated = warmWhite; // #FAFAF8
  static const Color border = borderPastel; // #E9E6EF
  static const Color borderLight = Color(0xFFDFDAE7);
  static const Color surface = pureWhite;

  // Typography
  static const Color textPrimary = darkNavy; // #10111C
  static const Color textSecondary = textMutedGrey; // #777783
  static const Color textMuted = Color(0xFF9E9EAA);
  static const Color textDark = darkNavy;
  static const Color textLight = pureWhite;

  // Vibrant Accents & Semantic Colors
  static const Color coralPink = pastelPink; // #F18CE5
  static const Color sunsetOrange = pastelYellow; // #FFC45B
  static const Color electricBlue = pastelBlue; // #A9CCFF
  static const Color royalBlue = softLavender; // #B9A0FF
  static const Color vividPurple = softLavender; // #B9A0FF
  static const Color deepPurple = darkNavy; // #10111C
  static const Color mintCyan = Color(0xFFA8E6CF); // Soft pastel mint
  static const Color amberGold = pastelYellow; // #FFC45B

  // Compatibility aliases for landing page & existing components
  static const Color deepNavyColor = darkNavy;
  static const Color deepNavy = darkNavy;
  static const Color bodyText = textMutedGrey;
  static const Color accentPurple = softLavender;
  static const Color lavender = paleLavender;
  static const Color palePurple = paleLavender;
  static const Color warmCream = pastelYellow;
  static const Color softBlue = pastelBlue;
  static const Color yellowAccent = pastelYellow;
  static const Color yellowSoft = Color(0xFFFFF3D6);

  // Backward compatibility aliases for previous theme tokens
  static const Color sageGreen = softLavender;
  static const Color deepForest = darkNavy;
  static const Color softSage = paleLavender;
  static const Color mutedGrey = textMutedGrey;
  static const Color lightConcrete = borderPastel;
  static const Color burntAmber = pastelYellow;
  static const Color paleSage = warmWhite;
  static const Color charcoal = darkNavy;

  // Dark Mode Shades (Adapted with deep navy surfaces & pastel accents)
  static const Color darkBackground = Color(0xFF141422); // Deep navy background
  static const Color darkSurface = Color(0xFF1C1C2E); // Deep navy surface
  static const Color darkSurfaceElevated = Color(0xFF26263D); // Elevated surface
  static const Color darkBorder = Color(0xFF33334F);
  static const Color darkTextPrimary = Color(0xFFFAFAF8);
  static const Color darkTextSecondary = Color(0xFFA5A5BA);
  static const Color darkAccentPurple = softLavender;

  // Light Mode Surfaces
  static const Color lightBackground = warmWhite;
  static const Color lightSurface = pureWhite;
  static const Color lightSurfaceElevated = warmWhite;
  static const Color lightBorder = borderPastel;

  // Semantic Feedback Colors
  static const Color success = Color(0xFF34C759); // Crisp pastel green
  static const Color warning = pastelYellow; // #FFC45B
  static const Color error = Color(0xFFFF453A); // Apple accessible red

  // --- SIGNATURE PASTEL GRADIENTS ---
  static const LinearGradient lavenderHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lavenderBg, paleLavender, warmWhite],
  );

  static const LinearGradient challengeCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [softLavender, Color(0xFFC7B2FF)],
  );

  static const LinearGradient yellowCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pastelYellow, Color(0xFFFFD180)],
  );

  static const LinearGradient blueCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pastelBlue, Color(0xFFBDD8FF)],
  );

  static const LinearGradient pinkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pastelPink, Color(0xFFF7A8EE)],
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pastelYellow, pastelPink],
  );

  static const LinearGradient cyberBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pastelBlue, softLavender],
  );

  static const LinearGradient electricVioletGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [softLavender, pastelPink],
  );

  static const LinearGradient mintCyanGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA8E6CF), pastelBlue],
  );

  static const LinearGradient amberSunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pastelYellow, pastelPink],
  );

  // --- MANDATORY SPACING SCALE ---
  // Scale: 1, 24, 26, 28, 30, 32, 37, 40, 44, 48, 53, 56
  static const double space1 = 1.0;
  static const double space24 = 24.0;
  static const double space26 = 26.0;
  static const double space28 = 28.0;
  static const double space30 = 30.0;
  static const double space32 = 32.0;
  static const double space37 = 37.0;
  static const double space40 = 40.0;
  static const double space44 = 44.0;
  static const double space48 = 48.0;
  static const double space53 = 53.0;
  static const double space56 = 56.0;

  // Documented compact tokens for dense interfaces
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;

  // --- MANDATORY RADII SCALE ---
  // Scale: 5, 8, 50, 980, 999
  static const double radius5 = 5.0;
  static const double radius8 = 8.0;
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius20 = 20.0;
  static const double radius24 = 24.0;
  static const double radius50 = 50.0;
  static const double radius980 = 980.0;
  static const double radius999 = 999.0;

  // --- MOTION SCALE ---
  static const Duration duration20 = Duration(milliseconds: 20);
  static const Duration duration100 = Duration(milliseconds: 100);
  static const Duration duration160 = Duration(milliseconds: 160);
  static const Duration duration300 = Duration(milliseconds: 300);

  static const Curve defaultCurve = Curves.easeInOutCubic;
}

/// Convenience alias
typedef MindlyTokens = AppleTokens;
