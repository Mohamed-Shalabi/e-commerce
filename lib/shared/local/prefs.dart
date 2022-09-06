import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._();

  static late final SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static T? getData<T>({required String key}) {
    if (T == dynamic) {
      throw Exception('Type T must not be empty');
    }

    return _instance.get(key) as T?;
  }

  static Future<bool> saveOrRemoveData<T>({
    required String key,
    T? value,
  }) async {
    if (T == dynamic) {
      throw Exception('Type T must not be empty');
    }

    if (value == null) {
      return _instance.remove(key);
    }

    if (value is String) {
      return _instance.setString(key, value);
    } else if (value is int) {
      return _instance.setInt(key, value);
    } else if (value is double) {
      return _instance.setDouble(key, value);
    } else if (value is bool) {
      return _instance.setBool(key, value);
    }
    throw Exception('Unsupported type');
  }

  static const userKey = 'user_key';
  static const isLightThemeKey = 'is_light_theme_key';
  static const fontSizeAdditionKey = 'font_size_addition_key';
}
