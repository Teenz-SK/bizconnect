import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/data_service.dart';
import '../services/user_service.dart';
import '../widgets/post_card.dart';
import '../utils/app_theme.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final DataService _dataService = DataService();
  String? userCategory;
  List<Post> allPosts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  void _loadFeed() async {
    userCategory = await UserService().getUserCategory();
    final posts = await _dataService.getPosts();

    if (!mounted) return; // ✅ IMPORTANT FIX

    posts.sort((a, b) {
      if (a.category == userCategory && b.category != userCategory) return -1;
      if (a.category != userCategory && b.category == userCategory) return 1;
      return b.timestamp.compareTo(a.timestamp);
    });

    setState(() {
      allPosts = posts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text("Networking Feed"), elevation: 0),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: allPosts.length,
              itemBuilder: (context, index) {
                final post = allPosts[index];
                return PostCard(
                  post: post,
                  isRelevant: post.category == userCategory,
                );
              },
            ),
    );
  }
}
