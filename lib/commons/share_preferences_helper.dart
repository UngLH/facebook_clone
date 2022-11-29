import 'package:shared_preferences/shared_preferences.dart';

import '../utils/logger.dart';

class SharedPreferencesHelper {
  static const _authTokenKey = '_authTokenKey';

  static void setToken(String token) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_authTokenKey, token);
    } catch (e) {
      logger.e(e);
    }
  }

  static Future<String?> getToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_authTokenKey);
    } catch (e) {
      return "";
    }
  }

  static Future<void> removeToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_authTokenKey);
    } catch (e) {
      logger.e(e);
    }
  }
}
