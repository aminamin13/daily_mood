import 'package:get/get.dart';
import 'dart:async';

class StatisticsController extends GetxController {
  RxDouble animationProgress = 0.0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startAnimation();
  }

  void _startAnimation() {
    const duration = Duration(milliseconds: 20);
    _timer = Timer.periodic(duration, (timer) {
      if (animationProgress.value >= 1.0) {
        animationProgress.value = 1.0;
        _timer?.cancel();
      } else {
        animationProgress.value += 0.03; // Increment smoothly
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
