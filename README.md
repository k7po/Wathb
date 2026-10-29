Wathb | وثب

A Multi-Sport Match Coordination App

Wathb is a Flutter application project focused on simplifying sports match organization and player coordination. Its long-term vision is to bring match planning, team formation, player interaction, and venue discovery into one platform.

The project is currently in development. The available prototype provides a bilingual interface and basic local match-planning functionality. This README clearly distinguishes implemented features from planned development.

Project Status

Current stage: Prototype — In Development

The current application supports basic match creation and application preferences. Match records are held in application memory only. They are not saved to a backend or synchronized across devices.

Features listed in the roadmap are planned or incomplete and should not be considered available until implemented and verified.

Current Features

* Arabic and English: Localization with right-to-left (RTL) and left-to-right (LTR) layouts.
* Appearance settings: Light mode, dark mode, and system appearance.
* Local match creation: Enter a match name, location, date, and time.
* Input validation: Required-field checks and validation against past match times.
* Upcoming matches: Display locally created matches sorted by start time.
* Application preferences: Change language and appearance settings.

Development Roadmap

The following items represent planned development work, not completed functionality.

Area	Planned capabilities
Accounts	Registration, login, email verification, password recovery, and session management
Player profiles	Player information, preferred sports, social links, and privacy settings
Match coordination	Invitations, participant management, comments, and recurring matches
Team management	Team formation, player distribution, lineups, and attendance
Social features	Friend requests, following players, player history, and ratings
Venues	Venue discovery and venue ratings
Notifications	In-app notifications and push notifications
Backend	Persistent storage, synchronization, access control, and server-side validation

Bookings and payments are not implemented in the current prototype. Their inclusion will depend on future product decisions.

Technology Stack

Technology	Purpose
Flutter	Cross-platform application development
Dart	Application programming language
SharedPreferences	Local storage for language and appearance preferences
Supabase	Backend integration groundwork
SQL	Database migration and security policy resources

Supabase Integration Status

The project includes the supabase_flutter dependency and optional client initialization.

The Supabase client initializes only when both SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY are supplied as Dart compile-time environment values.

Backend functionality is incomplete. The current prototype does not use Supabase for authentication, match creation, match retrieval, updates, or cross-device synchronization.

A database migration for a profiles table and an RLS test script are present under supabase/. Their application to a live Supabase project and successful execution have not been verified.

Getting Started

Prerequisites

* Flutter SDK with a Dart version compatible with the project’s pubspec.yaml.
* Android Studio and a configured Android SDK.
* An Android emulator or connected Android device.
* Git.

iOS development requires macOS and Xcode. An iOS build has not been verified.

1. Clone the Repository

git clone https://github.com/k7po/Wathb.git
cd Wathb

2. Install Dependencies

flutter pub get

3. Run the Application

Check available devices:

flutter devices

Run the application:

flutter run

4. Run Tests and Static Analysis

flutter test
flutter analyze

Run these checks against the revision you intend to use. Previously recorded results do not guarantee that the current revision passes.

Optional Supabase Configuration

For development involving the initial Supabase integration, provide the project URL and publishable key:

flutter run \
  --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL \
  --dart-define=SUPABASE_PUBLISHABLE_KEY=YOUR_SUPABASE_PUBLISHABLE_KEY

Replace the placeholders with your own project values.

Never commit service-role keys, database passwords, or other privileged credentials to a public repository. Client-side configuration must be supported by appropriate database permissions and Row Level Security (RLS) policies.

Repository Structure

Path	Description
lib/	Flutter application source code
lib/l10n/	Arabic and English localization resources
assets/fonts/	Application fonts and license files
android/	Android platform configuration and resources
ios/	iOS platform configuration and resources
supabase/migrations/	Database migration resources
supabase/tests/database/	Database security test resources
test/	Flutter automated tests
pubspec.yaml	Dependencies and project configuration

Testing and Release Readiness

Previously recorded development notes reported that 10 Flutter tests passed, flutter analyze found no issues, and a Debug build ran on an Android emulator.

These are historical results and should not be interpreted as a guarantee that the current revision passes all checks.

A Release build and an iOS build have not been verified. The Android release configuration currently uses debug signing, so a production release must not be distributed until production signing and the remaining release checks are completed.

Before a production release, the project requires:

* Verified authentication and backend data operations.
* Tested database permissions and RLS policies.
* Secure production signing and verified release builds.
* Testing on target devices and supported platforms.
* Appropriate privacy, support, and store-release requirements.

Contributing

Wathb is an ongoing development project. Contributions and code reviews that improve functionality, accessibility, security, and maintainability are welcome.

Please include relevant test results with proposed changes and clearly distinguish implemented functionality from planned features.

License

No license is currently declared in this README. Unless a license is added to the repository, do not assume the source code is available for unrestricted reuse or redistribution.

⸻

Repository: github.com/k7po/Wathb
