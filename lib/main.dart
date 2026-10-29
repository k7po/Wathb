import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'application/settings/settings_controller.dart';
import 'config/supabase_config.dart';
import 'data/settings/shared_preferences_settings_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SupabaseConfig.validate();
  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(
      url: SupabaseConfig.projectUrl,
      publishableKey: SupabaseConfig.publishableKey,
    );
  }

  final preferences = await SharedPreferences.getInstance();
  final settingsController = SettingsController(
    SharedPreferencesSettingsRepository(preferences),
  );
  await settingsController.load();
  runApp(
    ChangeNotifierProvider.value(
      value: settingsController,
      child: const WathbApp(),
    ),
  );
}
