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
    Get.snackbar(
      title,
      message,
      backgroundColor: color ?? (isSuccess ? Colors.green : Colors.redAccent),
      colorText: textColor ?? Colors.white,
      icon: icon,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
    );
  }

  static void showCustomSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static String convertImageUrl(String image) {
    late String i;
    if (image.startsWith('http')) {
      i = image;
    } else {
      i =
          'https://sin1.contabostorage.com/eb23de04d375490f89955c112d0422fd:mallumart/$image';
    }

    // TODO: remove the below condition before release
    if (i.startsWith(
        "https://sin1.contabostorage.com/eb23de04d375490f89955c112d0422fd:mallumart/mdi:")) {
      i =
          "https://sin1.contabostorage.com/eb23de04d375490f89955c112d0422fd:mallumart/1738421851959_145_a.webp";
    }

    return i;
  }
}
