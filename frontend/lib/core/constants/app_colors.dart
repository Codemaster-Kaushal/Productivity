import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Root & Backgrounds
  static const Color background = Color(0xFF0E0E11);
  static const Color surface = Color(0xFF0E0E11);
  static const Color surfaceContainerLow = Color(0xFF131316);
  static const Color surfaceContainerHigh = Color(0xFF1F1F23);
  static const Color surfaceVariant = Color(0xFF25252A);
  static const Color surfaceBright = Color(0xFF2C2C30);
  
  // Core Accents
  static const Color primary = Color(0xFFBA9EFF);
  static const Color primaryDim = Color(0xFF8455EF);
  static const Color secondary = Color(0xFFEC63FF);
  static const Color tertiary = Color(0xFFD1C4FF);
  static const Color tertiaryFixed = Color(0xFFC3B4FC);

  // Text & Content Elements
  static const Color onSurface = Color(0xFFFBF8FC);
  static const Color onSurfaceVariant = Color(0xFFACAAAE);
  static const Color outline = Color(0xFF767578);
  static const Color outlineVariant = Color(0xFF48474B);
  
  static const Color onPrimaryFixed = Color(0xFF000000);

  // Status & Utility Colors
  static const Color error = Color(0xFFFF6E84);
  static const Color scoreGreen = Color(0xFF4ADE80);
  static const Color scoreAmber = Color(0xFFFBBF24);
  static const Color scoreOrange = Color(0xFFF97316);
  static const Color scoreRed = Color(0xFFEF4444);
  static const Color scoreTeal = Color(0xFF2DD4BF);
  
  // Backwards compatibility references for standard components
  static Color get textPrimary => onSurface;
  static Color get textSecondary => onSurfaceVariant;
  static Color get textMuted => outline;
  static Color get surfaceBorder => outlineVariant;
  static Color get surfaceLight => surfaceVariant;
  static Color get primaryLight => tertiary;
  static Color get navActive => secondary;
  static Color get navInactive => onSurfaceVariant;
  
  static final LinearGradient primaryGradient = const LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient surfaceGradient = const LinearGradient(
    colors: [surfaceContainerLow, surfaceContainerHigh],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color accent = secondary;
}
