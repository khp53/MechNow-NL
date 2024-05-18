import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackBar(
    {required String title, required String message, required Color bgColor}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: bgColor,
    colorText: Colors.white,
  );
}
