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

  Future<void> _checkRegistration() async {
    final registered = await _userService.isRegistered();

    if (!mounted) return;

    setState(() {
      isRegistered = registered;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final List<Widget> tabs = [
      const HomeScreen(),
      const FeedScreen(),
      isRegistered
          ? const _MyBusinessDashboard()
          : const RegistrationScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppTheme.primaryGreen,
        unselectedItemColor: AppTheme.textSecondary,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), label: "Directory"),
          BottomNavigationBarItem(
              icon: Icon(Icons.dynamic_feed), label: "Feed"),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: "My Biz"),
        ],
      ),
    );
  }
}

class _MyBusinessDashboard extends StatelessWidget {
  const _MyBusinessDashboard();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Your Business Dashboard 🚀"),
    );
  }
}