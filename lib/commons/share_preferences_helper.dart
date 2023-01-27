import 'package:shared_preferences/shared_preferences.dart';

import '../utils/logger.dart';

class SharedPreferencesHelper {
  static const _authTokenKey = '_authTokenKey';
  static const _userId = '_userId';

  static void setToken(String token, String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_authTokenKey, token);
      await prefs.setString(_userId, userId);
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

  static Future<String?> getUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userId);
    } catch (e) {
      return "";
    }
  }

  static Future<void> removeTokenAndUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_authTokenKey);
      await prefs.remove(_userId);
    } catch (e) {
      logger.e(e);
    }
  }
}
