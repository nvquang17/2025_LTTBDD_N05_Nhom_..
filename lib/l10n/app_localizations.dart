import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const Map<String, Map<String, String>> _localizedValues = {
    'vi': {
      'app_title': 'Theo dõi sức khỏe',
      'home': 'Trang chủ',
      'add_record': 'Thêm dữ liệu',
      'statistics': 'Thống kê',
      'settings': 'Cài đặt',
      'about': 'Giới thiệu',
      'weight': 'Cân nặng (kg)',
      'water': 'Nước (L)',
      'sleep': 'Giấc ngủ (giờ)',
      'save': 'Lưu',
      'change_language': 'Đổi ngôn ngữ',
      'no_data': 'Chưa có dữ liệu'
    },
    'en': {
      'app_title': 'Health Tracker',
      'home': 'Dashboard',
      'add_record': 'Add Record',
      'statistics': 'Statistics',
      'settings': 'Settings',
      'about': 'About',
      'weight': 'Weight (kg)',
      'water': 'Water (L)',
      'sleep': 'Sleep (h)',
      'save': 'Save',
      'change_language': 'Change language',
      'no_data': 'No data'
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['vi', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
