import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_theme.dart';
import '../widgets/floating_blob.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  bool isOtpStage = false;
  bool isLoading = false;
  bool isLoginMode = true;

  final _nameController = TextEditingController();
  final _businessController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _otpController = TextEditingController();

  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _shake() {
    HapticFeedback.mediumImpact();
    _shakeController.forward(from: 0);
  }

  void _sendOtp() async {
    if (!_formKey.currentState!.validate()) {
      _shake();
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
      isOtpStage = true;
    });
  }

  void _verifyOtp() {
    if (_otpController.text == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      _shake();
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBackground,
      body: Stack(
        children: [
          /// 🔥 PREMIUM BACKGROUND (LAYERED GRADIENT)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF4FAF6),
                  Color(0xFFEAF5EE),
                  Color(0xFFF8FCF9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// 🌫 BIG GLOW BLOBS (MORE RADIUS + PULSE FEEL)
          const Positioned(
            top: -140,
            right: -120,
            child: FloatingBlob(
              size: 420, // 🔥 bigger
              color: AppTheme.primaryGreen,
              duration: Duration(seconds: 6),
            ),
          ),
          const Positioned(
            bottom: -140,
            left: -120,
            child: FloatingBlob(
              size: 380, // 🔥 bigger
              color: AppTheme.accentYellow,
              duration: Duration(seconds: 8),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 30),

                _buildHeader(),

                const SizedBox(height: 20),

                Expanded(child: Center(child: _buildCard())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 HEADER
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Image.asset("assets/logo.png"),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isLoginMode ? "Welcome Back" : "Create Account",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  /// 🔥 CARD
  Widget _buildCard() {
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final offset =
            (1 - _shakeController.value) *
            10 *
            math.sin(_shakeController.value * 10);

        return Transform.translate(offset: Offset(offset, 0), child: child);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 40,
              offset: const Offset(0, 25),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggle(),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: isOtpStage ? _otpUI() : _formUI(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 TOGGLE (UPGRADED DEPTH + GRADIENT)
  Widget _buildToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.accentYellow.withValues(alpha: 0.15),
            AppTheme.accentYellow.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(children: [_tab("Login", true), _tab("Register", false)]),
    );
  }

  Widget _tab(String title, bool isLogin) {
    final selected = isLoginMode == isLogin;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLoginMode = isLogin;
            isOtpStage = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
                    colors: [Colors.white, Color(0xFFF8F8F8)],
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected
                    ? AppTheme.primaryGreen
                    : AppTheme.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔥 FORM
  Widget _formUI() {
    return Column(
      key: const ValueKey("form"),
      children: [
        if (!isLoginMode) ...[
          _input("User Name", Icons.person, _nameController),
          _input("Business Name", Icons.business, _businessController),
          _input("Email", Icons.email, _emailController),
        ],
        _input("Mobile Number", Icons.phone, _mobileController, isNumber: true),
        const SizedBox(height: 20),
        _button(
          text: isLoginMode ? "Login via OTP" : "Register via OTP",
          onTap: _sendOtp,
        ),
      ],
    );
  }

  /// 🔥 OTP
  Widget _otpUI() {
    return Column(
      key: const ValueKey("otp"),
      children: [
        const Text("Enter OTP"),
        const SizedBox(height: 16),
        TextFormField(
          controller: _otpController,
          textAlign: TextAlign.center,
          maxLength: 4,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(counterText: ""),
        ),
        const SizedBox(height: 20),
        _button(text: "Verify", onTap: _verifyOtp),
      ],
    );
  }

  /// 🔥 INPUT
  Widget _input(
    String hint,
    IconData icon,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        validator: (val) => val == null || val.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppTheme.primaryGreen),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  /// 🔥 BUTTON
  Widget _button({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.primaryGreen, Color(0xFF3AA35C)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGreen.withValues(alpha: 0.25),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
