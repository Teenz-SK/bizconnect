import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // 🔥 KEYS
  static const String _isRegisteredKey = 'is_b2b_registered';
  static const String _categoryKey = 'user_category';

  // ================================
  // 🔹 REGISTRATION LOGIC (NEW B2B)
  // ================================

  // ✅ Save registration status
  Future<void> setRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isRegisteredKey, true);
  }

  // ✅ Check if user is registered
  Future<bool> isRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isRegisteredKey) ?? false;
  }

  // ================================
  // 🔹 CATEGORY LOGIC (OLD SYSTEM)
  // ================================

  // ✅ Save user's category
  Future<void> saveUserCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_categoryKey, category);
  }

  // ✅ Get user's category
  Future<String?> getUserCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_categoryKey);
  }

  // ✅ Check if category exists
  Future<bool> hasSelectedCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_categoryKey);
  }

  // ================================
  // 🔥 OPTIONAL (VERY USEFUL)
  // ================================

  // ❌ Logout / Reset app
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}