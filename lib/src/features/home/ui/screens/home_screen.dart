import 'package:daily_mood/src/common/extensions/color_extension.dart';
import 'package:daily_mood/src/features/home/controller/home_screen_controller.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/primary_header_container.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppPrimaryHeaderContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  height: 120,
                  child: const AppSectionHeading(
                    title: "Welcome Back Dear \u{1F600}",
                    textColor: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mood History",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  GetBuilder<HomeScreenController>(
                    builder: (controller) {
                      return TableCalendar(
                        firstDay: DateTime.utc(2022, 3, 14),
                        lastDay: DateTime.utc(2200, 3, 14),
                        focusedDay: controller.focusedDay.value,

                        startingDayOfWeek: StartingDayOfWeek.monday,
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        rowHeight: 70,
                        daysOfWeekHeight: 50,
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          weekendStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        calendarFormat: CalendarFormat.month,
                        currentDay: controller.selectedDay.value,
                        selectedDayPredicate:
                            (day) => isSameDay(day, DateTime.now()),
                        onDaySelected: (selectedDay, focusedDay) {
                          final mood = controller.getMoodForDay(selectedDay);
                          if (mood != null) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder:
                                  (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Center(
                                      child: Text(
                                        mood.emoji,
                                        style: const TextStyle(fontSize: 40),
                                      ),
                                    ),
                                    content: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Mood: ${mood.mood}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Note: ${mood.note}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(
                                            context,
                                          ).pop(); // Close the dialog
                                        },
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),

                                      TextButton(
                                        onPressed: () {
                                          controller.deleteMood(
                                            selectedDay,
                                          ); // Call delete function
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                          }
                        },
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: AppColors.mintGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(
                          selectedBuilder: (context, day, focusedDay) {
                            final mood = controller.getMoodForDay(day);
                            return Center(
                              child: Text(
                                mood?.emoji.isNotEmpty == true
                                    ? mood!.emoji
                                    : '${day.day}',
                                style: TextStyle(
                                  fontSize:
                                      mood?.emoji.isNotEmpty == true ? 25 : 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          defaultBuilder: (context, day, focusedDay) {
                            final mood = controller.getMoodForDay(day);

                            return Center(
                              child: Text(
                                mood?.emoji.isNotEmpty == true
                                    ? mood!.emoji
                                    : '${day.day}',
                                style: TextStyle(
                                  fontSize:
                                      mood?.emoji.isNotEmpty == true ? 25 : 18,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                            // fallback to default
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
