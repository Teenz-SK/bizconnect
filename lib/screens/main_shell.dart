import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'add_business_screen.dart';
import 'feed_screen.dart';
import '../utils/app_theme.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // 🔥 FUNCTION TO SWITCH TAB
  void _switchToHome() {
    setState(() => _currentIndex = 0);
  }

  @override
  Widget build(BuildContext context) {

    // 🔥 SCREENS WITH CALLBACK
    final List<Widget> _screens = [
      const HomeScreen(),
      AddBusinessScreen(onSuccess: _switchToHome), // ✅ PASS CALLBACK
      const FeedScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // 🔥 MODERN BOTTOM NAV
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: AppTheme.primaryIndigo,
          unselectedItemColor: AppTheme.textSecondary,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: "List Biz",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dynamic_feed),
              label: "Feed",
            ),
          ],
        ),
      ),
    );
  }
}