import 'package:daily_mood/src/config/local_notifications.dart';
import 'package:daily_mood/src/config/services.dart';
import 'package:daily_mood/src/core/storage/preferences.dart';
import 'package:daily_mood/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initialServices();
  tz.initializeTimeZones();
  await MoodDatabase.instance.database; // this initializes it
  await NotificationService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Mood Journal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Quicksand',
      ),
      getPages: routes,
    );
  }
}
