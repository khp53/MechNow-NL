import 'package:flutter/material.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';

class AuthViewmodel extends Viewmodel {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
}
