import 'package:flutter/material.dart';
import 'package:get/get.dart';

goTo(Widget widget) {
  Get.to(
    () => widget,
    transition: Transition.downToUp,
  );
}
