import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_snackbar.dart';
import 'package:hackathon_user_app/services/request_services/request_services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class RequestServicesRest extends RequestServices {
  String url = 'http://10.20.174.64/api/request';
  @override
  sendMechanicRequest({
    required String userLatLang,
    required String problemType,
    required String note,
    required String requestType,
  }) async {
    var uid = await getUid();
    var name = await getName();
    var data = {
      'id': uid,
      'name': name.isEmpty ? 'User' : name,
      'userLatLang': userLatLang,
      'problemType': problemType,
      'note': note,
      'requestType': requestType,
    };
    print(data);
    try {
      final response = await http.post(
        Uri.parse('http://10.20.174.64:3000/api/request'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      return response;
    } catch (e) {
      customSnackBar(
        title: 'Alert!',
        message: "Something went wrong, please try again later!",
        bgColor: Colors.red,
      );
    }
  }

  Future<String> getUid() async {
    var userBox = await Hive.openBox('user');
    var uid = await userBox.get('user_id') ?? '';
    return uid!;
  }

  Future<String> getName() async {
    var userBox = await Hive.openBox('user');
    var name = await userBox.get('name') ?? '';
    return name;
  }

  @override
  sendMechanicHireNoti(
      {required String hiredMechanic, required String userName}) async {
    var name = await getName();
    var data = {
      'hiredMechanic': hiredMechanic,
      'name': name.isEmpty ? 'User' : name,
    };
    try {
      final response = await http.post(
        Uri.parse('http://10.20.174.64:3000/api/request/accept'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      return response;
    } catch (e) {
      customSnackBar(
        title: 'Alert!',
        message: "Something went wrong, please try again later!",
        bgColor: Colors.red,
      );
    }
  }
}
