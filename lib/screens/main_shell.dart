import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'feed_screen.dart';
import 'registration_screen.dart';
import '../utils/app_theme.dart';
import '../services/user_service.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final UserService _userService = UserService();

  bool isRegistered = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkRegistration();
  }

  // 🔥 CHECK REGISTRATION STATUS
  Future<void> _checkRegistration() async {
    final registered = await _userService.isRegistered();

    if (!mounted) return;

    setState(() {
      isRegistered = registered;
      isLoading = false;
    });
  }

  // 🔥 AFTER REGISTRATION → GO HOME
  void _onRegistrationSuccess() async {
    await _userService.setRegistered();

    setState(() {
      isRegistered = true;
      _currentIndex = 0; // 🔥 redirect to Home
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 🔥 DYNAMIC TAB SWITCHING
    final List<Widget> _tabs = [
      const HomeScreen(),      // 📊 Discovery
      const FeedScreen(),      // 📰 Feed
      isRegistered
          ? const _MyBusinessDashboard() // 🔥 FUTURE DASHBOARD
          : RegistrationScreen(),        // 🔥 SHOW REGISTER
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),

      // 🔥 PREMIUM NAVBAR
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
          selectedItemColor: AppTheme.primaryGreen,
          unselectedItemColor: AppTheme.textSecondary,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: "Directory",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dynamic_feed),
              label: "Feed",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: "My Biz",
            ),
          ],
        ),
      ),
    );
  }
}

// 🔥 TEMP DASHBOARD (CAN UPGRADE LATER)
class _MyBusinessDashboard extends StatelessWidget {
  const _MyBusinessDashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBackground,
      body: Center(
        child: Text(
          "Your Business Dashboard 🚀",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryGreen,
          ),
        ),
      ),
    );
  }
}