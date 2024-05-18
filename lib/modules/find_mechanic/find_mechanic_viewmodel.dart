import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';

class FindMechanicViewmodel extends Viewmodel {
  FindMechanicViewmodel() {
    // Add your initialization code here
  }

  TextEditingController noteController = TextEditingController();
  String _problemType = '';

  String get problemType => _problemType;
  setProblemType(String value) {
    _problemType = value;
    Get.back();
    turnIdle();
  }
}
