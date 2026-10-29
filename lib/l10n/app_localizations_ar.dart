// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'وثب';

  @override
  String get home => 'الرئيسية';

  @override
  String get settings => 'الإعدادات';

  @override
  String get homeTitle => 'مرحبًا بك في وثب';

  @override
  String get upcomingMatchesDescription =>
      'خطط لمباراتك القادمة واحتفظ بتفاصيلها هنا.';

  @override
  String get localMatchesNotice => 'المباريات مؤقتة وتختفي عند إغلاق التطبيق.';

  @override
  String get upcomingMatches => 'المباريات القادمة';

  @override
  String get createMatch => 'إنشاء مباراة';

  @override
  String get noUpcomingMatchesTitle => 'لا توجد مباريات قادمة بعد';

  @override
  String get noUpcomingMatchesMessage =>
      'أنشئ مباراة لإضافتها إلى قائمتك المحلية.';

  @override
  String get matchTitle => 'اسم المباراة';

  @override
  String get matchTitleRequired => 'أدخل اسم المباراة.';

  @override
  String get matchLocation => 'الموقع';

  @override
  String get matchLocationRequired => 'أدخل موقع المباراة.';

  @override
  String get matchDate => 'التاريخ';

  @override
  String get matchTime => 'الوقت';

  @override
  String get matchMustBeFuture => 'اختر تاريخًا ووقتًا في المستقبل.';

  @override
  String get saveMatch => 'إضافة المباراة';

  @override
  String get emptyTitle => 'مساحتك جاهزة';

  @override
  String get emptyMessage => 'سيظهر نشاطك هنا عند توفره.';

  @override
  String get language => 'اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get systemLocale => 'حسب لغة الجهاز';

  @override
  String get theme => 'المظهر';

  @override
  String get systemTheme => 'حسب إعداد الجهاز';

  @override
  String get lightTheme => 'فاتح';

  @override
  String get darkTheme => 'داكن';

  @override
  String get settingsDescription => 'اختر اللغة والمظهر المناسبين لك.';

  @override
  String get loadingLabel => 'جارٍ التحميل';

  @override
  String get errorTitle => 'حدث خطأ';

  @override
  String get errorMessage => 'حاول مرة أخرى.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get unauthorizedTitle => 'لا تملك صلاحية الوصول';

  @override
  String get unauthorizedMessage => 'تابع باستخدام حساب مخوّل.';
}
