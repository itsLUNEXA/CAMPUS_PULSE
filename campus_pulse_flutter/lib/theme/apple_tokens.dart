import 'package:flutter/material.dart';

/// Centralized Design System Tokens for CAMPULSE.
/// Clean, soft mint-and-teal palette with near-black text and CTA buttons:
/// - Page background: #EFF7F7
/// - Cards and surfaces: #FFFFFF
/// - Primary teal: #3E9FA0 (active navigation, links, progress indicators, selected states)
/// - Teal hover/active: #308586
/// - Light mint: #BFF1E5 (icon containers, badges, subtle backgrounds)
/// - Light cyan: #CEF0F3 (icon containers, badges, subtle backgrounds)
/// - Light blue: #D6ECFA
/// - Light lavender: #ECE5FA
/// - Primary text: #0B0E17 (near-black, readable body & headings)
/// - Secondary text: #555D65
/// - Muted text: #899398
/// - Borders and dividers: #E3ECEC
/// - Primary button: #080D19 (near-black CTA buttons)
/// - Primary button text: #FFFFFF
/// - Highlight blue: #249ED0
class AppleTokens {
  // --- MINT & TEAL THEME TOKENS ---
  static const Color pageBackground = Color(0xFFEFF7F7); // #EFF7F7
  static const Color cardSurface = Color(0xFFFFFFFF); // #FFFFFF
  static const Color primaryTeal = Color(0xFF3E9FA0); // #3E9FA0
  static const Color tealHover = Color(0xFF308586); // #308586
  static const Color lightMint = Color(0xFFBFF1E5); // #BFF1E5
  static const Color lightCyan = Color(0xFFCEF0F3); // #CEF0F3
  static const Color lightBlue = Color(0xFFD6ECFA); // #D6ECFA
  static const Color lightLavender = Color(0xFFECE5FA); // #ECE5FA
  static const Color primaryText = Color(0xFF0B0E17); // #0B0E17
  static const Color secondaryText = Color(0xFF555D65); // #555D65
  static const Color mutedText = Color(0xFF899398); // #899398
  static const Color borderAndDivider = Color(0xFFE3ECEC); // #E3ECEC
  static const Color primaryButton = Color(0xFF080D19); // #080D19
  static const Color primaryButtonText = Color(0xFFFFFFFF); // #FFFFFF
  static const Color highlightBlue = Color(0xFF249ED0); // #249ED0

  // Timetable Slot Status Palette (Class / Free / Occupied / Unset)
  static const Color occupiedBackground = Color(
    0xFFFDE2E2,
  ); // Light pastel red / coral
  static const Color occupiedText = Color(0xFF9B1C1C); // Dark red text
  static const Color occupiedBorder = Color(
    0xFFFCA5A5,
  ); // Visible pastel red border
  static const Color classBackground = Color(0xFFD6ECFA); // Light blue
  static const Color classText = Color(0xFF0B0E17); // Dark text
  static const Color classBorder = Color(0xFF93C5FD); // Blue border
  static const Color freeBackground = Color(0xFFE6F9F4); // Subtle mint
  static const Color freeText = Color(0xFF0F5B5C); // Dark teal text
  static const Color freeBorder = Color(0xFF8CE5D0); // Mint border
  static const Color unsetSlotBorder = Color(0xFFE3ECEC); // Neutral grid line

  // --- BRAND ROLES ---
  static const Color primary = primaryTeal;
  static const Color secondary = tealHover;
  static const Color accent = primaryTeal;

  // --- BACKWARD-COMPATIBILITY ALIASES (Seamless transition) ---
  static const Color deepViolet = primaryTeal;
  static const Color purple = tealHover;
  static const Color lightPink = lightMint;
  static const Color softLavender = primaryTeal;
  static const Color paleLavender = lightCyan;
  static const Color lavenderBg = pageBackground;
  static const Color lavender = lightCyan;
  static const Color palePurple = lightLavender;
  static const Color warmCream = lightMint;
  static const Color paleGreenContainer = lightMint;
  static const Color paleCyanContainer = lightCyan;
  static const Color pastelPink = lightMint;
  static const Color pastelYellow = lightCyan;
  static const Color pastelBlue = lightBlue;
  static const Color softBlue = lightBlue;
  static const Color yellowAccent = primaryTeal;
  static const Color yellowSoft = lightMint;
  static const Color accentPurple = primaryTeal;

  static const Color primaryBlue = primaryTeal;
  static const Color secondaryBlue = tealHover;
  static const Color accentBlue = highlightBlue;
  static const Color lineaPrimary = primaryButton;
  static const Color lineaSecondary = primaryTeal;
  static const Color lineaAccent = highlightBlue;

  // Neutrals aliases
  static const Color neutralDark = primaryText;
  static const Color neutralBlack = primaryButton;
  static const Color neutralBrown = secondaryText;
  static const Color neutralSand = mutedText;
  static const Color neutralSilver = borderAndDivider;
  static const Color neutralSlate = mutedText;
  static const Color warmWhite = cardSurface;
  static const Color surfaceMuted = pageBackground;
  static const Color borderSubtle = borderAndDivider;
  static const Color borderPastel = borderAndDivider;
  static const Color pureWhite = cardSurface;
  static const Color white = cardSurface;
  static const Color black = primaryButton;

