import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_snackbar.dart';
import 'package:hackathon_user_app/model/user.dart';
import 'package:hackathon_user_app/services/auth_services/auth_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
          message: 'The password provided is too weak.',
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
  }) async {
    var userBox = await Hive.openBox('user');
    UserCredential userCredential = await registerUser(email, password);

    if (userCredential.user != null && userCredential.user!.uid.isNotEmpty) {
      Users user = Users(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        phone: phoneNumber,
        area: area,
        role: role,
      );
      await _db
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toJson());
      userBox.put('area', area);
      userBox.put('role', role);
    }
  }

  @override
  signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      var userBox = await Hive.openBox('user');
      userBox.put('user_id', credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        customSnackBar(
          title: 'Alert!',
          message: 'No user found for that email.',
          bgColor: Colors.red,
        );
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        customSnackBar(
          title: 'Alert!',
          message: 'Wrong password provided for that user.',
          bgColor: Colors.red,
        );
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  @override
  signOut() async {
    await _firebaseAuth.signOut();
  }
}
