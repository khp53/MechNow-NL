import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hackathon_user_app/dependencies/dependency_injection.dart';
import 'package:hackathon_user_app/modules/notification/fcm_notification_viewmodel.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';
import 'package:hackathon_user_app/services/auth_services/auth_services.dart';
import 'package:hackathon_user_app/services/user_services/user_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthViewmodel extends Viewmodel {
  AuthServices get _authServices => dependency();
  UserServices get _userServices => dependency();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  String _role = 'Who are you? *';
  String _childRole = 'What do you do? *';
  bool _isLoading = false;
  bool isMechanic = false;

  String get role => _role;
  setRole(String role) {
    _role = role;
    turnIdle();
  }

  String get childRole => _childRole;
  setChildRole(String childRole) {
    _childRole = childRole;
    Get.back();
    turnIdle();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    turnIdle();
  }

  createUserAccount() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      await _authServices.createUserAccount(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phoneNumber: phoneController.text,
        area: areaController.text,
        role: role,
        childRole: childRole,
      );
      isLoading = false;
    }
  }

  loginUser() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      await _authServices.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
        isMechanic,
      );
      isLoading = false;
    }
  }

  signInWithGoogle() async {
    isLoading = true;
    await _authServices.signInWithGoogle();
    isLoading = false;
  }

  getUserData() async {
    await _userServices.getUserData();
    await checkUserType();
    //await getUsername();
    await registerNotification();
  }

  checkUserType() async {
    var userBox = await Hive.openBox('user');
    var userType = userBox.get('role');
    if (userType == 'generalUser') {
      isMechanic = false;
    } else {
      isMechanic = true;
    }
  }
}
