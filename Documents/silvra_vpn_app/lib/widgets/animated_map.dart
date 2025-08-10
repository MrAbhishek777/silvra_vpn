// lib/widgets/animated_map.dart
import 'package:flutter/material.dart';

class AnimatedMap extends StatefulWidget {
  final bool isConnected;
  final String connectedCountry;
  final double scaleWhenConnected;
  final BoxDecoration? decoration;

  const AnimatedMap({
    super.key,
    required this.isConnected,
    required this.connectedCountry,
    this.scaleWhenConnected = 1.08,
    this.decoration,
  });

  @override
  State<AnimatedMap> createState() => _AnimatedMapState();
}

class _AnimatedMapState extends State<AnimatedMap> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  // Basic fake coordinates for a few countries (relative offsets 0..1)
  final Map<String, Offset> _countryOffsets = {
    'India': const Offset(0.7, 0.68),
    'USA': const Offset(0.18, 0.45),
    'Singapore': const Offset(0.82, 0.75),
    'Netherlands': const Offset(0.48, 0.4),
    'Brazil': const Offset(0.32, 0.6),
    'UK': const Offset(0.45, 0.36),
    'Canada': const Offset(0.22, 0.28),
    // fallback at center
  };

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    if (widget.isConnected) _pulseController.repeat();
  }

  @override
  void didUpdateWidget(covariant AnimatedMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isConnected && !_pulseController.isAnimating) {
      _pulseController.repeat();
    } else if (!widget.isConnected && _pulseController.isAnimating) {
      _pulseController.stop();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Offset _getOffsetForCountry(String country, Size size) {
    final off = _countryOffsets[country] ?? const Offset(0.5, 0.5);
    return Offset(off.dx * size.width, off.dy * size.height);
  }

  @override
  Widget build(BuildContext context) {
    final scale = widget.isConnected ? widget.scaleWhenConnected : 1.0;

    return LayoutBuilder(builder: (context, constraints) {
      final size = Size(constraints.maxWidth, constraints.maxHeight);

      return Center(
        child: AnimatedScale(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
          scale: scale,
          child: Stack(
            children: [
              // Map background - you must add assets/images/world_map.png to your project
              Container(
                width: size.width,
                height: size.height,
                decoration: widget.decoration ??
                    BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/world_map.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
              ),

              // Pin & pulse
              Positioned.fill(
                child: Builder(builder: (ctx) {
                  final pinOffset = _getOffsetForCountry(widget.connectedCountry, size);
                  return AnimatedBuilder(
                    animation: _pulseController,
                    builder: (ctx, child) {
                      final animVal = (_pulseController.value);
                      final pulseScale = 0.7 + (animVal * 0.6);
                      final pulseOpacity = (1.0 - animVal).clamp(0.0, 1.0);

                      return Stack(
                        children: [
                          // Pulse
                          Positioned(
                            left: pinOffset.dx - 22,
                            top: pinOffset.dy - 22,
                            child: Opacity(
                              opacity: widget.isConnected ? pulseOpacity : 0.0,
                              child: Container(
                                width: 44 * pulseScale,
                                height: 44 * pulseScale,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.18),
                                ),
                              ),
                            ),
                          ),

                          // Pin icon
                          Positioned(
                            left: pinOffset.dx - 12,
                            top: pinOffset.dy - 24,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 6, offset: const Offset(0, 2))
                                ],
                              ),
                              child: const Icon(Icons.location_on, size: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
