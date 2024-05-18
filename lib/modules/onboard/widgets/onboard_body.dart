import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:hackathon_user_app/modules/auth/auth_view.dart';
import 'package:hackathon_user_app/modules/onboard/onboard_viewmodel.dart';
import 'package:hackathon_user_app/utils/router.dart';

class OnboardBody extends StatelessWidget {
  const OnboardBody({super.key, required this.viewmodel});
  final OnboardViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/onboard.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'App Name',
                style: theme.textTheme.headlineMedium!.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Text(
                'Your Mobile Mechanic in Minutes!',
                style: theme.textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Text(
                '"Need a quick fix? With APPNAME, you can find reliable mechanics near you, track their arrival in real-time, and get your vehicle serviced on the spot.',
                style: theme.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  buttonColor: theme.colorScheme.primary,
                  textColor: theme.colorScheme.onPrimary,
                  buttonText: 'Login',
                  onPressed: () => goTo(
                    const AuthView(
                      isLogin: true,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                bottom: 20.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  buttonColor: theme.colorScheme.surface,
                  textColor: theme.colorScheme.onPrimary,
                  borderColor: theme.colorScheme.onPrimary,
                  buttonText: 'Create account',
                  onPressed: () => goTo(
                    const AuthView(
                      isLogin: false,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
