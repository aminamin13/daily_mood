import 'package:daily_mood/src/common/extensions/color_extension.dart';
import 'package:daily_mood/src/features/intro/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: controller.listPagesViewModel,
          globalBackgroundColor: Colors.white,
          controlsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 70,
          ),

          showNextButton: true,
          next: Text(
            "Next",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          showSkipButton: true, // Optional: to show "Skip"
          showDoneButton: true, // ✅ Shows only on the last page

          done: Text(
            "Done",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: AppColors.warmCoral,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 5.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          skip: Text(""),
          onDone: () {
            controller.toMainTabView();
          },
        ),
      ),
    );
  }
}
