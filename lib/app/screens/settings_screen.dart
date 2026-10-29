import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/settings/settings_controller.dart';
import '../../domain/settings/settings_preferences.dart';
import '../../l10n/app_localizations.dart';
import '../theme/design_tokens.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final settings = context.watch<SettingsController>();
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(WathbSpacing.x4),
        children: [
          Text(
            strings.settingsDescription,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: WathbSpacing.x6),
          Text(
            strings.language,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: WathbSpacing.x2),
          DropdownButtonFormField<LocalePreference>(
            key: const ValueKey('settings-locale'),
            initialValue: settings.localePreference,
            decoration: InputDecoration(
              labelText: strings.language,
              prefixIcon: const Icon(Icons.language_rounded),
            ),
            items: [
              DropdownMenuItem(
                value: LocalePreference.arabic,
                child: Text(strings.arabic),
              ),
              DropdownMenuItem(
                value: LocalePreference.english,
                child: Text(strings.english),
              ),
              DropdownMenuItem(
                value: LocalePreference.system,
                child: Text(strings.systemLocale),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                unawaited(
                  context.read<SettingsController>().setLocalePreference(value),
                );
              }
            },
          ),
          const SizedBox(height: WathbSpacing.x6),
          Text(strings.theme, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: WathbSpacing.x2),
          DropdownButtonFormField<ThemePreference>(
            key: const ValueKey('settings-theme'),
            initialValue: settings.themePreference,
            decoration: InputDecoration(
              labelText: strings.theme,
              prefixIcon: const Icon(Icons.contrast_rounded),
            ),
            items: [
              DropdownMenuItem(
                value: ThemePreference.system,
                child: Text(strings.systemTheme),
              ),
              DropdownMenuItem(
                value: ThemePreference.light,
                child: Text(strings.lightTheme),
              ),
              DropdownMenuItem(
                value: ThemePreference.dark,
                child: Text(strings.darkTheme),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                unawaited(
                  context.read<SettingsController>().setThemePreference(value),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
