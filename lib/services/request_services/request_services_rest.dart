import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon_user_app/common/custom_snackbar.dart';
import 'package:hackathon_user_app/modules/auth/auth_view.dart';
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

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 202) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        Get.offAll(
          () => const AuthView(
            isLogin: true,
          ),
        );
      } else {
        debugPrint("Else Response: ${response.statusCode}");
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error:$e");
      customSnackBar(
        title: 'Alert!',
        message:
            "Sorry cannot process your request right now! Please try again later.",
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
}
