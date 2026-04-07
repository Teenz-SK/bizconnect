import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 🔥 CORE
import 'services/app_state.dart';
import 'utils/app_theme.dart';

// 🔥 SCREENS
import 'screens/splash_screen.dart';

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

      // 🔥 USE B2B THEME
      theme: AppTheme.lightTheme,

      // 🔥 START FROM SPLASH
      home: const SplashScreen(),
    );
  }
}