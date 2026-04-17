import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/app_state.dart';
import 'utils/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState()..initialize(), // ✅ KEEP THIS
      child: const MyBusinessApp(),
    ),
  );
}

class MyBusinessApp extends StatelessWidget {
  const MyBusinessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Business',

      // 🔥 USE UPDATED THEME
      theme: AppTheme.lightTheme, // ✅ correct

      home: const SplashScreen(),
    );
  }
}