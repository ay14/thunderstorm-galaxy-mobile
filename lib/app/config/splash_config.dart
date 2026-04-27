import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Edit this file to customise the Flutter-side animated splash screen.
/// The native (pre-Flutter) splash is configured in flutter_native_splash.yaml.
class SplashConfig {
  SplashConfig._();

  // ── Branding ──────────────────────────────────────────────────────────────
  static const String appName = 'ThunderStorm Galaxy';
  static const String tagline = 'Bikes Built Better. Inventory Managed Best.';

  // ── Timing ────────────────────────────────────────────────────────────────
  /// How long the splash stays visible after the animation completes.
  static const Duration holdDuration = Duration(milliseconds: 800);

  /// Total animation duration.
  static const Duration animationDuration = Duration(milliseconds: 1200);

  // ── Colors ────────────────────────────────────────────────────────────────
  static const Color backgroundColor = AppColors.surface;
  static const List<Color> gradientColors = [Color(0xFF1A0D2E), AppColors.surface];
  static const List<Color> logoGradient = [AppColors.galaxy, AppColors.electric];
  static const Color taglineColor = AppColors.electric;

  // ── Logo ──────────────────────────────────────────────────────────────────
  /// Set to a path like 'lib/shared/assets/logo.png' to use an image logo.
  /// When null, the default bolt icon is shown.
  static const String? logoAsset = 'lib/shared/assets/splash/main_splash_ts_galaxy.png';

  static const double logoSize = 96.0;
  static const double logoIconSize = 52.0;
  static const double logoBorderRadius = 24.0;

  // ── Shadow ────────────────────────────────────────────────────────────────
  static const Color logoShadowColor = AppColors.galaxy;
  static const double logoShadowBlur = 32.0;

  // ── Progress Bar ──────────────────────────────────────────────────────────
  static const double progressBarHeight = 4.0;
  static const double progressBarWidth = 200.0;
  static const Color progressBarBackgroundColor = Color(0xFF2A1A4E);
  static const List<Color> progressBarGradient = [AppColors.storm, AppColors.electric];
}
