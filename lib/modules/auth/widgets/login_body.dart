import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:hackathon_user_app/common/custom_text_field.dart';
import 'package:hackathon_user_app/modules/auth/auth_viewmodel.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key, required this.viewmodel});
  final AuthViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: viewmodel.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    'App Name',
                    style: theme.textTheme.headlineMedium!.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Welcome Back!',
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: Text(
                  'Login to Appname to start looking for mechanics',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: theme.colorScheme.onSurface),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hintText: "Enter your email",
                isObscured: false,
                isDigit: false,
                isRequired: true,
                controller: viewmodel.emailController,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                hintText: "Enter your password",
                isObscured: true,
                isDigit: false,
                isRequired: true,
                controller: viewmodel.passwordController,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: viewmodel.isLoading
                    ? CustomButton(
                        loading: true,
                        buttonColor: theme.colorScheme.primary,
                        textColor: theme.colorScheme.onPrimary,
                        buttonText: 'Login',
                        onPressed: () {},
                      )
                    : CustomButton(
                        buttonColor: theme.colorScheme.primary,
                        textColor: theme.colorScheme.onPrimary,
                        buttonText: 'Login',
                        onPressed: () async {
                          await viewmodel.loginUser();
                        },
                      ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 100,
                    color: theme.colorScheme.secondary,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Or login with',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 1,
                    width: 100,
                    color: theme.colorScheme.secondary,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                buttonColor: const Color(0xFFEEEEEE),
                textColor: theme.colorScheme.onSurface,
                buttonText: 'Google',
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/Google.png',
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By logging in, you agree to our ',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: ' and ',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
