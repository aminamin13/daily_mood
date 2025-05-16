import 'package:daily_mood/src/common/extensions/color_extension.dart';
import 'package:daily_mood/src/features/add_mood/ui/screens/add_mood_screen.dart';
import 'package:daily_mood/src/features/home/ui/screens/home_screen.dart';
import 'package:daily_mood/src/features/settings/ui/screens/settings_screen.dart';
import 'package:daily_mood/src/features/statistics/ui/screens/statistics_page.dart';
import 'package:flutter/material.dart';

class MainTabview extends StatefulWidget {
  const MainTabview({super.key});

  @override
  State<MainTabview> createState() => _MainTabviewState();
}

class _MainTabviewState extends State<MainTabview>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(length: 4, vsync: this);
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;

      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          height: 80,
          child: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            indicatorWeight: 1,

            labelColor: AppColors.warmCoral,
            labelStyle: TextStyle(
              color: AppColors.warmCoral,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),

            controller: controller,
            unselectedLabelColor: AppColors.charcoalGray,
            unselectedLabelStyle: TextStyle(
              color: AppColors.charcoalGray,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  size: 35,
                  color:
                      selectTab == 0
                          ? AppColors.warmCoral
                          : AppColors.charcoalGray,
                ),
                text: "Home",
              ),
              Tab(
                icon: Icon(
                  Icons.mood,
                  size: 35,
                  color:
                      selectTab == 1
                          ? AppColors.warmCoral
                          : AppColors.charcoalGray,
                ),
                text: "Moods",
              ),
              Tab(
                icon: Icon(
                  Icons.analytics,
                  size: 35,
                  color:
                      selectTab == 2
                          ? AppColors.warmCoral
                          : AppColors.charcoalGray,
                ),
                text: "Statistic",
              ),
              Tab(
                icon: Icon(
                  Icons.settings,
                  size: 35,
                  color:
                      selectTab == 3
                          ? AppColors.warmCoral
                          : AppColors.charcoalGray,
                ),
                text: "Settings",
              ),
            ],
          ),
        ),
      ),

      body: TabBarView(
        controller: controller,
        children: [
          const HomeScreen(),
          const AddMoodScreen(),
          StatisticsPage(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
