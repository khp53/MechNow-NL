import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
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
                parentRole(theme),
                // if (viewmodel.role == 'mechanic') then this will be visible
                viewmodel.role == 'mechanic'
                    ? mechanicRoles(theme)
                    : const SizedBox(),
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
                  controller: viewmodel.confirmPasswordController,
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
                  child: viewmodel.isLoading
                      ? CustomButton(
                          loading: true,
                          buttonColor: theme.colorScheme.primary,
                          textColor: theme.colorScheme.onPrimary,
                          buttonText: 'Create account',
                          onPressed: () {},
                        )
                      : CustomButton(
                          buttonColor: theme.colorScheme.primary,
                          textColor: theme.colorScheme.onPrimary,
                          buttonText: 'Create account',
                          onPressed: () async =>
                              await viewmodel.createUserAccount(),
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

  Widget parentRole(ThemeData theme) {
    return InkWell(
      onTap: () => bottomSheet(
        theme,
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Who are you? *',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                'General User',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                viewmodel.setRole('generalUser');
                Get.back();
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Mechanic',
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () {
                viewmodel.setRole('mechanic');
                Get.back();
              },
            ),
          ],
        ),
      ),
      child: Container(
        //height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF828282),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              viewmodel.role,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: const Color(0xFF828282),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_drop_down,
              color: theme.colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }

  Column mechanicRoles(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: () => bottomSheet(
            theme,
            SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'What do you do? *',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      'Automobile Mechanic',
                      style: theme.textTheme.bodyMedium,
                    ),
                    onTap: () => viewmodel.setChildRole('automobileMechanic'),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      'Locksmith',
                      style: theme.textTheme.bodyMedium,
                    ),
                    onTap: () => viewmodel.setChildRole('locksmith'),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      'Plumber',
                      style: theme.textTheme.bodyMedium,
                    ),
                    onTap: () => viewmodel.setChildRole('plumber'),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      'Roofer',
                      style: theme.textTheme.bodyMedium,
                    ),
                    onTap: () => viewmodel.setChildRole('roofer'),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      'Electrician',
                      style: theme.textTheme.bodyMedium,
                    ),
                    onTap: () => viewmodel.setChildRole('electrician'),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      'Heater Mechanic',
                      style: theme.textTheme.bodyMedium,
                    ),
                    onTap: () => viewmodel.setChildRole('heaterMechanic'),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      'Carpenter',
                      style: theme.textTheme.bodyMedium,
                    ),
                    onTap: () => viewmodel.setChildRole('carpenter'),
                  ),
                ],
              ),
            ),
          ),
          child: Container(
            //height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF828282),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Text(
                  viewmodel.childRole,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF828282),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: theme.colorScheme.secondary,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        CustomTextFormField(
          hintText: "Where are you located? *",
          isObscured: false,
          isDigit: false,
          isRequired: true,
          controller: viewmodel.areaController,
          validator: (p0) {
            if (p0!.isEmpty && viewmodel.role == 'mechanic') {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
