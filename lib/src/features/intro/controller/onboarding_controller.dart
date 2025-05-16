import 'package:daily_mood/src/config/services.dart';
import 'package:daily_mood/src/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnboardingController extends GetxController {
  MyServices myServices = Get.find();

  toMainTabView() {
    myServices.sharedPreferences.setString("step", "2");

    Get.offNamed(AppRoute.mainTabView);
  }

  List<PageViewModel>? listPagesViewModel = [
    PageViewModel(
      title: "Welcome to Daily Mood",
      body:
          "Track your feelings, reflect daily, and understand yourself better.",
      image: Lottie.asset("assets/lottie/page1.json", width: 200, height: 200),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
        bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
      ),
    ),
    PageViewModel(
      title: "Log Your Mood in Seconds",
      body: "Choose how you feel, add a note, and move on with your day.",
      image: Lottie.asset("assets/lottie/page2.json", width: 200, height: 200),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
        bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
      ),
    ),
    PageViewModel(
      title: "See Your Emotional Journey",
      body: "Discover patterns and gain insights to improve your well-being",
      image: Lottie.asset("assets/lottie/page3.json", width: 200, height: 200),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
        bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
      ),
    ),
  ];
}
