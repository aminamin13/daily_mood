import 'package:daily_mood/src/common/utils/toasts.dart';
import 'package:daily_mood/src/core/storage/preferences.dart';
import 'package:daily_mood/src/features/add_mood/model/mood_modle.dart';
import 'package:daily_mood/src/features/home/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMoodController extends GetxController {
  final mood =
      [
        {
          'name': 'Happy',
          'emoji': '\u{1F600}', // 😀
          'color': Colors.yellow.withValues(alpha: 0.2),
        },
        {
          'name': 'Sad',
          'emoji': '\u{1F622}', // 😢
          'color': Colors.blue.withValues(alpha: 0.2),
        },
        {
          'name': 'Angry',
          'emoji': '\u{1F621}', // 😡
          'color': Colors.red.withValues(alpha: 0.2),
        },
        {
          'name': 'Excited',
          'emoji': '\u{1F601}', // 😁
          'color': Colors.purple.withValues(alpha: 0.2),
        },
        {
          'name': 'Tired',
          'emoji': '\u{1F634}', // 😴
          'color': Colors.green.withValues(alpha: 0.2),
        },
        {
          'name': 'Rest',
          'emoji': '\u{1F6CF}', // 🛏️
          'color': Colors.lightBlue.withValues(alpha: 0.2),
        },
      ].obs;

  final txtController = TextEditingController().obs;

  var selectedDate = DateTime.now().obs;

  var selectedMood = (-1).obs;

  void resetFields() {
    txtController.value.clear();
    selectedMood.value = -1;
    selectedDate.value = DateTime.now();
  }

  // Method to save mood to the database
  Future<void> saveMood() async {
    try {
      if (txtController.value.text.isEmpty) {
        Get.snackbar('Error', 'Please enter a note');
        return;
      }
      if (selectedMood.value == -1) {
        Get.snackbar('Error', 'Please select a mood');
        return;
      }

      print(mood[selectedMood.value]['color'] as Color);

      // Build a temporary MoodEntry without ID
      final tempMood = MoodEntry(
        date: selectedDate.value,
        mood: mood[selectedMood.value]['name'] as String,
        emoji: mood[selectedMood.value]['emoji'] as String,
        note: txtController.value.text,
        color: mood[selectedMood.value]['color'] as Color,
      );

      // Save to database and get generated ID
      final insertedId = await MoodDatabase.instance.insertMood(tempMood);

      // Rebuild MoodEntry with the new ID
      final moodEntry = MoodEntry(
        id: insertedId,
        date: tempMood.date,
        mood: tempMood.mood,
        emoji: tempMood.emoji,
        note: tempMood.note,
        color: tempMood.color,
      );

      // Update controller
      final homeController = Get.find<HomeScreenController>();
      homeController.setMoodForDay(moodEntry.date, moodEntry);

      print('Saved Mood ID: ${moodEntry.id}');
      print('Mood: ${moodEntry.mood}');
      print('Emoji: ${moodEntry.emoji}');
      print('Note: ${moodEntry.note}');
      print('Color: ${moodEntry.color}');

      successSnackbar('Success', 'Mood saved successfully');
      resetFields();
    } catch (e) {
      errorSnackbar('Error', 'Failed to save mood: $e');
      print('Failed to save mood: $e');
    }
  }

  // Method to get moods for a specific date
  Future<List<MoodEntry>> getMoodsForDate(DateTime date) async {
    return await MoodDatabase.instance.fetchMoodsByDate(date);
  }
}
