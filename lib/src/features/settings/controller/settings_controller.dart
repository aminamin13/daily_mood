import 'package:daily_mood/src/common/utils/toasts.dart';
import 'package:daily_mood/src/config/local_notifications.dart';
import 'package:daily_mood/src/core/storage/preferences.dart';
import 'package:daily_mood/src/features/home/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  RxBool isNotificationEnabled = true.obs;

    

  final InAppReview inAppReview = InAppReview.instance;

  @override
  void onInit() async {
    loadNotificationState();

    super.onInit();
  }

  void rateApp() {
    inAppReview.openStoreListing(
      appStoreId: 'com.artprograms2xz.flutter_movie_go',
      
    );
  }

  Future<void> loadNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    isNotificationEnabled.value = prefs.getBool('notifications') ?? true;
  }

  void setNotification(bool status) async {
    isNotificationEnabled.value = status;
    isNotificationEnabled.value == true
        ? successSnackbar("Success", "Notifications Enabled successfully")
        : successSnackbar("Success", "Notifications disabled successfully");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', status);

    if (!status) {
      // Re-enable your scheduled notification(s)
      await NotificationService.scheduleDailyNotification(
        hour: 19,
        minute: 0,
        title: "Daily Reminder",
        body: "Don't forget to log your mood!",
        payload: "daily_reminder",
      );
    } else {
      // Cancel all active notifications
      await NotificationService.cancelAllNotifications();
    }
  }



// dark mode
 

  void deleteAllData() {
    MoodDatabase.instance.deleteAllMoods();

    HomeScreenController.instance.moodEntries.clear();

    successSnackbar("Success", "All data deleted successfully");
  }
}
