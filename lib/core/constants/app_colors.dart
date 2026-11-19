import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Primaries (matching Stitch AI deep indigo/purple)
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryDark = Color(0xFF3730A3);
  static const Color primaryLight = Color(0xFF6366F1);
  static const Color primarySoft = Color(0xFFEEF0FD);
  static const Color primarySoftHover = Color(0xFFE0E7FF);

  // Secondary Accents
  static const Color success =
      Color(0xFF22C55E); // Bright Emerald for goal rings & checks
  static const Color successSoft = Color(0xFFDCFCE7);
  static const Color successDark = Color(0xFF15803D);

  static const Color streak = Color(0xFFF59E0B); // Amber flame
  static const Color streakSoft = Color(0xFFFEF3C7);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoSoft = Color(0xFFEFF6FF);

  static const Color speech = Color(0xFF10B981);
  static const Color speechSoft = Color(0xFFD1FAE5);

  static const Color error = Color(0xFFEF4444);
  static const Color errorSoft = Color(0xFFFEE2E2);

  // Backgrounds & Surfaces (Light Theme)
  static const Color background = Color(0xFFF8F9FE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF3F4F8);
  static const Color surfaceTertiary = Color(0xFFEAEAFF);

  // Backgrounds & Surfaces (Dark Theme)
  static const Color backgroundDark = Color(0xFF0F1018);
  static const Color surfaceDark = Color(0xFF181926);
  static const Color surfaceSecondaryDark = Color(0xFF222436);
  static const Color surfaceTertiaryDark = Color(0xFF2D304A);

  // Text Colors (Light Theme)
  static const Color textPrimary = Color(0xFF181829);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color textLight = Color(0xFFFFFFFF);

  // Text Colors (Dark Theme)
  static const Color textPrimaryDark = Color(0xFFF3F4F6);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textMutedDark = Color(0xFF6B7280);

  // Borders & Dividers
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF2E3146);
  static const Color borderSubtle = Color(0xFFF0F1F6);

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF3B34CD), Color(0xFF4F46E5), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient activeBarGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF4338CA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F7FF), Color(0xFFEDEAFE)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient splashGradientDark = LinearGradient(
    colors: [Color(0xFF141522), Color(0xFF0F1018), Color(0xFF0A0B10)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient avatarRingGradient = LinearGradient(
    colors: [Color(0xFF818CF8), Color(0xFF4F46E5), Color(0xFFC084FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
