import 'dart:math' as math;
import 'dart:ui';
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
    with TickerProviderStateMixin {
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
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
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
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBackground,

      /// 🧊 GLASS APPBAR
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: Colors.white.withValues(alpha: 0.5)),
          ),
        ),
      ),

      body: Stack(
        children: [
          /// 🌈 LAYERED BACKGROUND
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

          /// 🔥 FLOATING + PULSE BLOBS
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              double scale = 1 + (_pulseController.value * 0.08);

              return Stack(
                children: [
                  Positioned(
                    top: -150,
                    right: -120,
                    child: Transform.scale(
                      scale: scale,
                      child: const FloatingBlob(
                        size: 450,
                        color: AppTheme.primaryGreen,
                        duration: Duration(seconds: 6),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -160,
                    left: -120,
                    child: Transform.scale(
                      scale: scale,
                      child: const FloatingBlob(
                        size: 420,
                        color: AppTheme.accentYellow,
                        duration: Duration(seconds: 8),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
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
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: AppTheme.cardShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Image.asset("assets/logo1.png"),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(30),
              boxShadow: AppTheme.cardShadow,
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
        ),
      ),
    );
  }

  /// 🔥 INPUT WITH FOCUS EFFECT
  Widget _input(
    String hint,
    IconData icon,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Focus(
        child: Builder(
          builder: (context) {
            final isFocused = Focus.of(context).hasFocus;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                boxShadow: isFocused
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                          blurRadius: 20,
                        ),
                      ]
                    : [],
              ),
              child: TextFormField(
                controller: controller,
                keyboardType: isNumber
                    ? TextInputType.phone
                    : TextInputType.text,
                validator: (val) =>
                    val == null || val.isEmpty ? "Required" : null,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    icon,
                    color: isFocused
                        ? AppTheme.primaryGreen
                        : AppTheme.textSecondary,
                  ),
                  hintText: hint,
                  filled: true,
                  fillColor: AppTheme.greyLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 🔥 BUTTON
  Widget _button({required String text, required VoidCallback onTap}) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 150),
      tween: Tween<double>(begin: 1, end: isLoading ? 0.96 : 1),
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isLoading ? null : onTap,
              borderRadius: BorderRadius.circular(18),
              splashColor: Colors.white.withValues(alpha: 0.2),
              highlightColor: Colors.transparent,
              child: Ink(
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF10B981), // emerald
                      Color(0xFF059669), // deeper emerald
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),

                  /// 💎 SHADOW (DEPTH)
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withValues(alpha: 0.35),
                      blurRadius: 22,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    /// ✨ TOP LIGHT (GLASS EFFECT)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.25),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),

                    /// 🔘 CONTENT
                    isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.lock_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 🔹 FORM
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

  /// 🔹 OTP
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

  /// 🔥 TOGGLE (unchanged logic, enhanced UI)
  Widget _buildToggle() {
    return Row(children: [_tab("Login", true), _tab("Register", false)]);
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
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 12),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),

            // 💎 LIGHT PREMIUM STYLE (not heavy)
            gradient: selected
                ? LinearGradient(
                    colors: [
                      AppTheme.primaryEmerald.withValues(alpha: 0.15),
                      AppTheme.lightBrown.withValues(alpha: 0.12),
                    ],
                  )
                : null,

            // 🔥 SUBTLE BORDER (important)
            border: Border.all(
              color: selected
                  ? AppTheme.primaryEmerald.withValues(alpha: 0.4)
                  : Colors.transparent,
            ),
          ),

          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,

                // 🎯 TEXT COLOR SYSTEM
                color: selected
                    ? AppTheme.primaryEmerald
                    : AppTheme.textSecondary,
              ),
              child: Text(title),
            ),
          ),
        ),
      ),
    );
  }
}