  static const Color darkNavy = primaryText;
  static const Color deepNavy = primaryText;
  static const Color deepNavyColor = primaryText;
  static const Color deepForest = primaryText;
  static const Color charcoal = primaryText;
  static const Color burntAmber = primaryTeal;
  static const Color sageGreen = primaryTeal;
  static const Color softSage = lightMint;
  static const Color paleSage = pageBackground;
  static const Color lightConcrete = borderAndDivider;
  static const Color mutedGrey = secondaryText;

  // Surfaces & Backgrounds
  static const Color background = pageBackground;
  static const Color canvasAlt = pageBackground;
  static const Color cardBg = cardSurface;
  static const Color cardElevated = cardSurface;
  static const Color surface = cardSurface;
  static const Color lightBackground = pageBackground;
  static const Color lightSurface = cardSurface;
  static const Color lightSurfaceElevated = cardSurface;
  static const Color lightBorder = borderAndDivider;
  static const Color border = borderAndDivider;
  static const Color borderLight = borderAndDivider;

  // Typography Tokens
  static const Color textPrimary = primaryText;
  static const Color textSecondary = secondaryText;
  static const Color textMuted = mutedText;
  static const Color textMutedGrey = secondaryText;
  static const Color textDark = primaryText;
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color bodyText = secondaryText;
  static const Color tertiaryText = mutedText;
  static const Color lightNeutral = borderAndDivider;

  // --- DARK MODE PALETTE (Complementary dark teal/slate, preserving contrast) ---
  static const Color darkBackground = Color(
    0xFF0D1416,
  ); // Deep charcoal with dark teal tint
  static const Color darkSurface = Color(0xFF131D20);
  static const Color darkSurfaceElevated = Color(0xFF1A262B);
  static const Color darkBorder = Color(0xFF26363D);
  static const Color darkTextPrimary = Color(0xFFEFF7F7);
  static const Color darkTextSecondary = Color(0xFF8FA3A9);
  static const Color darkAccentPurple = Color(0xFF4EBABA);
  static const Color darkTeal = Color(0xFF4EBABA);

  // Semantic Feedback
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color error = Color(0xFFD32F2F);

  // --- SUBTLE GRADIENTS (Mint to Cyan, used sparingly) ---
  static const LinearGradient mintCyanGradient = LinearGradient(
    colors: [lightMint, lightCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient subtleMintGradient = LinearGradient(
    colors: [pageBackground, lightCyan],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient lavenderHeroGradient = LinearGradient(
    colors: [pageBackground, cardSurface],
  );

  static const LinearGradient challengeCardGradient = LinearGradient(
    colors: [primaryTeal, tealHover],
  );

  static const LinearGradient yellowCardGradient = LinearGradient(
    colors: [lightMint, lightCyan],
  );

  static const LinearGradient blueCardGradient = LinearGradient(
    colors: [lightCyan, lightBlue],
  );

  static const LinearGradient pinkCardGradient = LinearGradient(
    colors: [lightMint, lightMint],
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [primaryTeal, highlightBlue],
  );

  static const LinearGradient cyberBlueGradient = LinearGradient(
    colors: [highlightBlue, primaryTeal],
  );

  static const LinearGradient electricVioletGradient = LinearGradient(
    colors: [primaryTeal, tealHover],
  );

  static const LinearGradient amberSunsetGradient = LinearGradient(
    colors: [primaryTeal, highlightBlue],
  );

  // --- SPACING SCALE ---
  static const double space1 = 1.0;
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space26 = 26.0;
  static const double space28 = 28.0;
  static const double space30 = 30.0;
  static const double space31 = 31.0;
  static const double space32 = 32.0;
  static const double space36 = 36.0;
  static const double space37 = 36.0;
  static const double space40 = 40.0;
  static const double space44 = 44.0;
  static const double space48 = 48.0;
  static const double space51 = 51.0;
  static const double space53 = 52.0;
  static const double space54 = 54.0;
  static const double space56 = 56.0;
  static const double space64 = 64.0;
  static const double space72 = 72.0;
  static const double space77 = 77.0;
  static const double space88 = 88.0;
  static const double space102 = 102.0;

  // --- MODEST CONSISTENT RADII SCALE ---
  static const double radius2 = 2.0;
  static const double radius5 = 4.0;
  static const double radius8 = 8.0;
  static const double radius11 = 8.0;
  static const double radius12 = 8.0;
  static const double radius14 = 10.0;
  static const double radius16 = 10.0;
  static const double radius20 = 12.0;
  static const double radius24 = 12.0;
  static const double radius28 = 12.0;
  static const double radius34 = 12.0;
  static const double radius50 = 12.0;
  static const double radius980 = 12.0;
  static const double radius999 = 8.0;

  // --- MOTION SCALE ---
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration durationNormal = Duration(milliseconds: 300);

  static const Duration duration20 = Duration(milliseconds: 150);
  static const Duration duration100 = Duration(milliseconds: 150);
  static const Duration duration160 = Duration(milliseconds: 160);
  static const Duration duration300 = Duration(milliseconds: 300);

  static const Curve defaultCurve = Curves.easeInOut;
}

/// Convenience alias
typedef MindlyTokens = AppleTokens;
