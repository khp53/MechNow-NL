import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_bottomsheet.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:hackathon_user_app/common/custom_text_field.dart';
import 'package:hackathon_user_app/modules/auth/auth_viewmodel.dart';

class RegistrationBody extends StatelessWidget {
  const RegistrationBody({super.key, required this.viewmodel});
  final AuthViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                    'Create an account.',
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text(
                    'Create an account to start looking for mechanics',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: theme.colorScheme.onSurface),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextFormField(
                  hintText: "Enter your legal name *",
                  isObscured: false,
                  isDigit: false,
                  isRequired: true,
                  controller: viewmodel.nameController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  hintText: "Enter your phone number *",
                  isObscured: false,
                  isDigit: true,
                  isRequired: true,
                  controller: viewmodel.phoneController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Phone no. is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomBottomSheet(
                    child: Column(
                      children: [
                        Text(
                          'What are you? *',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          title: Text(
                            'General User',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                            'Mechanic',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  hintText: "Enter your email *",
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
                  hintText: "Enter your password *",
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
                  height: 12,
                ),
                CustomTextFormField(
                  hintText: "Confirm password *",
                  isObscured: true,
                  isDigit: false,
                  isRequired: true,
                  controller: viewmodel.passwordController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Confirm Password is required';
                    } else if (p0 != viewmodel.passwordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    buttonColor: theme.colorScheme.primary,
                    textColor: theme.colorScheme.onPrimary,
                    buttonText: 'Create account',
                    onPressed: () async => await viewmodel.createUserAccount(),
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
                      'Or continue with',
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
                    text: 'By creating an account, you agree to our ',
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
      ),
    );
  }
}
