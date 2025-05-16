import 'package:daily_mood/src/config/services.dart';
import 'package:daily_mood/src/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;
  MyServices myServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    // if users is already logged in, it will take him to home page
    if (myServices.sharedPreferences.getString("step") == "2") {
      return const RouteSettings(name: AppRoute.mainTabView);
    }
   

    return null;
  }
}
