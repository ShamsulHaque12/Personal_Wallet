import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const String _userIdKey = 'user_id';

  /// Save User ID to SharedPreferences
  static Future<bool> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_userIdKey, userId);
  }

  /// Retrieve User ID from SharedPreferences
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  /// Remove User ID from SharedPreferences
  static Future<bool> removeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_userIdKey);
  }

  /// Clear all stored SharedPreferences data
  static Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
