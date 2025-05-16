import 'dart:math' as math;

import 'package:daily_mood/src/common/extensions/color_extension.dart';
import 'package:daily_mood/src/features/splash/controller/splash_screen_controller.dart';
import 'package:daily_mood/src/features/splash/model/particle_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashScreenController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: controller.backgroundController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.lerp(
                        Colors.black,
                        AppColors.softLavender,
                        controller.backgroundAnimation.value,
                      )!,
                      Color.lerp(
                        Colors.black,
                        AppColors.warmCoral,
                        controller.backgroundAnimation.value,
                      )!,
                    ],
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: controller.particlesController,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(
                  particles: controller.particles,
                  animation: controller.particlesController.value,
                ),
                size: Size.infinite,
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: controller.logoController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: controller.logoRotationAnimation.value,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: AssetImage("assets/img/logo.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 40),
                SlideTransition(
                  position: controller.textslideAnimation,
                  child: FadeTransition(
                    opacity: controller.textOpcityAnimation,
                    child: Container(
                      width: 350,
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.warmCoral.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Text(
                            "Daily Mood Journal",
                            style: TextStyle(
                              fontSize: 29,
                              fontFamily: '',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ), // TextStyle
                          ),
                          SizedBox(height: 10),
                          Text(
                            "The best way to track your mood",
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                            ), // TextStyle
                          ),
                        ],
                      ),
                    ), // Text
                  ), // FadeTransition // SlideTransition
                ),
              ],
            ),
          ),
        ],
      ), // Stack
    ); // Scaffold
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animation;

  ParticlePainter({required this.particles, required this.animation});

  @override
  void paint(Canvas canva, Size size) {
    for (var particle in particles) {
      final paint =
          Paint()
            ..color = particle.color
            ..style = PaintingStyle.fill;
      final centerX = size.width / 2;
      final centerY = size.height / 2;
      final angle = math.atan2(particle.position.dy, particle.position.dx);

      final currentDistance = math.sqrt(
        math.pow(particle.position.dx, 2) + math.pow(particle.position.dy, 2),
      );

      final x =
          centerX +
          math.cos(angle + animation * particle.speed) * currentDistance;
      final y =
          centerY +
          math.sin(angle + animation * particle.speed) * currentDistance;

      final pulsateSize = particle.size * (0.8 + 0.4 * math.sin(animation * 5));

      canva.drawCircle(Offset(x, y), pulsateSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
