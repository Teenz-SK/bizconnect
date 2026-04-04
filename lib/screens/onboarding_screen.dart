import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../widgets/gradient_button.dart';
import '../utils/app_theme.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? selectedCategory;

  final List<String> categories = [
    "Technology",
    "Manufacturing",
    "Healthcare",
    "Retail",
    "Food & Beverage",
    "Professional Services",
    "Real Estate",
    "Education",
    "Logistics"
  ];

  // 🚀 FINAL ONBOARDING ACTION
  void _finishOnboarding() async {
    if (selectedCategory != null) {
      await UserService().saveUserCategory(selectedCategory!);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔥 HEADER
              const Text(
                "Welcome to\nBizConnect 🚀",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "Select a category to personalize your networking feed.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 30),

              // 🔥 CATEGORY GRID
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.6,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.primaryIndigo
                              : AppTheme.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.primaryIndigo
                                : Colors.grey.shade300,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: AppTheme.primaryIndigo
                                    .withOpacity(0.25),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          category,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppTheme.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // 🔥 BUTTON
              GradientButton(
                text: "Get Started",
                onPressed:
                    selectedCategory == null ? () {} : _finishOnboarding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}