// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:daily_mood/src/config/services.dart';
import 'package:daily_mood/src/features/intro/ui/screens/OnBoarding_screen.dart';
import 'package:daily_mood/src/features/main_tab_view/ui/screens/main_tab_view.dart';
import 'package:daily_mood/src/features/splash/model/particle_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController
    with GetTickerProviderStateMixin {
  MyServices myServices = Get.find();

  late AnimationController logoController;
  late AnimationController backgroundController;
  late AnimationController textController;
  late AnimationController particlesController;

  late Animation<double> logoScaleAnimation;
  late Animation<double> backgroundAnimation;
  late Animation<Offset> textslideAnimation;
  late Animation<double> logoRotationAnimation;
  late Animation<double> textOpcityAnimation;

  final RxList<Particle> particles = <Particle>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    for (int i = 0; i < 70; i++) {
      particles.add(
        Particle(
          position: Offset(
            math.Random().nextDouble() * 400 - 200,
            math.Random().nextDouble() * 400 - 200,
          ),
          color: Color.fromRGBO(
            math.Random().nextInt(255),
            math.Random().nextInt(255),
            255,
            math.Random().nextInt(255) * 0.6 + 0.2,
          ), // Offset(dx, dy)
          size: math.Random().nextDouble() * 10 + 5,
          speed: math.Random().nextDouble() * 2 + 1,
        ),
      );
    }

    logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    particlesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6100),
    )..forward();

    logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: logoController, curve: Curves.elasticInOut),
    );

    logoRotationAnimation = Tween<double>(begin: 0.0, end: 1.2).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeInOutCubic),
    );

    backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: backgroundController, curve: Curves.elasticInOut),
    );

    textOpcityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: textController,
        curve: Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    textslideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: textController,
        curve: Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    backgroundController.forward();

    Future.delayed(Duration(milliseconds: 500), () {
      logoController.forward();
    });

    Future.delayed(Duration(milliseconds: 1200), () {
      textController.forward();
    });

    Future.delayed(Duration(seconds: 4), () {
      String? step = myServices.sharedPreferences.getString("step");

      Widget targetPage;
      if (step == "2") {
        targetPage = MainTabview(); // make sure to import this
      } else {
        targetPage = OnBoardingPage(); // make sure to import this
        // or show error
      }

      Navigator.of(Get.context!).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => targetPage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    logoController.dispose();
    backgroundController.dispose();
    textController.dispose();
    particlesController.dispose();

    super.dispose();
  }
}
