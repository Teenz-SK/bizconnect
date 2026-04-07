import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../models/business_model.dart';

class ProfileDashboard extends StatelessWidget {
  final B2BBusiness business;
  const ProfileDashboard({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBackground,
      appBar: AppBar(
        title: const Text("Business Profile"),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppTheme.primaryGreen,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.accentGold,
                    child: Icon(Icons.business_center, size: 50, color: AppTheme.primaryGreen),
                  ),
                  const SizedBox(height: 16),
                  Text(business.name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(business.category, style: const TextStyle(color: AppTheme.accentGold, fontSize: 16)),
                ],
              ),
            ),
            
            // Stats Row (Enterprise Feel)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  _buildStatCard("Est.", business.startupYear),
                  const SizedBox(width: 12),
                  _buildStatCard("Status", "Verified ✅"),
                ],
              ),
            ),

            // Detailed Info Cards
            _buildInfoSection("Contact Details", [
              ListTile(leading: const Icon(Icons.phone), title: const Text("Mobile"), subtitle: Text(business.mobile)),
              ListTile(leading: const Icon(Icons.email), title: const Text("Email"), subtitle: Text(business.email)),
            ]),

            _buildInfoSection("Operations", [
              ListTile(leading: const Icon(Icons.access_time), title: const Text("Timings"), subtitle: Text("${business.openTime} - ${business.closeTime}")),
              ListTile(leading: const Icon(Icons.location_on), title: const Text("Address"), subtitle: Text(business.address)),
            ]),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryGreen, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
          ),
          ...children,
        ],
      ),
    );
  }
}