import 'package:daily_mood/src/features/intro/ui/screens/OnBoarding_screen.dart';
import 'package:daily_mood/src/features/main_tab_view/ui/screens/main_tab_view.dart';
import 'package:daily_mood/src/features/splash/ui/screens/splash_screen.dart';
import 'package:daily_mood/src/routes/routes_name.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: "/",
    page: () => const SplashScreen(),
  ), // this used to start directly from the sign in if the user is already logged in
  // GetPage(name: "/", page: () => const Test()),
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoardingPage()),
  GetPage(name: AppRoute.mainTabView, page: () => const MainTabview()),
];
