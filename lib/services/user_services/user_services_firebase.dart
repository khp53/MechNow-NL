import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_snackbar.dart';
import 'package:hackathon_user_app/services/user_services/user_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserServicesFirebase extends UserServices {
  final db = FirebaseFirestore.instance;

  @override
  getUserData() async {
    var userBox = await Hive.openBox('user');
    final uid = await userBox.get('user_id');
    // fetch user data from firestore user collection
    final docRef = db.collection("users").doc(uid);
    docRef.get().then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;
        // save user data to user model
        await userBox.put('name', data['name']);
        await userBox.put('phoneNumber', data['phone']);
        await userBox.put('area', data['area']);
        await userBox.put('role', data['role']);
        debugPrint(data['role'].toString());
        await userBox.put('email', data['email']);
      },
      onError: (e) => customSnackBar(
        title: "Alert!",
        message: "Cannot get document at this moment!",
        bgColor: Colors.red,
      ),
    );
  }

  @override
  updateFcmToken(String fcmToken) async {
    var userBox = await Hive.openBox('user');
    final uid = await userBox.get('user_id');
    final docRef = db.collection("users").doc(uid);
    docRef.update({'deviceToken': fcmToken}).then(
      (value) {
        debugPrint("Token Updated");
        userBox.put('deviceToken', fcmToken);
      },
      onError: (e) => debugPrint(e.toString()),
    );
  }
}
