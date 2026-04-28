import 'dart:ui';
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

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _controller = PageController();
  double pageOffset = 0;
  int currentIndex = 0;

  late AnimationController _pulse;
  late AnimationController _fade;

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

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _fade = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _controller.addListener(() {
      setState(() {
        pageOffset = _controller.page ?? 0;
      });
    });
  }

  void _next() async {
    await _fade.reverse();

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
      _fade.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    _fade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBackground,
      body: Stack(
        children: [
          /// 🔥 BACKGROUND BLUR LAYER
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: Container(color: Colors.white.withValues(alpha: 0.05)),
            ),
          ),

          /// 🔥 PARALLAX + HEARTBEAT BLOBS
          AnimatedBuilder(
            animation: _pulse,
            builder: (context, child) {
              double scale = 1 + (_pulse.value * 0.08);

              return Stack(
                children: [
                  Positioned(
                    top: -150 + (pageOffset * -30),
                    right: -120 + (pageOffset * 20),
                    child: Transform.scale(
                      scale: scale,
                      child: const FloatingBlob(
                        size: 480,
                        color: AppTheme.primaryGreen,
                        duration: Duration(seconds: 6),
                        parallaxFactor: 1.5,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -180 + (pageOffset * 40),
                    left: -140 + (pageOffset * -20),
                    child: Transform.scale(
                      scale: scale,
                      child: const FloatingBlob(
                        size: 440,
                        color: AppTheme.accentBrown,
                        duration: Duration(seconds: 8),
                        parallaxFactor: 2,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          SafeArea(
            child: FadeTransition(
              opacity: _fade,
              child: Column(
                children: [
                  /// 🔹 SKIP (ANIMATED)
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

                  /// 🔹 PAGE VIEW
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: slides.length,
                      onPageChanged: (i) => setState(() => currentIndex = i),
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
                                /// 🔥 GLASS CARD (REAL)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(32),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 15,
                                      sigmaY: 15,
                                    ),
                                    child: Container(
                                      height: 280,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white.withValues(alpha: 0.7),
                                            Colors.white.withValues(alpha: 0.4),
                                          ],
                                        ),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.3,
                                          ),
                                        ),
                                        boxShadow: AppTheme.cardShadow,
                                      ),
                                      child: Center(
                                        child: Lottie.asset(
                                          slide["lottie"],
                                          height: 180,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 40),

                                /// 🔥 GRADIENT TITLE
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                        colors: [
                                          AppTheme.primaryEmerald,
                                          AppTheme.emeraldDark,
                                        ],
                                      ).createShader(bounds),
                                  child: Text(
                                    slide["title"],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
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

                  /// 🔹 BOTTOM
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        /// 🔥 PREMIUM DOTS
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
                                gradient: currentIndex == index
                                    ? const LinearGradient(
                                        colors: [
                                          AppTheme.primaryEmerald,
                                          AppTheme.emeraldDark,
                                        ],
                                      )
                                    : null,
                                color: currentIndex == index
                                    ? null
                                    : AppTheme.greyMedium,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// 🔥 PREMIUM BUTTON
                        GestureDetector(
                          onTap: _next,
                          child: Container(
                            height: 56,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF10B981), Color(0xFF059669)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF10B981,
                                  ).withValues(alpha: 0.35),
                                  blurRadius: 25,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Text(
                                  currentIndex == slides.length - 1
                                      ? "Get Started"
                                      : "Next",
                                  key: ValueKey(currentIndex),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
          ),
        ],
      ),
    );
  }
}
