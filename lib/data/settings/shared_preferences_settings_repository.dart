import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/settings/settings_preferences.dart';

class SharedPreferencesSettingsRepository implements SettingsRepository {
  SharedPreferencesSettingsRepository(this._preferences);

  static const _themeKey = 'appearance.theme';
  static const _localeKey = 'appearance.locale';

  final SharedPreferences _preferences;

  @override
  Future<ThemePreference?> loadThemePreference() async {
    final value = _preferences.getString(_themeKey);
    for (final item in ThemePreference.values) {
      if (item.name == value) return item;
    }
    return null;
  }

  @override
  Future<LocalePreference?> loadLocalePreference() async {
    final value = _preferences.getString(_localeKey);
    for (final item in LocalePreference.values) {
      if (item.name == value) return item;
    }
    return null;
  }

  @override
  Future<void> saveThemePreference(ThemePreference preference) async {
    await _preferences.setString(_themeKey, preference.name);
  }

  @override
  Future<void> saveLocalePreference(LocalePreference preference) async {
    await _preferences.setString(_localeKey, preference.name);
  }
}
