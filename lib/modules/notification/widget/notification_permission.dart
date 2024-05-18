import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:lottie/lottie.dart';

class NotificationPermission extends StatelessWidget {
  const NotificationPermission({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                child: Lottie.asset('assets/lottie/notification.json'),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'You will get notified when your mechanic accepts your requests.',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    buttonColor: theme.colorScheme.primary,
                    textColor: theme.colorScheme.onPrimary,
                    buttonText: 'Turn on notifications',
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
