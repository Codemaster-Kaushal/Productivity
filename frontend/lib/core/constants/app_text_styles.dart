import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get headline => GoogleFonts.inter();
  static TextStyle get body => GoogleFonts.inter();
  static TextStyle get label => GoogleFonts.manrope();

  static TextStyle get h1 => headline.copyWith(
    fontSize: 48,
    fontWeight: FontWeight.w600,
    letterSpacing: -1.92, // -0.04em
    color: AppColors.onSurface,
  );

  static TextStyle get h2 => headline.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle get h3 => headline.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
  );

  static TextStyle get scoreHero => headline.copyWith(
    fontSize: 140,
    fontWeight: FontWeight.w800,
    letterSpacing: -5.0,
    height: 1.0, 
  );

  static TextStyle get scoreLarge => scoreHero.copyWith(fontSize: 120);

  static TextStyle get bodyPrimary => body.copyWith(
    fontSize: 16,
    color: AppColors.onSurface,
  );

  static TextStyle get bodySecondary => body.copyWith(
    fontSize: 14,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle get caption => label.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6, // 0.05em
    textBaseline: TextBaseline.alphabetic,
  );
}
