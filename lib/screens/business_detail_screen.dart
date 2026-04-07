import 'package:flutter/material.dart';
import '../models/business_model.dart';
import '../utils/app_theme.dart';
import '../widgets/gradient_button.dart';

class BusinessDetailScreen extends StatelessWidget {
  final Business business;

  const BusinessDetailScreen({
    super.key,
    required this.business,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBackground,
      body: CustomScrollView(
        slivers: [
          // 🔥 PREMIUM HEADER
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppTheme.primaryGreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryGreen,
                      Color(0xFF066129),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    CircleAvatar(
                      radius: 45,
                      backgroundColor: AppTheme.accentGold,
                      child: Text(
                        business.name.isNotEmpty
                            ? business.name[0]
                            : "B",
                        style: const TextStyle(
                          fontSize: 40,
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      business.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      business.category,
                      style: const TextStyle(
                        color: AppTheme.accentGold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔥 BODY
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // 🔹 BUSINESS PROFILE CARD
                  _buildDetailCard(
                    "Business Profile",
                    [
                      _buildInfoTile(
                        Icons.history,
                        "Established",
                        business.startupYear,
                      ),
                      _buildInfoTile(
                        Icons.category_outlined,
                        "Industry",
                        business.subcategory,
                      ),
                      _buildInfoTile(
                        Icons.access_time,
                        "Operating Hours",
                        "${business.openTime} - ${business.closeTime}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 🔹 CONTACT CARD
                  _buildDetailCard(
                    "Contact & Location",
                    [
                      _buildInfoTile(
                        Icons.phone_android,
                        "Mobile",
                        business.mobile,
                      ),
                      _buildInfoTile(
                        Icons.email_outlined,
                        "Email",
                        business.email,
                      ),
                      _buildInfoTile(
                        Icons.location_on_outlined,
                        "Address",
                        business.address,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 🔥 CTA BUTTONS
                  GradientButton(
                    text: "Connect via WhatsApp",
                    onPressed: () {},
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.call),
                    label: const Text("INQUIRY NOW"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      minimumSize: const Size(double.infinity, 52),
                    ),
                  ),

                  const SizedBox(height: 12),

                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.directions),
                    label: const Text("VIEW ON MAP"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryGreen,
                      side: const BorderSide(
                        color: AppTheme.primaryGreen,
                      ),
                      minimumSize: const Size(double.infinity, 52),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 CARD
  Widget _buildDetailCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryGreen,
              fontSize: 16,
            ),
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  // 🔹 INFO TILE
  Widget _buildInfoTile(
      IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                value.isEmpty ? "-" : value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}