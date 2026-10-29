import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/settings/settings_controller.dart';
import '../domain/settings/settings_preferences.dart';
import '../l10n/app_localizations.dart';
import 'navigation/app_shell.dart';
import 'theme/app_theme.dart';

class WathbApp extends StatelessWidget {
  const WathbApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final preferredLocale = switch (settings.localePreference) {
      LocalePreference.system => null,
      LocalePreference.arabic => const Locale('ar'),
      LocalePreference.english => const Locale('en'),
    };
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: WathbTheme.lightForLocale(preferredLocale),
      darkTheme: WathbTheme.darkForLocale(preferredLocale),
      themeMode: switch (settings.themePreference) {
        ThemePreference.system => ThemeMode.system,
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
      },
      locale: preferredLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const AppShell(),
    );
  }
}
