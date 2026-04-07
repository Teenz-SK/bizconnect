import 'package:flutter/material.dart';
import '../models/business_model.dart';
import '../utils/app_theme.dart';

class B2BCard extends StatelessWidget {
  final B2BBusiness business;
  final VoidCallback? onTap;

  const B2BCard({
    super.key,
    required this.business,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 LOGO
            CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
              child: Text(
                business.logoUrl,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // 🔹 DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔥 NAME + VERIFIED
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          business.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (business.isVerified)
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 18,
                        ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // 🔥 CATEGORY (FIXED ✅)
                  Text(
                    "${business.category} • ${business.subcategory}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 🔥 YEARS
                  Text(
                    "Since ${business.startupYear}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primaryGreen,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // 🔥 TIMINGS
                  Text(
                    "⏰ ${business.openTime} - ${business.closeTime}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // 🔹 LOCATION
                  Text(
                    business.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}