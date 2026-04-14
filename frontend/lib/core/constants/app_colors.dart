import 'package:flutter/material.dart';

/// Aurora Design System — Color Palette
class AppColors {
  AppColors._();

  // ── Backgrounds ──
  static const Color background = Color(0xFF0D0D12);
  static const Color surface = Color(0xFF1A1A2E);
  static const Color surfaceLight = Color(0xFF2A2A3E);
  static const Color surfaceBorder = Color(0xFF333348);

  // ── Primary (Purple → Magenta gradient) ──
  static const Color primary = Color(0xFFA855F7);
  static const Color primaryLight = Color(0xFFC084FC);
  static const Color primaryDark = Color(0xFF7C3AED);
  static const Color accent = Color(0xFFD946EF);
  static const Color accentPink = Color(0xFFEC4899);

  // ── Text ──
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);

  // ── Status ──
  static const Color scoreGreen = Color(0xFF22C55E);
  static const Color scoreTeal = Color(0xFF14B8A6);
  static const Color scoreAmber = Color(0xFFF59E0B);
  static const Color scoreOrange = Color(0xFFF97316);
  static const Color scoreRed = Color(0xFFEF4444);

  // ── Gradients ──
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryHorizontalGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF1E1E3A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pinkGradient = LinearGradient(
    colors: [accent, accentPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ── Nav ──
  static const Color navActive = primary;
  static const Color navInactive = Color(0xFF6B7280);
}
