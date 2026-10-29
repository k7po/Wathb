import 'package:flutter/foundation.dart';

import '../../domain/settings/settings_preferences.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(this._repository);

  final SettingsRepository _repository;

  ThemePreference _themePreference = ThemePreference.system;
  LocalePreference _localePreference = LocalePreference.arabic;

  ThemePreference get themePreference => _themePreference;
  LocalePreference get localePreference => _localePreference;

  Future<void> load() async {
    _themePreference =
        await _repository.loadThemePreference() ?? ThemePreference.system;
    _localePreference =
        await _repository.loadLocalePreference() ?? LocalePreference.arabic;
    notifyListeners();
  }

  Future<void> setThemePreference(ThemePreference preference) async {
    if (_themePreference == preference) return;
    _themePreference = preference;
    notifyListeners();
    await _repository.saveThemePreference(preference);
  }

  Future<void> setLocalePreference(LocalePreference preference) async {
    if (_localePreference == preference) return;
    _localePreference = preference;
    notifyListeners();
    await _repository.saveLocalePreference(preference);
  }
}
