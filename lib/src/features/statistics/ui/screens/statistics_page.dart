import 'package:daily_mood/src/common/extensions/color_extension.dart';
import 'package:daily_mood/src/features/home/controller/home_screen_controller.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/primary_header_container.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/section_heading.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeScreenController());
    final moodData = homeController.getGroupedMoodStats();
    final moodData1 = homeController.getGroupedMoodStatsByMonth(
      homeController.selectedMonth.value,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppPrimaryHeaderContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  height: 120,
                  child: const AppSectionHeading(
                    title: "Mood Statistics",
                    textColor: Colors.white,
                  ),
                ),
              ),
            ),

            Obx(() {
              final years = homeController.getAvailableYears();
              final selectedMonth = homeController.selectedMonth.value;
              final selectedYear = homeController.selectedYear.value;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.warmCoral,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Select Month",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonHideUnderline(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: DropdownButton<int>(
                                  isExpanded: true,
                                  value: selectedMonth,
                                  items: List.generate(12, (index) {
                                    final month = index + 1;
                                    return DropdownMenuItem(
                                      value: month,
                                      child: Text(
                                        "${month.toString().padLeft(2, '0')} - ${homeController.monthName(month)}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  }),
                                  onChanged: (value) {
                                    if (value != null) {
                                      homeController.selectedMonth.value =
                                          value;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Select Year",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonHideUnderline(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: DropdownButton<int>(
                                  isExpanded: true,
                                  value: selectedYear,
                                  items:
                                      years.map((year) {
                                        return DropdownMenuItem(
                                          value: year,
                                          child: Text(
                                            year.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      homeController.selectedYear.value = value;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            Obx(() {
              // Access reactive variables directly inside Obx
              final selectedMonth = homeController.selectedMonth.value;
              final selectedYear = homeController.selectedYear.value;

              final moodData = homeController.getGroupedMoodStatsByMonthAndYear(
                selectedMonth,
                selectedYear,
              );

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  height: 400,
                  child:
                      moodData.isEmpty
                          ? const Center(
                            child: Text(
                              "No data for this month and year",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                          : PieChart(
                            PieChartData(
                              sections:
                                  moodData.entries.map((entry) {
                                    return PieChartSectionData(
                                      title:
                                          "${entry.value['emoji']} ${entry.key} ${entry.value['count']}",
                                      value:
                                          (entry.value['count'] as int)
                                              .toDouble(),
                                      radius: 100,
                                      color: (entry.value['color'] as Color)
                                          .withOpacity(0.7),
                                      titleStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }).toList(),
                              pieTouchData: PieTouchData(
                                enabled: true,
                                touchCallback: (event, response) {},
                              ),
                            ),
                          ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
