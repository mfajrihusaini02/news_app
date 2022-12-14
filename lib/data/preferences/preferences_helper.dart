import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const DARK_THEME = 'DARK_THEME';
  static const DAILY_NEWS = 'DAILY_NEWS';

  PreferencesHelper({required this.sharedPreferences});

  // Dark Theme
  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DARK_THEME) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DARK_THEME, value);
  }

  // Pengaturan schedule daily news
  Future<bool> get isDailyNewsActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_NEWS) ?? false;
  }

  void setDailyNews(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_NEWS, value);
  }
}
