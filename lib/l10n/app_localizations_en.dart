// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'WATHB';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get homeTitle => 'Welcome to WATHB';

  @override
  String get upcomingMatchesDescription =>
      'Plan a game and keep its details close.';

  @override
  String get localMatchesNotice =>
      'Matches are temporary and disappear when you close the app.';

  @override
  String get upcomingMatches => 'Upcoming matches';

  @override
  String get createMatch => 'Create a match';

  @override
  String get noUpcomingMatchesTitle => 'No upcoming matches yet';

  @override
  String get noUpcomingMatchesMessage =>
      'Create a match to add it to your local list.';

  @override
  String get matchTitle => 'Match name';

  @override
  String get matchTitleRequired => 'Enter a match name.';

  @override
  String get matchLocation => 'Location';

  @override
  String get matchLocationRequired => 'Enter a location.';

  @override
  String get matchDate => 'Date';

  @override
  String get matchTime => 'Time';

  @override
  String get matchMustBeFuture => 'Choose a future date and time.';

  @override
  String get saveMatch => 'Add match';

  @override
  String get emptyTitle => 'Your space is ready';

  @override
  String get emptyMessage =>
      'Your activity will appear here when it is available.';

  @override
  String get language => 'Language';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get systemLocale => 'Use device language';

  @override
  String get theme => 'Appearance';

  @override
  String get systemTheme => 'Use device setting';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get settingsDescription =>
      'Choose the language and appearance that work for you.';

  @override
  String get loadingLabel => 'Loading';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorMessage => 'Please try again.';

  @override
  String get retry => 'Try again';

  @override
  String get unauthorizedTitle => 'You do not have access';

  @override
  String get unauthorizedMessage =>
      'Sign in with an authorized account to continue.';
}
