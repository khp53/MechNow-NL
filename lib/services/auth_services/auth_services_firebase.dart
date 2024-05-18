import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_snackbar.dart';
import 'package:hackathon_user_app/services/auth_services/auth_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthServicesFirebase extends AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
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
          title: "Aler!",
          message: 'The password provided is too weak.',
          bgColor: Colors.red,
        );
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        customSnackBar(
          title: "Aler!",
          message: 'The password provided is too weak.',
          bgColor: Colors.red,
        );
      }
    } catch (e) {
      customSnackBar(
        title: "Aler!",
        message: e.toString(),
        bgColor: Colors.red,
      );
      debugPrint(e.toString());
    }
  }
}
