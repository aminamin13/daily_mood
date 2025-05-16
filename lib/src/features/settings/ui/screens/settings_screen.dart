import 'package:daily_mood/src/common/extensions/color_extension.dart';
import 'package:daily_mood/src/features/settings/controller/settings_controller.dart';
import 'package:daily_mood/src/features/settings/ui/screens/about_popup.dart';
import 'package:daily_mood/src/features/settings/ui/screens/contact_popup.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/primary_header_container.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/section_heading.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/settings_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
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
                    title: "General Settings",
                    textColor: Colors.white,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Obx(
                    () => AppSettingMenuTile(
                      icon: Iconsax.notification,
                      title: 'Enable Notifications',
                      subtitle: 'Receive push notifications',
                      trailing: Switch(
                        activeColor: AppColors.warmCoral,
                        inactiveTrackColor: Colors.grey,
                        inactiveThumbColor: Colors.white,
                        thumbColor: WidgetStateProperty.all(Colors.white),
                        trackOutlineColor: WidgetStateProperty.all(
                          Colors.black12,
                        ),

                        value: controller.isNotificationEnabled.value,
                        onChanged: (value) async {
                          controller.setNotification(value);
                        },
                      ),
                    ),
                  ),
                  AppSettingMenuTile(
                    onTap: () => controller.rateApp(),
                    icon: Iconsax.star,
                    title: 'Rate Us',
                    subtitle: 'Rate our App',
                  ),

                  AppSettingMenuTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ContactSupportPopup(),
                      );
                    },
                    icon: Iconsax.bag_tick,
                    title: 'Contact Support',
                    subtitle: 'Contact our support team',
                  ),
                  AppSettingMenuTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AboutPopup(),
                      );
                    },
                    icon: Iconsax.bag_tick,
                    title: 'About App',
                    subtitle: 'About our App',
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: const BorderSide(color: Colors.red),
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      onPressed: () {
                        controller.deleteAllData();
                      },
                      child: Text(
                        "Delete All Data",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32 * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
