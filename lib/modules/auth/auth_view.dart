import 'package:flutter/material.dart';
import 'package:hackathon_user_app/modules/auth/auth_viewmodel.dart';
import 'package:hackathon_user_app/modules/auth/widgets/login_body.dart';
import 'package:hackathon_user_app/modules/auth/widgets/registration_body.dart';
import 'package:hackathon_user_app/modules/view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key, required this.isLogin});
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView(
        viewmodel: AuthViewmodel(),
        builder: (_, viewmodel, __) {
          return isLogin
              ? LoginBody(
                  viewmodel: viewmodel,
                )
              : RegistrationBody(
                  viewmodel: viewmodel,
                );
        },
      ),
    );
  }
}
