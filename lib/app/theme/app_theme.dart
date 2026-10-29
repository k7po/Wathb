import 'package:flutter/material.dart';

import 'design_tokens.dart';

abstract final class WathbTheme {
  static ThemeData get light => _build(isDark: false);
  static ThemeData get dark => _build(isDark: true);

  static ThemeData lightForLocale(Locale? locale) =>
      _build(isDark: false, fontFamily: _fontFamily(locale));

  static ThemeData darkForLocale(Locale? locale) =>
      _build(isDark: true, fontFamily: _fontFamily(locale));

  static String _fontFamily(Locale? locale) {
    final languageCode =
        locale?.languageCode ??
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return languageCode == 'en' ? 'Inter' : 'IBMPlexSansArabic';
  }

  static ThemeData _build({required bool isDark, String? fontFamily}) {
    final colors = isDark
        ? const ColorScheme.dark(
            primary: WathbColors.darkPrimary,
            onPrimary: WathbColors.darkOnPrimary,
            secondary: WathbColors.darkSecondary,
            surface: WathbColors.darkSurface,
            onSurface: WathbColors.darkText,
            error: WathbColors.darkError,
            onError: WathbColors.darkOnPrimary,
            outline: WathbColors.darkOutline,
            surfaceContainerHighest: WathbColors.darkSurfaceVariant,
          )
        : const ColorScheme.light(
            primary: WathbColors.lightPrimary,
            onPrimary: WathbColors.lightOnPrimary,
            secondary: WathbColors.lightSecondary,
            surface: WathbColors.lightSurface,
            onSurface: WathbColors.lightText,
            error: WathbColors.lightError,
            onError: WathbColors.lightOnPrimary,
            outline: WathbColors.lightOutline,
            surfaceContainerHighest: WathbColors.lightSurfaceVariant,
          );
    final muted = isDark ? WathbColors.darkMuted : WathbColors.lightMuted;
    final textColor = isDark ? WathbColors.darkText : WathbColors.lightText;
    final accent = isDark ? WathbColors.darkAccent : WathbColors.lightAccent;
    final baseTextTheme = ThemeData(useMaterial3: true).textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: colors,
      scaffoldBackgroundColor: isDark
          ? WathbColors.darkBackground
          : WathbColors.lightBackground,
      fontFamily: fontFamily ?? 'IBMPlexSansArabic',
      textTheme: baseTextTheme
          .apply(
            bodyColor: textColor,
            displayColor: textColor,
            fontFamily: fontFamily ?? 'IBMPlexSansArabic',
          )
          .copyWith(
            bodySmall: baseTextTheme.bodySmall?.copyWith(color: muted),
            labelMedium: baseTextTheme.labelMedium?.copyWith(color: muted),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark
            ? WathbColors.darkBackground
            : WathbColors.lightBackground,
        foregroundColor: textColor,
        centerTitle: false,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WathbRadius.card),
          side: BorderSide(color: colors.outlineVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WathbRadius.field),
          borderSide: BorderSide(color: colors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WathbRadius.field),
          borderSide: BorderSide(color: colors.outline),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surface,
        indicatorColor: accent,
        labelTextStyle: WidgetStatePropertyAll(
          baseTextTheme.labelMedium?.copyWith(color: muted),
        ),
        height: WathbTouchTarget.minimum * 1.6,
      ),
      iconTheme: IconThemeData(color: colors.primary),
      dividerTheme: DividerThemeData(color: colors.outlineVariant),
    );
  }
}
