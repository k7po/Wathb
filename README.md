# Wathb | وثب

**A Multi-Sport Match Coordination App**

Wathb (وثب) is a Flutter application for organizing sports matches and helping players coordinate games. The project is under active development; this README distinguishes the current prototype from planned functionality.

[![Flutter](https://img.shields.io/badge/Flutter-Framework-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-Language-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![Status](https://img.shields.io/badge/Status-In%20Development-orange)](#project-status)

- **Repository:** https://github.com/k7po/Wathb
- **Platform:** Flutter (Android and other Flutter targets, subject to testing)
- **Languages:** Arabic and English

---

## Overview

Wathb aims to make it easier for players to arrange matches, invite friends, organize teams, and coordinate sports activities in one place.

The current codebase is a prototype. Features listed under **Current prototype** are distinct from items in the roadmap and should not be interpreted as completed production functionality.

## Current prototype

The repository currently includes the following app-level functionality:

- Arabic and English interface support, including right-to-left and left-to-right layouts.
- Light, dark, and system theme preferences.
- Local match creation with basic details such as name, location, date, and time.
- Basic input validation.
- A list of upcoming matches ordered by time.
- Local preference storage.

> **Data note:** Match data and preferences in the prototype are stored locally. They are not automatically shared with other users or synchronized between devices.

## Roadmap

The following are planned or require further implementation and verification:

| Area | Intended capability |
| --- | --- |
| Accounts | Secure registration, sign-in, and account management |
| Player profiles | Player cards, preferred sports/positions, and privacy controls |
| Match coordination | Shared matches, invitations, and participant management |
| Team management | Team balancing, team assignment, and lineups |
| Social features | Friend requests, following players, and player ratings |
| Venues | Venue discovery, ratings, and booking integrations |
| Notifications | Match invitations, reminders, and match updates |
| Payments | Cost splitting and payment workflow |
| Backend | Reliable shared data, authorization, and server-side validation |

Roadmap items are not claims of completed functionality.

## Technology stack

- **Flutter / Dart** — application UI and cross-platform development.
- **SharedPreferences** — local preference persistence.
- **Supabase** — backend integration groundwork; production authentication and shared match-data flows must be implemented and verified before they can be considered available.
- **SQL** — database schema and policy resources, where present in the repository.

### Supabase status

Having Supabase configuration, SQL scripts, or Row Level Security (RLS) policies in the repository does not by itself mean the app is connected to a live project. Before treating backend features as production-ready, verify that:

1. The correct Supabase project URL and publishable/anon key are configured safely.
2. Authentication is implemented and tested.
3. Match and invitation operations read from and write to the database.
4. RLS policies restrict access as intended.
5. Secrets such as a `service_role` key are never embedded in the client app.

## Getting started

### Requirements

Install the following tools before running the app:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- [Git](https://git-scm.com/downloads)
- An Android emulator or a supported physical device; install Android Studio if you are targeting Android.

Confirm your environment:

```bash
flutter doctor
```

### Clone and run

```bash
git clone https://github.com/k7po/Wathb.git
cd Wathb
flutter pub get
flutter devices
flutter run
```

### Run checks

```bash
flutter test
flutter analyze
```

Resolve any reported errors before preparing a release.

### Optional Supabase configuration

If the app's current code expects compile-time Supabase values, supply your own project values when running it. For example:

```bash
flutter run \
--dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co \
--dart-define=SUPABASE_ANON_KEY=YOUR_PUBLISHABLE_OR_ANON_KEY
```

Replace the placeholders with values from your own Supabase project. Do not commit private credentials or a `service_role` key. Confirm the exact variable names expected by the current source code before using this command.

## Repository structure

The exact structure can evolve. Check the repository for the current files and folders.

| Path | Purpose |
| --- | --- |
| `lib/` | Flutter application source code |
| `test/` | Automated tests |
| `android/` | Android platform project |
| `ios/` | iOS platform project |
| `web/` | Web platform project, if enabled |
| `windows/` | Windows platform project, if enabled |
| `linux/` | Linux platform project, if enabled |
| `macos/` | macOS platform project, if enabled |
| `supabase/` | Backend SQL/configuration resources, if present |
| `pubspec.yaml` | Dependencies and Flutter project metadata |

Some platform folders or backend resources may not exist in every checkout.

## Testing and release readiness

Run `flutter test` and `flutter analyze` on the current checkout before relying on any previous test results. A successful debug run does not establish that every feature works in production.

Before publishing a release:

- Test on the target physical devices and supported OS versions.
- Verify sign-in, shared data, invitations, authorization, and error handling end to end.
- Configure production signing for Android and the required signing/provisioning for other platforms.
- Review privacy, data retention, and security practices.
- Document any known limitations.

## Contributing

Contributions, bug reports, and suggestions are welcome. When opening an issue, include:

- A clear description of the problem or proposed improvement.
- Steps to reproduce the issue, if applicable.
- Expected and actual behavior.
- Relevant logs or screenshots, with secrets and personal data removed.

For code changes, run:

```bash
flutter test
flutter analyze
```

before submitting a pull request.

## License

No license is specified in this README. Check the repository for an existing license file or add an appropriate license before presenting the project as open source for reuse.

---

**Project:** Wathb (وثب)
**Repository:** https://github.com/k7po/Wathb
