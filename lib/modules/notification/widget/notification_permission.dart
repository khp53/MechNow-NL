import 'package:flutter/material.dart';
import 'package:hackathon_user_app/common/custom_button.dart';
import 'package:hackathon_user_app/modules/notification/notification_viewmodel.dart';
import 'package:lottie/lottie.dart';

class NotificationPermission extends StatelessWidget {
  const NotificationPermission({super.key, required this.viewmodel});
  final NotificationViewmodel viewmodel;

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
                    'MechNow NL',
                    style: theme.textTheme.headlineMedium!.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: SizedBox(
                  height: 300,
                  child: Lottie.asset(
                    'assets/lottie/notification.json',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  'You will get notified when your mechanic accepts your requests.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    buttonColor: theme.colorScheme.primary,
                    textColor: theme.colorScheme.onPrimary,
                    buttonText: 'Turn on notifications',
                    onPressed: () async {
                      await viewmodel.checkNotificationPermission();
                    },
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
