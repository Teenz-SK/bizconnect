import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/floating_blob.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fade = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scale = Tween(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _controller.forward();

    /// 🔥 NAVIGATION (UNCHANGED)
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => const OnboardingScreen(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulse.dispose();
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

          /// 🔥 HEARTBEAT + FLOATING BLOBS
          AnimatedBuilder(
            animation: _pulse,
            builder: (context, child) {
              double scale = 1 + (_pulse.value * 0.08);

              return Stack(
                children: [
                  Positioned(
                    top: -140,
                    right: -120,
                    child: Transform.scale(
                      scale: scale,
                      child: const FloatingBlob(
                        size: 420,
                        color: AppTheme.primaryGreen,
                        duration: Duration(seconds: 6),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -160,
                    left: -120,
                    child: Transform.scale(
                      scale: scale,
                      child: const FloatingBlob(
                        size: 400,
                        color: AppTheme.accentBrown,
                        duration: Duration(seconds: 8),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          /// 🔥 CENTER CONTENT
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// 💎 LOGO (ENHANCED DEPTH)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.9),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryGreen.withValues(
                              alpha: 0.15,
                            ),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/logo1.png',
                        width: 160,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// 🔥 BRAND TEXT (GRADIENT)
                    // ShaderMask(
                    //   shaderCallback: (bounds) => const LinearGradient(
                    //     colors: [AppTheme.primaryEmerald, AppTheme.emeraldDark],
                    //   ).createShader(bounds),
                    //   child: const Text(
                    //     "My Business",
                    //     style: TextStyle(
                    //       fontSize: 22,
                    //       fontWeight: FontWeight.w800,
                    //       color: Colors.white,
                    //       letterSpacing: 0.5,
                    //     ),
                    //   ),
                    // ),
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
