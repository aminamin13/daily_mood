import 'package:daily_mood/src/common/extensions/color_extension.dart';
import 'package:daily_mood/src/features/add_mood/controller/add_mood_controller.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/primary_header_container.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
class AddMoodScreen extends StatelessWidget {
  const AddMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoodController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    title: "Today's Mood \u{1F600}",

                    textColor: Colors.white,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How are you feeling today?',
                    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,)
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: controller.txtController.value,
                    maxLines: 3,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter your mood ...',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    'Select Mood',
                    style:  TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,)
                  
                  ),

                  SizedBox(
                    height: 220,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            mainAxisExtent: 40,
                          ),

                      itemBuilder: (context, index) {
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.selectedMood.value = index;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    controller.selectedMood.value == index
                                        ? (controller.mood[index]['color']
                                                as Color)
                                            .withValues(alpha: 0.9)
                                        : controller.mood[index]['color']
                                            as Color,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      controller.selectedMood.value == index
                                          ? (controller.mood[index]['color']
                                                  as Color)
                                              .withValues(alpha: 0.9)
                                          : controller.mood[index]['color']
                                              as Color,
                                  width: 3,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                "${controller.mood[index]['emoji']} ${controller.mood[index]['name']}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight:
                                      controller.selectedMood.value == index
                                          ? FontWeight.bold
                                          : FontWeight.w600,
                                  color:
                                      controller.selectedMood.value == index
                                          ? Colors.black
                                          : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        );
                      },

                      itemCount: controller.mood.length,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    'Select Date',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate.value,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          controller.selectedDate.value = picked;
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${controller.selectedDate.value.toLocal()}"
                                  .split(' ')[0],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  InkWell(
                    onTap: () async {
                      await controller.saveMood();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.fogWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Add Mood",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
  }
}
