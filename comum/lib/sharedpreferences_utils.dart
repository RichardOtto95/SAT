import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static SharedPreferences? _sharedPrefs;

  static init() async => _sharedPrefs = await SharedPreferences.getInstance();

  static String getString(String key) => _sharedPrefs!.getString(key) ?? '';

  static Future setString(String key, String value) async =>
      _sharedPrefs!.setString(key, value);

  static bool getBool(String key) => _sharedPrefs!.getBool(key) ?? false;

  static Future setBool(String key, bool value) async =>
      _sharedPrefs!.setBool(key, value);

  static Future remove(String key) => _sharedPrefs!.remove(key);
}
