import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../models/business_model.dart';
import '../screens/business_detail_screen.dart';
import '../services/app_state.dart';
import '../utils/app_theme.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final bool isRelevant;

  const PostCard({super.key, required this.post, this.isRelevant = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        // 🔥 FIX: removed const-related issue (already dynamic)
        border: isRelevant
            ? Border.all(
                color: AppTheme.primaryIndigo.withValues(alpha: 0.3),
                width: 1,
              )
            : null,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 HEADER
          Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    AppTheme.primaryIndigo.withValues(alpha: 0.1),
                child: Text(
                  post.businessName[0],
                  // ❌ removed const here
                  style: TextStyle(
                    color: AppTheme.primaryIndigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.businessName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${post.category} • ${DateFormat.jm().format(post.timestamp)}",
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              if (isRelevant)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryIndigo,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "MATCH",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // 🔹 TITLE
          Text(
            post.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 8),

          // 🔹 CONTENT
          Text(
            post.content,
            // ❌ removed const here
            style: TextStyle(
              color: AppTheme.textPrimary,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 16),

          const Divider(),

          // 🔥 NAVIGATION
          TextButton(
            onPressed: () {
              final appState =
                  Provider.of<AppState>(context, listen: false);

              final business = appState.businesses.firstWhere(
                (b) => b.id == post.businessId,
                orElse: () => Business(
                  id: post.businessId,
                  name: post.businessName,
                  category: post.category,
                  description:
                      "Details for ${post.businessName}...",
                  logoUrl: post.businessName[0],
                  mobile: "Contact Info", // 🔥 FIXED FIELD
                  isVerified: false,
                ),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BusinessDetailScreen(business: business),
                ),
              );
            },
            child: Text( // ❌ removed const here
              "View Business Profile",
              style: TextStyle(
                color: AppTheme.primaryIndigo,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}