import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/business_model.dart';
import '../services/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/categories_data.dart';
import '../widgets/b2b_card.dart';
import 'business_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = "All";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 🔍 FILTER LOGIC (FIXED ✅)
    final List<B2BBusiness> filteredBusinesses =
        appState.b2bBusinesses.where((business) {
      final matchesSearch =
          business.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              business.subcategory
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());

      final matchesCategory = selectedFilter == "All" ||
          business.category.toLowerCase() ==
              selectedFilter.toLowerCase(); // ✅ FIXED

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          // 🔥 HEADER
          SliverAppBar(
            expandedHeight: 140,
            floating: true,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "BizConnect B2B",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryGreen,
                      Color(0xFF066129),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),

          // 🔍 SEARCH + FILTER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    onChanged: (val) =>
                        setState(() => searchQuery = val),
                    decoration: InputDecoration(
                      hintText: "Search suppliers, manufacturers...",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppTheme.primaryGreen,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCategoryChips(),
                ],
              ),
            ),
          ),

          // 📊 RESULT COUNT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${filteredBusinesses.length} Businesses Found",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 10)),

          // 📋 LIST
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final business = filteredBusinesses[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: B2BCard(
                      business: business,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BusinessDetailScreen(
                              business: business,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                childCount: filteredBusinesses.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  // 🏷️ CATEGORY CHIPS
  Widget _buildCategoryChips() {
    final categories = ["All", ...CategoriesData.b2bCategories.keys];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedFilter == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) {
                setState(() => selectedFilter = category);
              },
              selectedColor: AppTheme.accentGold,
              checkmarkColor: AppTheme.primaryGreen,
              labelStyle: TextStyle(
                color: isSelected
                    ? AppTheme.primaryGreen
                    : Colors.grey,
                fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                side: BorderSide(
                  color: isSelected
                      ? AppTheme.accentGold
                      : Colors.grey.shade300,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}