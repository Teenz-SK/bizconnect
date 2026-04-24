import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/app_theme.dart';
import '../widgets/floating_blob.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  double pageOffset = 0;
  int currentIndex = 0;

  final List<Map<String, dynamic>> slides = [
    {
      "title": "Connect Businesses",
      "desc": "Connect your business with customers instantly",
      "lottie": "assets/lottie/connect.json",
    },
    {
      "title": "Grow Faster",
      "desc": "Promote and expand your business with smart networking",
      "lottie": "assets/lottie/growth.json",
    },
    {
      "title": "Smart Insights",
      "desc": "Track growth and reach the right audience effectively",
      "lottie": "assets/lottie/insights.json",
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        pageOffset = _controller.page ?? 0;
      });
    });
  }

  void _next() {
    if (currentIndex == slides.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBackground,
      body: Stack(
        children: [
          // 🔥 PARALLAX FLOATING BLOBS
          Positioned(
            top: -120 + (pageOffset * -20),
            right: -100 + (pageOffset * 10),
            child: const FloatingBlob(
              size: 400,
              color: AppTheme.primaryGreen,
              duration: Duration(seconds: 6),
              parallaxFactor: 1.2,
            ),
          ),

          Positioned(
            bottom: -140 + (pageOffset * 30),
            left: -100 + (pageOffset * -10),
            child: const FloatingBlob(
              size: 400,
              color: AppTheme.accentYellow,
              duration: Duration(seconds: 8),
              parallaxFactor: 1.5,
            ),
          ),

          Positioned(
            top: 200 + (pageOffset * 40),
            left: -80,
            child: const FloatingBlob(
              size: 260,
              color: AppTheme.primaryGreen,
              duration: Duration(seconds: 10),
              parallaxFactor: 2,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // 🔹 SKIP
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _next,
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // 🔹 PAGE VIEW
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: slides.length,
                    onPageChanged: (i) => currentIndex = i,
                    itemBuilder: (context, index) {
                      final slide = slides[index];

                      final scale = (1 - (pageOffset - index).abs()).clamp(
                        0.85,
                        1.0,
                      );

                      return Transform.scale(
                        scale: scale,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // 🔥 GLASS HERO CARD
                              Container(
                                height: 280,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: Colors.white.withValues(alpha: 0.8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 30,
                                      offset: const Offset(0, 20),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Lottie.asset(
                                    slide["lottie"],
                                    height: 180,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 50),

                              Text(
                                slide["title"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.textPrimary,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                slide["desc"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 🔹 BOTTOM
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      // 🔥 DOTS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          slides.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: currentIndex == index ? 26 : 8,
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? AppTheme.primaryGreen
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 🔥 BUTTON
                      GestureDetector(
                        onTap: _next,
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryGreen,
                                AppTheme.primaryGreen.withValues(alpha: 0.85),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryGreen.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              currentIndex == slides.length - 1
                                  ? "Get Started"
                                  : "Next",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
