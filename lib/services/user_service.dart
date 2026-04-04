import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _categoryKey = 'user_category';

  // Save user's primary interest
  Future<void> saveUserCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_categoryKey, category);
  }

  // Get user's primary interest
  Future<String?> getUserCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_categoryKey);
  }

  // Check if user is "Onboarded"
  Future<bool> hasSelectedCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_categoryKey);
  }
}