import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/business_model.dart';
import '../services/app_state.dart';
import '../services/user_service.dart';
import '../widgets/business_card.dart';
import 'business_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserService _userService = UserService();

  String? userCategory;

  @override
  void initState() {
    super.initState();
    _loadUserCategory();
  }

  // 🔥 LOAD CATEGORY OUTSIDE BUILD (IMPORTANT FIX)
  void _loadUserCategory() async {
    final category = await _userService.getUserCategory();

    if (!mounted) return;

    setState(() {
      userCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    // ✅ HANDLE LOADING STATE PROPERLY
    if (appState.isLoading || userCategory == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 🔥 SPLIT DATA
    final List<Business> relevantBusinesses = appState.businesses
        .where((b) => b.category == userCategory)
        .toList();

    final List<Business> otherBusinesses = appState.businesses
        .where((b) => b.category != userCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("BizConnect"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),

      // 🔥 PULL TO REFRESH ADDED
      body: RefreshIndicator(
        onRefresh: () => appState.initialize(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 🔹 HEADER
            Text(
              "Welcome back 👋",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Text(
              "Find your next partner",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // 🔥 SECTION 1: RELEVANT
            if (relevantBusinesses.isNotEmpty) ...[
              _buildSectionHeader("Recommended for $userCategory"),
              const SizedBox(height: 12),

              ...relevantBusinesses.map(
                (b) => BusinessCard(
                  business: b,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BusinessDetailScreen(business: b),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],

            // 🔥 SECTION 2: EXPLORE
            _buildSectionHeader("Explore Other Industries"),
            const SizedBox(height: 12),

            ...otherBusinesses.map(
              (b) => BusinessCard(
                business: b,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BusinessDetailScreen(business: b),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 SECTION HEADER
  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("See all"),
        ),
      ],
    );
  }
}