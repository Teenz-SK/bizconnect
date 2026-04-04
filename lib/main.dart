import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bizconnect/screens/main_shell.dart';
import 'utils/app_theme.dart';
import 'services/user_service.dart';
import 'screens/onboarding_screen.dart';

// 🔥 GLOBAL STATE
import 'services/app_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState()..initialize(), // ✅ IMPORTANT
      child: const BizConnectApp(),
    ),
  );
}

class BizConnectApp extends StatelessWidget {
  const BizConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BizConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

// 🚀 SPLASH SCREEN (SMART NAVIGATION)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final bool onboarded =
        await UserService().hasSelectedCategory();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            onboarded ? const MainShell() : const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:
            const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hub, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "BizConnect",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}