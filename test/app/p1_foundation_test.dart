import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:wathb/app/app.dart';
import 'package:wathb/app/theme/app_theme.dart';
import 'package:wathb/app/theme/design_tokens.dart';
import 'package:wathb/app/widgets/state_panel.dart';
import 'package:wathb/application/settings/settings_controller.dart';
import 'package:wathb/domain/settings/settings_preferences.dart';
import 'package:wathb/l10n/app_localizations.dart';

void main() {
  group('P1 foundation', () {
    test('settings preferences persist and reload', () async {
      final repository = MemorySettingsRepository();
      final firstController = SettingsController(repository);
      await firstController.load();
      await firstController.setThemePreference(ThemePreference.dark);
      await firstController.setLocalePreference(LocalePreference.english);

      final restoredController = SettingsController(repository);
      await restoredController.load();

      expect(restoredController.themePreference, ThemePreference.dark);
      expect(restoredController.localePreference, LocalePreference.english);
    });

    testWidgets('starts in Arabic RTL and navigates to settings', (
      tester,
    ) async {
      final controller = SettingsController(MemorySettingsRepository());
      await controller.load();

      await tester.pumpWidget(_providedApp(controller));
      await tester.pumpAndSettle();

      expect(find.text('مرحبًا بك في وثب'), findsOneWidget);
      expect(
        Directionality.of(tester.element(find.text('مرحبًا بك في وثب'))),
        TextDirection.rtl,
      );

      await tester.tap(find.text('الإعدادات').last);
      await tester.pumpAndSettle();
      expect(find.text('اختر اللغة والمظهر المناسبين لك.'), findsOneWidget);
    });

    testWidgets('manual theme and language choices update and persist', (
      tester,
    ) async {
      final repository = MemorySettingsRepository();
      final controller = SettingsController(repository);
      await controller.load();
      await tester.pumpWidget(_providedApp(controller));
      await tester.pumpAndSettle();

      await tester.tap(find.text('الإعدادات').last);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('settings-theme')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('داكن').last);
      await tester.pumpAndSettle();
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.themeMode, ThemeMode.dark);
      expect(repository.theme, ThemePreference.dark);

      await tester.tap(find.byKey(const ValueKey('settings-locale')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('English').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home').last);
      await tester.pumpAndSettle();
      expect(find.text('Welcome to WATHB'), findsOneWidget);
      expect(
        Directionality.of(tester.element(find.text('Welcome to WATHB'))),
        TextDirection.ltr,
      );
      expect(repository.locale, LocalePreference.english);
    });

    testWidgets('system theme follows the device appearance', (tester) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

      final controller = SettingsController(MemorySettingsRepository());
      await controller.load();
      await tester.pumpWidget(_providedApp(controller));
      await tester.pumpAndSettle();

      expect(
        Theme.of(tester.element(find.text('مرحبًا بك في وثب'))).brightness,
        Brightness.dark,
      );
    });

    testWidgets('shared state panel supports all required screen states', (
      tester,
    ) async {
      Widget host(ContentStatus status) => MaterialApp(
        theme: WathbTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: StatePanel(
            status: status,
            title: 'State title',
            message: 'State details',
            onRetry: () {},
            successContent: const Text('Success content'),
          ),
        ),
      );

      await tester.pumpWidget(host(ContentStatus.loading));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpWidget(host(ContentStatus.empty));
      expect(find.text('State title'), findsOneWidget);

      await tester.pumpWidget(host(ContentStatus.error));
      expect(find.text('State title'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);

      await tester.pumpWidget(host(ContentStatus.unauthorized));
      expect(find.text('State details'), findsOneWidget);

      await tester.pumpWidget(host(ContentStatus.success));
      expect(find.text('Success content'), findsOneWidget);
    });

    test('semantic text color pairs meet WCAG AA contrast', () {
      expect(
        _contrast(WathbColors.lightText, WathbColors.lightBackground),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrast(WathbColors.lightMuted, WathbColors.lightSurface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrast(WathbColors.lightOnPrimary, WathbColors.lightPrimary),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrast(WathbColors.darkText, WathbColors.darkBackground),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrast(WathbColors.darkOnPrimary, WathbColors.darkPrimary),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('light and dark palettes remain monochrome', () {
      const colors = [
        WathbColors.lightBackground,
        WathbColors.lightSurface,
        WathbColors.lightSurfaceVariant,
        WathbColors.lightPrimary,
        WathbColors.lightOnPrimary,
        WathbColors.lightSecondary,
        WathbColors.lightAccent,
        WathbColors.lightText,
        WathbColors.lightMuted,
        WathbColors.lightOutline,
        WathbColors.lightError,
        WathbColors.lightWarning,
        WathbColors.lightSuccess,
        WathbColors.darkBackground,
        WathbColors.darkSurface,
        WathbColors.darkSurfaceVariant,
        WathbColors.darkPrimary,
        WathbColors.darkOnPrimary,
        WathbColors.darkSecondary,
        WathbColors.darkAccent,
        WathbColors.darkText,
        WathbColors.darkMuted,
        WathbColors.darkOutline,
        WathbColors.darkError,
        WathbColors.darkWarning,
        WathbColors.darkSuccess,
      ];

      for (final color in colors) {
        final argb = color.toARGB32();
        final red = (argb >> 16) & 0xFF;
        final green = (argb >> 8) & 0xFF;
        final blue = argb & 0xFF;
        expect(green, red);
        expect(blue, red);
      }
    });

    test('typography follows the selected language', () {
      expect(
        WathbTheme.lightForLocale(const Locale('ar'))
            .textTheme
            .bodyMedium
            ?.fontFamily,
        'IBMPlexSansArabic',
      );
      expect(
        WathbTheme.lightForLocale(const Locale('en'))
            .textTheme
            .bodyMedium
            ?.fontFamily,
        'Inter',
      );
    });
  });
}

Widget _providedApp(SettingsController controller) =>
    ChangeNotifierProvider<SettingsController>.value(
      value: controller,
      child: const WathbApp(),
    );

double _contrast(Color foreground, Color background) {
  final foregroundLuminance = foreground.computeLuminance();
  final backgroundLuminance = background.computeLuminance();
  final lighter = foregroundLuminance > backgroundLuminance
      ? foregroundLuminance
      : backgroundLuminance;
  final darker = foregroundLuminance > backgroundLuminance
      ? backgroundLuminance
      : foregroundLuminance;
  return (lighter + 0.05) / (darker + 0.05);
}

class MemorySettingsRepository implements SettingsRepository {
  ThemePreference? theme;
  LocalePreference? locale;

  @override
  Future<ThemePreference?> loadThemePreference() async => theme;

  @override
  Future<LocalePreference?> loadLocalePreference() async => locale;

  @override
  Future<void> saveThemePreference(ThemePreference preference) async {
    theme = preference;
  }

  @override
  Future<void> saveLocalePreference(LocalePreference preference) async {
    locale = preference;
  }
}
