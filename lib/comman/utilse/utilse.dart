import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';

class Utils {
  static void showSnackBar(
    String title,
    String message, {
    Color? color,
    Widget? icon,
    bool isSuccess = false,
    Color? textColor,
  }) {
    void showCustomSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
  }
}
