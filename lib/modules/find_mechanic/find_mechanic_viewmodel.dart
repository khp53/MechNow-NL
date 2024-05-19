import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon_user_app/dependencies/dependency_injection.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';
import 'package:hackathon_user_app/services/request_services/request_services.dart';

class FindMechanicViewmodel extends Viewmodel {
  FindMechanicViewmodel() {
    // Add your initialization code here
  }
  RequestServices get _reqServices => dependency();

  TextEditingController noteController = TextEditingController();
  String _problemType = '';

  String get problemType => _problemType;
  setProblemType(String value) {
    _problemType = value;
    Get.back();
    turnIdle();
  }

  sendMechanicRequest(
      {required String latLang, required String requestType}) async {
    // Add your send mechanic request code here
    /*
    10.20.174.64/api/request
    uid,
    name,
    userLatLang,
    problemType,
    note,
    */

    var res = await _reqServices.sendMechanicRequest(
      userLatLang: latLang,
      problemType: _problemType,
      note: noteController.text,
      requestType: requestType,
    );
    return res;
  }
}
