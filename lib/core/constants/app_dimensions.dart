import 'package:flutter/material.dart';

class AppDimensions {
  AppDimensions._();

  // Spacing & Margins
  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space6 = 6.0;
  static const double space8 = 8.0;
  static const double space10 = 10.0;
  static const double space12 = 12.0;
  static const double space14 = 14.0;
  static const double space16 = 16.0;
  static const double space18 = 18.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space28 = 28.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space56 = 56.0;

  // Screen Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(20.0);

  // Border Radii (Stitch AI uses soft, rounded curves)
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusCard = 20.0;
  static const double radiusHero = 24.0;
  static const double radiusOnboarding = 28.0;
  static const double radiusPill = 999.0;

  // Common BorderRadius objects
  static final BorderRadius roundedSmall = BorderRadius.circular(radiusSmall);
  static final BorderRadius roundedMedium = BorderRadius.circular(radiusMedium);
  static final BorderRadius roundedLarge = BorderRadius.circular(radiusLarge);
  static final BorderRadius roundedCard = BorderRadius.circular(radiusCard);
  static final BorderRadius roundedHero = BorderRadius.circular(radiusHero);
  static final BorderRadius roundedOnboarding =
      BorderRadius.circular(radiusOnboarding);
  static final BorderRadius roundedPill = BorderRadius.circular(radiusPill);

  // Card Shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF101828).withValues(alpha: 0.05),
          offset: const Offset(0, 4),
          blurRadius: 16,
          spreadRadius: -2,
        ),
      ];

  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: const Color(0xFF4F46E5).withValues(alpha: 0.08),
          offset: const Offset(0, 6),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ];

  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: const Color(0xFF4F46E5).withValues(alpha: 0.30),
          offset: const Offset(0, 8),
          blurRadius: 20,
          spreadRadius: -4,
        ),
      ];
}
