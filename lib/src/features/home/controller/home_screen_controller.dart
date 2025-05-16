import 'package:daily_mood/src/common/utils/toasts.dart';
import 'package:daily_mood/src/config/local_notifications.dart';
import 'package:daily_mood/src/core/storage/preferences.dart';
import 'package:daily_mood/src/features/add_mood/model/mood_modle.dart';
import 'package:daily_mood/src/features/main_tab_view/ui/screens/main_tab_view.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();

  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay =
      DateTime.now().obs; // Focused day to control the calendar view

  var moodEntries = <DateTime, MoodEntry>{}.obs;

  RxInt selectedMonth = DateTime.now().month.obs;
  var selectedYear = DateTime.now().year.obs;

  String monthName(int month) {
    const names = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return names[month - 1];
  }

  Map<String, dynamic> getGroupedMoodStatsByMonthAndYear(int month, int year) {
    final filteredEntries = moodEntries.values.where(
      (entry) => entry.date.month == month && entry.date.year == year,
    );

    final Map<String, dynamic> grouped = {};
    for (var entry in filteredEntries) {
      final mood = entry.mood;
      if (!grouped.containsKey(mood)) {
        grouped[mood] = {
          'count': 1,
          'emoji': entry.emoji,
          'color': entry.color,
        };
      } else {
        grouped[mood]['count'] += 1;
      }
    }
    return grouped;
  }

  List<int> getAvailableYears() {
    final years = moodEntries.values.map((e) => e.date.year).toSet().toList();
    years.sort((a, b) => b.compareTo(a)); // Descending order
    return years;
  }

  Map<String, Map<String, dynamic>> getGroupedMoodStats() {
    final Map<String, Map<String, dynamic>> moodData = {};

    for (var entry in moodEntries.values) {
      if (moodData.containsKey(entry.mood)) {
        moodData[entry.mood]!['count'] += 1;
      } else {
        moodData[entry.mood] = {
          'count': 1,
          'color': entry.color,
          'emoji': entry.emoji,
        };
      }
    }

    return moodData;
  }

  Map<String, Map<String, dynamic>> getGroupedMoodStatsByMonth(int month) {
    final allStats = getGroupedMoodStats(); // Replace with your raw data source
    final filteredStats = <String, Map<String, dynamic>>{};

    for (var entry in moodEntries.values) {
      if (entry.date.month == month) {
        final mood = entry.mood;
        if (!filteredStats.containsKey(mood)) {
          filteredStats[mood] = {
            'count': 1,
            'emoji': entry.emoji,
            'color': entry.color,
          };
        } else {
          filteredStats[mood]!['count'] += 1;
        }
      }
    }

    return filteredStats;
  }

  // Set the mood for a specific day
  void setMoodForDay(DateTime day, MoodEntry entry) {
    moodEntries[DateTime(day.year, day.month, day.day)] = entry;

    update(); // Update UI after changing the data
  }

  // Get the mood for a specific day
  MoodEntry? getMoodForDay(DateTime day) {
    return moodEntries[DateTime(day.year, day.month, day.day)];
  }

  // Update the selected day in the controller
  void updateSelectedDay(DateTime newDate) {
    selectedDay.value = newDate;
  }

  // Update the focused day to change the calendar view
  void updateFocusedDay(DateTime newDate) {
    focusedDay.value = newDate;
  }

  @override
  void onInit() {
    super.onInit();
    loadAllMoods();
    listenToNotification();
    NotificationService.scheduleDailyNotification(
      hour: 21, // Set to the time you want the notification
      minute: 0,
      title: 'How was your day?',
      body: 'Don’t forget to log your mood!',
      payload: 'daily_reminder',
    );
    update();
  }

  listenToNotification() {
    NotificationService.onClickNotification.stream.listen((event) {
      Get.to(MainTabview());
    });
  }

  // Load all moods from the database (this should fetch your data)
  Future<void> loadAllMoods() async {
    final db = MoodDatabase.instance; // You need to have your db instance here
    final allMoods =
        await db.fetchAllMoods(); // Implement this in your database class
    for (var mood in allMoods) {
      final dateKey = DateTime(mood.date.year, mood.date.month, mood.date.day);
      moodEntries[dateKey] = mood;
    }
    update(); // This triggers a UI update
  }

  // Delete mood for the selected day

  Future<void> deleteMood(DateTime selectedDay) async {
    final db = MoodDatabase.instance;
    final dateKey = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );
    final moodEntry = moodEntries[dateKey];

    if (moodEntry != null && moodEntry.id != null) {
      // Delete the mood from the database
      await db.deleteMoodById(moodEntry.id!);

      // Remove the mood from the local map
      moodEntries.remove(dateKey);

      update(); // Trigger UI update after deletion
      successSnackbar('Success', 'Mood deleted successfully');
    } else {
      errorSnackbar('Error', 'No mood found to delete for the selected day');
    }
  }
}
