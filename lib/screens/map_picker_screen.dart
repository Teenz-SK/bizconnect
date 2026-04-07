import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  String selectedAddress = "Fetching current location...";

  @override
  void initState() {
    super.initState();
    // Simulate a delay for GPS
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => selectedAddress = "Industrial Hub, Sector 5, Plot 102");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Business Location")),
      body: Stack(
        children: [
          // MOCK MAP BACKGROUND
          Container(
            color: Colors.grey.shade200,
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Icon(Icons.map_outlined, size: 100, color: Colors.grey),
            ),
          ),
          // CENTER PIN ICON
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Icon(Icons.location_on, color: Colors.red, size: 50),
            ),
          ),
          // BOTTOM ADDRESS BOX
          Positioned(
            bottom: 30, left: 20, right: 20,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.my_location, color: AppTheme.primaryGreen),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(selectedAddress, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, selectedAddress),
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
                      child: const Text("CONFIRM THIS LOCATION"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}