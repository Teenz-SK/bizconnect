import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
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
  bool isLoginMode = true; // 🔥 NEW

  final _nameController = TextEditingController();
  final _businessController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _otpController = TextEditingController();

  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
  }

  void _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
      isOtpStage = true;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("OTP Sent (Use: 1234)")));
  }

  void _verifyOtp() {
    if (_otpController.text == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBackground,
      body: FadeTransition(
        opacity: _animController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔥 HEADER
              _buildHeader(),

              // 🔥 FORM CARD
              Transform.translate(
                offset: const Offset(0, -30),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Column(
                    children: [
                      // 🔥 LOGIN / REGISTER TOGGLE
                      _buildToggle(),

                      const SizedBox(height: 20),

                      Form(
                        key: _formKey,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: isOtpStage ? _buildOtpUI() : _buildFormUI(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 HEADER
  Widget _buildHeader() {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryGreen,
            AppTheme.primaryGreen.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset('assets/logo.png', fit: BoxFit.cover),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            isLoginMode ? "Welcome Back" : "Create your account",
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // 🔥 TOGGLE (PREMIUM)
  Widget _buildToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.accentYellow.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [_buildTab("Login", true), _buildTab("Register", false)],
      ),
    );
  }

  Widget _buildTab(String title, bool isLogin) {
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
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

  // 🔹 FORM UI
  Widget _buildFormUI() {
    return Column(
      key: const ValueKey("form"),
      children: [
        if (!isLoginMode) ...[
          _buildInput("User Name", Icons.person, _nameController),
          _buildInput("Business Name", Icons.business, _businessController),
          _buildInput("Email", Icons.email, _emailController),
        ],

        _buildInput(
          "Mobile Number",
          Icons.phone,
          _mobileController,
          isNumber: true,
        ),

        const SizedBox(height: 20),

        _buildButton(
          text: isLoginMode ? "Login via OTP" : "Register via OTP",
          onTap: _sendOtp,
        ),
      ],
    );
  }

  // 🔹 OTP UI
  Widget _buildOtpUI() {
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
          style: const TextStyle(fontSize: 24, letterSpacing: 10),
          decoration: const InputDecoration(counterText: ""),
        ),

        const SizedBox(height: 20),

        _buildButton(text: "Verify", onTap: _verifyOtp),
      ],
    );
  }

  // 🔹 INPUT
  Widget _buildInput(
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
          fillColor: AppTheme.accentYellow.withValues(alpha: 0.08),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // 🔹 BUTTON
  Widget _buildButton({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen,
          borderRadius: BorderRadius.circular(14),
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
