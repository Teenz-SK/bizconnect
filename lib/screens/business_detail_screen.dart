import 'package:flutter/material.dart';
import '../models/business_model.dart';
import '../utils/app_theme.dart';
import '../widgets/gradient_button.dart';

class BusinessDetailScreen extends StatelessWidget {
  final Business business;
  const BusinessDetailScreen({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Premium Header with Hero Animation
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text(
                      business.logoUrl,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.primaryIndigo),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(business.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryIndigo.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(business.category, style: const TextStyle(color: AppTheme.primaryIndigo, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      if (business.isVerified)
                        const Icon(Icons.verified, color: AppTheme.secondaryCyan, size: 32),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text("About Us", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(business.description, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 16, height: 1.5)),
                  const SizedBox(height: 24),
                  
                  // Contact Info Section
                  _buildContactTile(Icons.location_on_outlined, "Location", business.location),
                  _buildContactTile(Icons.phone_outlined, "Phone", business.contact),
                  
                  const SizedBox(height: 40),
                  
                  // Primary CTA
                  GradientButton(
                    text: "Connect via WhatsApp", 
                    onPressed: () {
                      // Logic for launching URL or WhatsApp
                    }
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      side: const BorderSide(color: AppTheme.primaryIndigo),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Save to Favorites", style: TextStyle(color: AppTheme.primaryIndigo)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContactTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.textSecondary, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            ],
          )
        ],
      ),
    );
  }
}