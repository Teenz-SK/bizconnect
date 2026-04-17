import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class PromotionCard extends StatelessWidget {
  final String title;
  final String desc;
  final bool isFeatured;
  final VoidCallback onTap;

  const PromotionCard({
    super.key,
    required this.title,
    required this.desc,
    this.isFeatured = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // ✅ CLEAN SURFACE
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.cardShadow,
        ),

        child: Stack(
          children: [
            // ⭐ FEATURED BADGE
            if (isFeatured)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Featured",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

            Row(
              children: [
                // 🟡 SOFT YELLOW ICON BOX (ACCENT ONLY)
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: AppTheme.accentYellow.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.business_rounded,
                    color: AppTheme.primaryGreen,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 14),

                // TEXT CONTENT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: AppTheme.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // 🔥 SMALL ACTION ROW
                      Row(
                        children: [
                          // CATEGORY TAG
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.accentYellow.withValues(
                                alpha: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "B2B",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryGreen,
                              ),
                            ),
                          ),

                          const Spacer(),

                          // 👉 VIEW BUTTON
                          GestureDetector(
                            onTap: onTap,
                            child: const Row(
                              children: [
                                Text(
                                  "View",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.primaryGreen,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 12,
                                  color: AppTheme.primaryGreen,
                                ),
                              ],
                            ),
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
    );
  }
}
