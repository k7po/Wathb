enum ThemePreference { system, light, dark }

enum LocalePreference { system, arabic, english }

abstract interface class SettingsRepository {
  Future<ThemePreference?> loadThemePreference();

  Future<LocalePreference?> loadLocalePreference();

  Future<void> saveThemePreference(ThemePreference preference);

  Future<void> saveLocalePreference(LocalePreference preference);
}
