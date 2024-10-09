
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceData {
  static SharedPreferenceData? _instance;
  factory SharedPreferenceData.getInstance() => _instance ??= SharedPreferenceData._internal();
  SharedPreferenceData._internal();

  static const isAuth = "is_auth";

  Future<bool> setIsAuth(final String? type) => setItem(isAuth, type);

  Future<String> getIsAuth() => getItem(isAuth);

  Future<bool> setItem(final String key, final String? item) async {
    final sp = await SharedPreferences.getInstance();
    final result = sp.setString(key, item ?? '');
    return result;
  }

  Future<String> getItem(final String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(key) ?? '';
  }
}