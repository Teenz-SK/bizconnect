import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../models/business_model.dart';
import '../services/app_state.dart';
import '../services/user_service.dart';
import '../widgets/post_card.dart';
import '../utils/app_theme.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  String? userCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserCategory();
  }

  Future<void> _loadUserCategory() async {
    userCategory = await UserService().getUserCategory();

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 GET LIVE DATA FROM PROVIDER
    final appState = Provider.of<AppState>(context);
    final allBusinesses = appState.businesses;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text("Networking Feed"), elevation: 0),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : allBusinesses.isEmpty
          ? const Center(
              child: Text(
                "No businesses yet 🚀\nBe the first to register!",
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: allBusinesses.length,
              itemBuilder: (context, index) {
                final biz = allBusinesses[index];

                // 🔥 CONVERT BUSINESS → POST
                final post = Post(
                  id: biz.id,
                  businessId: biz.id,
                  businessName: biz.name,
                  category: biz.category,
                  title: "New Business Joined! 🎉",
                  content: biz.about.isNotEmpty
                      ? biz.about
                      : "We are now live on My Business!",
                  timestamp: DateTime.now(),
                );

                return PostCard(
                  post: post,
                  isRelevant: biz.category == userCategory,
                );
              },
            ),
    );
  }
}
