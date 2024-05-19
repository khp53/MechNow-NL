import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon_user_app/common/custom_snackbar.dart';
import 'package:hackathon_user_app/model/user.dart';
import 'package:hackathon_user_app/modules/home/home_view.dart';
import 'package:hackathon_user_app/modules/notification/notification_view.dart';
import 'package:hackathon_user_app/services/auth_services/auth_services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthServicesFirebase extends AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  registerUser(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // save credential to hive and then return it
      var userBox = await Hive.openBox('user');
      userBox.put('user_id', credential.user!.uid);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        customSnackBar(
          title: "Alert!",
          message: 'The password provided is too weak.',
          bgColor: Colors.red,
        );
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        customSnackBar(
          title: "Alert!",
          message: 'The account already exists for that email.',
          bgColor: Colors.red,
        );
      }
    } catch (e) {
      customSnackBar(
        title: "Alert!",
        message: e.toString(),
        bgColor: Colors.red,
      );
      debugPrint(e.toString());
    }
  }

  @override
  createUserAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String area,
    required String role,
    required String childRole,
  }) async {
    var userBox = await Hive.openBox('user');
    UserCredential? userCredential = await registerUser(email, password);

    if (userCredential != null &&
        userCredential.user != null &&
        userCredential.user!.uid.isNotEmpty) {
      Users user = Users(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        phone: phoneNumber,
        area: area,
        role: role == 'mechanic' ? childRole : role,
      );
      await _db
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toJson());
      await userBox.put('area', area);
      await userBox.put('role', childRole);
      //await userBox.put('childRole', childRole);
      await userBox.put('name', name);
      var status = await Permission.notification.status;
      if (!status.isGranted) {
        Get.to(
          () => const NotificationView(),
          transition: Transition.downToUp,
        );
      } else {
        Get.offAll(
          () => const HomeView(),
          transition: Transition.downToUp,
        );
      }
      customSnackBar(
        title: 'Success!',
        message: 'Successfully created your account.',
        bgColor: Colors.green,
      );
    } else {
      customSnackBar(
        title: 'Alert!',
        message: 'Failed to create your account.',
        bgColor: Colors.red,
      );
    }
  }

  @override
  signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      //print(credential.user!.uid);
      var userBox = await Hive.openBox('user');
      userBox.put('user_id', credential.user!.uid);
      var status = await Permission.notification.status;
      if (!status.isGranted) {
        Get.to(
          () => const NotificationView(),
          transition: Transition.downToUp,
        );
      } else {
        Get.offAll(
          () => const HomeView(),
          transition: Transition.downToUp,
        );
      }
      customSnackBar(
        title: 'Success!',
        message: 'Successfully signed in.',
        bgColor: Colors.green,
      );
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      customSnackBar(
        title: 'Alert!',
        message: "Failed to sign in at this moment. Please try again later.",
        bgColor: Colors.red,
      );
    }
  }

  @override
  signOut() async {
    await _firebaseAuth.signOut();
  }
}
