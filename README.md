# Wathb

Wathb is a multi-sport coordination app prototype built with Flutter. The current app provides a bilingual interface and a small, local-only match planning flow. It is not a production-ready sports platform.

## Current Features

- Arabic and English localization with right-to-left and left-to-right layouts.
- Light, dark, and system appearance options. The selected language and appearance are saved on the device with shared preferences.
- A home screen where a user can create a match with a name, location, date, and time. The form requires a name and location and rejects a date and time in the past.
- Upcoming match cards sorted by start time, plus an empty state when there are no matches.
- A settings screen for language and appearance preferences.

Matches are held in application memory only. They disappear when the app closes and are not saved to Supabase or synchronized between devices.

## Planned or Incomplete Features

The following product areas are not implemented in the Flutter app yet:

- Sign-up, sign-in, email confirmation, password recovery, and session management.
- A working profile flow, friendships, follows, invitations, and privacy controls.
- Match storage, server synchronization, participant management, comments, and recurring matches.
- Team generation, attendance, results, player history, and player or venue ratings.
- Venue discovery, in-app notifications, and push notifications.

Bookings and payments are not part of the current scope unless they are added through a separate product decision.

## Supabase Integration Status

The project includes the `supabase_flutter` dependency and optional client initialization. At startup, the app initializes the Supabase client only when both `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY` are provided as Dart compile-time environment values. If neither is provided, the app continues without initializing Supabase. Providing only one causes configuration validation to fail.

The app currently has no authentication flow and does not use Supabase to create, read, update, or synchronize matches. A SQL migration for a private profiles table and a database RLS test are present under `supabase/`, but their application to any Supabase project and the execution of that SQL test have not been verified here.

## Prerequisites

- Flutter with a Dart SDK that satisfies the `^3.13.5` constraint in `pubspec.yaml`. The recorded workstation used Flutter 3.47.6 and Dart 3.13.5.
- Android Studio with a configured Android SDK, platform tools, and an Android emulator or connected device. The Android app's minimum SDK is API 26.
- Git, for obtaining and managing the project source.

An iOS build requires macOS and Xcode. An iOS build has not been verified.

## Install and Run on Android

From the project root, install the Flutter packages:

```sh
flutter pub get
```

Start an Android emulator from Android Studio, or list and launch an available Flutter emulator:

```sh
flutter emulators
flutter emulators --launch <emulator-id>
```

List connected devices and run the app in debug mode:

```sh
flutter devices
flutter run -d <device-id>
```

Run the automated checks with:

```sh
flutter test
flutter analyze
```

## Verification Status

Previously recorded checks reported that all 10 Flutter tests passed and `flutter analyze` found no issues. The Debug app was built, installed, and run on an Android 17 (API 37) emulator.

A Release build and an iOS build have not been verified.

## Resources

- `assets/fonts/` contains IBM Plex Sans Arabic font files for regular, medium, semibold, and bold weights, the Inter variable font, and the accompanying font license text files.
- `lib/l10n/` contains the English and Arabic ARB translation sources and the generated Dart localization classes.
- `android/app/src/main/res/` contains Android launcher icons, launch backgrounds, and day/night styles.
- `ios/Runner/Assets.xcassets/` contains iOS app icon and launch image assets.
- `supabase/migrations/` contains the profiles-table migration; `supabase/tests/database/` contains its RLS test script.
- `test/` contains Flutter widget tests for the foundation and the local match creation flow.

## Application Deployment

Development and testing currently use Flutter's Debug workflow on an Android emulator or device. The local match flow is intended for interface and interaction testing; it does not persist match data after the app closes. The recorded Android emulator run does not establish production readiness.

Before a production release:

1. Implement and test the remaining product features and their server-side data flows. In particular, implement authentication and match persistence before describing matches as synchronized.
2. Select and configure development, test, and production Supabase projects as needed. Review and test migrations and RLS policies against a non-production database before any production rollout.
3. Replace the Android debug signing configuration with a protected release signing setup. Confirm application identifiers, versioning, permissions, and release build behavior.
4. Build and test the iOS app on macOS with Xcode, including signing and platform-specific configuration.
5. Complete privacy, terms, support, store listing, and operational requirements; test release builds on target devices before distribution.

The current Android Gradle release configuration uses the debug signing configuration. Do not distribute a Release build until production signing and the remaining release checks are complete.
