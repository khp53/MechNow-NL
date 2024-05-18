import 'package:flutter/material.dart';
import 'package:hackathon_user_app/dependencies/dependency_injection.dart';
import 'package:hackathon_user_app/modules/notification/widget/notification_permission.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';
import 'package:hackathon_user_app/services/auth_services/auth_services.dart';
import 'package:hackathon_user_app/utils/router.dart';

class AuthViewmodel extends Viewmodel {
  AuthServices get _authServices => dependency();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  createUserAccount() async {
    if (formKey.currentState!.validate()) {
      await _authServices.createUserAccount(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phoneNumber: phoneController.text,
        area: 'area',
        role: 'role',
      );
      goTo(const NotificationPermission());
    }
  }
}
