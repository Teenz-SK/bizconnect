import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import 'main_shell.dart';

class B2BAuthScreen extends StatefulWidget {
  const B2BAuthScreen({super.key});

  @override
  State<B2BAuthScreen> createState() => _B2BAuthScreenState();
}

class _B2BAuthScreenState extends State<B2BAuthScreen> {
  bool isLogin = true;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();

  void _handleAuth() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isLogin ? "Welcome back!" : "Account created!"),
          backgroundColor: AppTheme.primaryGreen,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainShell()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔥 HEADER
            Container(
              height: 280,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppTheme.primaryGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🔥 LOGO IMAGE
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "My Business",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  Text(
                    isLogin ? "Business Login" : "Partner Registration",
                    style: const TextStyle(color: AppTheme.accentGold),
                  ),
                ],
              ),
            ),

            // 🔥 FORM    Hello i'm sanju
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!isLogin) ...[
                      _buildInput(
                        "Business Name (Optional)",
                        Icons.store,
                        _nameController,
                        false,
                      ),
                      const SizedBox(height: 15),
                    ],

                    _buildInput(
                      "Email or Mobile Number",
                      Icons.person_outline,
                      _emailController,
                      true,
                    ),

                    const SizedBox(height: 15),

                    _buildInput(
                      "Password",
                      Icons.lock_outline,
                      _passController,
                      true,
                      isPass: true,
                    ),

                    const SizedBox(height: 30),

                    // 🔥 BUTTON
                    ElevatedButton(
                      onPressed: _handleAuth,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        isLogin ? "LOGIN" : "CREATE ACCOUNT",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔁 SWITCH
                    TextButton(
                      onPressed: () => setState(() => isLogin = !isLogin),
                      child: Text(
                        isLogin
                            ? "New partner? Register Business"
                            : "Already have an account? Login",
                        style: const TextStyle(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 INPUT FIELD
  Widget _buildInput(
    String hint,
    IconData icon,
    TextEditingController controller,
    bool required, {
    bool isPass = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPass,
      validator: (val) {
        if (required && (val == null || val.isEmpty)) {
          return "This field is required";
        }
        if (isPass && val!.length < 6) {
          return "Password too short";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.primaryGreen),
        filled: true,
        fillColor: AppTheme.softBackground.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
