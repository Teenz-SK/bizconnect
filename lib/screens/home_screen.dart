import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/business_model.dart';
import '../services/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/categories_data.dart';
import '../widgets/promotion_card.dart';
import 'business_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String selectedFilter = "All";
  String searchQuery = "";

  late AnimationController shimmerController;

  // 🎯 RADIUS SYSTEM
  final double radiusSmall = 12;
  final double radiusMedium = 16;
  final double radiusLarge = 24;

  @override
  void initState() {
    super.initState();
    shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final filteredBusinesses = appState.b2bBusinesses.where((business) {
      final matchesSearch =
          business.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          business.subcategory.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );

      final matchesCategory =
          selectedFilter == "All" ||
          business.category.toLowerCase() == selectedFilter.toLowerCase();

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.softBackground,

      /// 🔥 GLASS APPBAR (UPGRADED)
      appBar: AppBar(
        title: const Text("My Business"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.textPrimary,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.white.withValues(alpha: 0.6)),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// 🔥 HERO (FINAL PREMIUM)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedBuilder(
                animation: shimmerController,
                builder: (context, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLarge),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.greyLight,
                              AppTheme.lightBrown.withValues(alpha: 0.15),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(radiusLarge),
                          boxShadow: AppTheme.cardShadow,
                        ),
                        child: Stack(
                          children: [
                            /// ✨ DIAGONAL SHIMMER (FIXED)
                            Positioned.fill(
                              child: Opacity(
                                opacity: 0.25,
                                child: Transform.translate(
                                  offset: Offset(
                                    200 * shimmerController.value,
                                    200 * shimmerController.value,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.transparent,
                                          Colors.white.withValues(alpha: 0.25),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppTheme.accentBrown.withValues(
                                      alpha: 0.25,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      radiusMedium,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.trending_up_rounded,
                                    color: AppTheme.accentBrown,
                                  ),
                                ),

                                const SizedBox(width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Grow Faster 🚀",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      const Text(
                                        "Promote your business and reach more customers.",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      Row(
                                        children: [
                                          Flexible(
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: const Text("Get Featured"),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 14,
                                            color: AppTheme.accentBrown,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// 🔥 WOW CARD
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _HoverScale(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.accentBrown, AppTheme.lightBrown],
                    ),
                    borderRadius: BorderRadius.circular(radiusLarge),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.workspace_premium_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Upgrade to Premium & Boost Visibility",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          /// 🔍 SEARCH (UPGRADED)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (val) => setState(() => searchQuery = val),
                decoration: InputDecoration(
                  hintText: "Search businesses...",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppTheme.accentBrown,
                  ),
                  filled: true,
                  fillColor: AppTheme.greyLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radiusLarge),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          /// FILTER
          SliverToBoxAdapter(child: _buildCategoryChips()),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          const SliverToBoxAdapter(child: Divider()),

          /// LIST
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final business = filteredBusinesses[index];

                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 400 + index * 120),
                  curve: Curves.easeOutCubic,
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: PromotionCard(business: business, index: index),
                );
              }, childCount: filteredBusinesses.length),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = ["All", ...CategoriesData.b2bCategories.keys];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
              selectedColor: AppTheme.accentBrown.withValues(alpha: 0.35),
              backgroundColor: AppTheme.greyLight,
            ),
          );
        },
      ),
    );
  }
}

/// 🔥 HOVER SCALE
class _HoverScale extends StatefulWidget {
  final Widget child;
  const _HoverScale({required this.child});

  @override
  State<_HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<_HoverScale> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => scale = 1.03),
      onExit: (_) => setState(() => scale = 1),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}
