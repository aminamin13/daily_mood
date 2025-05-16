import 'package:daily_mood/src/common/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void successSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackStyle: SnackStyle.FLOATING,
    backgroundColor: Colors.green.shade400, // A bright success color (green)
    colorText: Colors.white, // White text color for readability
    icon: Icon(
      Icons.check_circle,
      color: Colors.white,
      size: 28, // Icon size
    ),
    borderRadius: 12.0, // Rounded corners for a modern look
    margin: EdgeInsets.all(16), // Add margin to avoid edges
    padding: EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    ), // Extra padding for comfort
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2), // Light shadow for depth
        blurRadius: 8, // Subtle blur radius
        offset: Offset(0, 4), // Position of the shadow
      ),
    ],
    duration: Duration(seconds: 2), // Snackbar stays for 3 seconds
    isDismissible: true, // Allow the snackbar to be dismissed by tap
    snackPosition: SnackPosition.TOP, // Positioned at the bottom of the screen
    animationDuration: Duration(
      milliseconds: 500,
    ), // Smooth animation for the snackbar
  );
}

void errorSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackStyle: SnackStyle.FLOATING,
    backgroundColor: AppColors.warmCoral, // Custom background color
    colorText: Colors.white, // Text color
    icon: Icon(
      Icons.check_circle,
      color: Colors.white,
      size: 28,
    ), // Icon to show
    borderRadius: 12.0, // Rounded corners
    margin: EdgeInsets.all(16), // Add margin around the snackbar
    padding: EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    ), // Add padding for better spacing
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2), // Shadow effect for depth
        blurRadius: 8, // Blur radius of the shadow
        offset: Offset(0, 4), // Shadow position
      ),
    ],
    duration: Duration(seconds: 2), // Time duration for the snackbar to stay
    isDismissible: true, // Allow dismissal by tapping on it
    snackPosition:
        SnackPosition.TOP, // Position of the snackbar (bottom of the screen)
    animationDuration: Duration(
      milliseconds: 500,
    ), // Animation duration for appearing
  );
}
