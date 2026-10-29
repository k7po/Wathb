abstract final class SupabaseConfig {
  static const projectUrl = String.fromEnvironment('SUPABASE_URL');
  static const publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  static bool get hasAnyValue =>
      projectUrl.isNotEmpty || publishableKey.isNotEmpty;

  static bool get isConfigured =>
      projectUrl.isNotEmpty && publishableKey.isNotEmpty;

  static void validate() {
    if (hasAnyValue && !isConfigured) {
      throw StateError(
        'Provide both SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY.',
      );
    }
  }
}
