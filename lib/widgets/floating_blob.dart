import 'dart:math';
import 'package:flutter/material.dart';

class FloatingBlob extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final double parallaxFactor;

  const FloatingBlob({
    super.key,
    required this.size,
    required this.color,
    required this.duration,
    this.parallaxFactor = 1,
  });

  @override
  State<FloatingBlob> createState() => _FloatingBlobState();
}

class _FloatingBlobState extends State<FloatingBlob>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        final t = controller.value;

        final dx = sin(t * 2 * pi) * 20 * widget.parallaxFactor;
        final dy = cos(t * 2 * pi) * 20 * widget.parallaxFactor;

        return Transform.translate(
          offset: Offset(dx, dy),
          child: child,
        );
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              widget.color.withValues(alpha: 0.25),
              widget.color.withValues(alpha: 0.05),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}