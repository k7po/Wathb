import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wathb/app/screens/home_screen.dart';
import 'package:wathb/app/theme/app_theme.dart';
import 'package:wathb/l10n/app_localizations.dart';

void main() {
  testWidgets('creates and shows a local match from the empty state', (
    tester,
  ) async {
    await tester.pumpWidget(_homeApp());
    await tester.pumpAndSettle();

    expect(find.text('لا توجد مباريات قادمة بعد'), findsOneWidget);
    expect(
      find.text('المباريات مؤقتة وتختفي عند إغلاق التطبيق.'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('create-match-button')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('save-match-button')));
    await tester.tap(find.byKey(const ValueKey('save-match-button')));
    await tester.pumpAndSettle();
    expect(find.text('أدخل اسم المباراة.'), findsOneWidget);
    expect(find.text('أدخل موقع المباراة.'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('match-title-field')),
      'مباراة الحي',
    );
    await tester.enterText(
      find.byKey(const ValueKey('match-location-field')),
      'ملعب الجامعة',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('save-match-button')));
    await tester.tap(find.byKey(const ValueKey('save-match-button')));
    await tester.pumpAndSettle();

    expect(find.text('مباراة الحي'), findsOneWidget);
    expect(find.textContaining('ملعب الجامعة'), findsOneWidget);
    expect(find.text('لا توجد مباريات قادمة بعد'), findsNothing);
  });

  testWidgets('home screen remains localized in English and dark mode', (
    tester,
  ) async {
    await tester.pumpWidget(_homeApp(locale: const Locale('en'), dark: true));
    await tester.pumpAndSettle();

    expect(find.text('Upcoming matches'), findsOneWidget);
    expect(find.text('Create a match'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.text('Upcoming matches'))),
      TextDirection.ltr,
    );
    expect(
      Theme.of(tester.element(find.text('Upcoming matches'))).brightness,
      Brightness.dark,
    );
  });
}

Widget _homeApp({Locale locale = const Locale('ar'), bool dark = false}) =>
    MaterialApp(
      locale: locale,
      theme: WathbTheme.lightForLocale(locale),
      darkTheme: WathbTheme.darkForLocale(locale),
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(body: HomeScreen()),
    );
