import 'package:flutter/widgets.dart';

abstract final class WathbSpacing {
  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x6 = 24;
  static const double x8 = 32;
}

abstract final class WathbRadius {
  static const double field = 8;
  static const double card = 12;
  static const double dialog = 16;
}

abstract final class WathbTouchTarget {
  static const double minimum = 48;
}

abstract final class WathbColors {
  static const lightBackground = Color(0xFFF7F7F7);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceVariant = Color(0xFFEAEAEA);
  static const lightPrimary = Color(0xFF171717);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightSecondary = Color(0xFF555555);
  static const lightAccent = Color(0xFFD9D9D9);
  static const lightText = Color(0xFF1A1A1A);
  static const lightMuted = Color(0xFF626262);
  static const lightOutline = Color(0xFFD2D2D2);
  static const lightError = Color(0xFF333333);
  static const lightWarning = Color(0xFF5C5C5C);
  static const lightSuccess = Color(0xFF444444);

  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkSurfaceVariant = Color(0xFF2B2B2B);
  static const darkPrimary = Color(0xFFE5E5E5);
  static const darkOnPrimary = Color(0xFF171717);
  static const darkSecondary = Color(0xFFC2C2C2);
  static const darkAccent = Color(0xFF454545);
  static const darkText = Color(0xFFF2F2F2);
  static const darkMuted = Color(0xFFB0B0B0);
  static const darkOutline = Color(0xFF505050);
  static const darkError = Color(0xFFF2F2F2);
  static const darkWarning = Color(0xFFCCCCCC);
  static const darkSuccess = Color(0xFFD8D8D8);
}
