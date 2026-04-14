import 'dart:async';

class OTPService {
  // Mocking an API call
  static Future<bool> sendOTP(String mobile) async {
    await Future.delayed(const Duration(seconds: 2));
    return true; // Always successful in mock
  }

  static bool verifyOTP(String input) {
    return input == "1234"; // Our static mock OTP
  }
}