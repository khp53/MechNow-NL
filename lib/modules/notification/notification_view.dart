import 'package:flutter/material.dart';
import 'package:hackathon_user_app/modules/notification/notification_viewmodel.dart';
import 'package:hackathon_user_app/modules/notification/widget/notification_permission.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationPermission(
      viewmodel: NotificationViewmodel(),
    );
  }
}
