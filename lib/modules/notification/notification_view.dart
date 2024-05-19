import 'package:flutter/material.dart';
import 'package:hackathon_user_app/modules/notification/notification_viewmodel.dart';
import 'package:hackathon_user_app/modules/notification/widget/notification_permission.dart';
import 'package:hackathon_user_app/modules/user_location/location_permission.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key, this.isLocation});
  final bool? isLocation;

  @override
  Widget build(BuildContext context) {
    return isLocation == true
        ? LocationPermission(
            viewmodel: NotificationViewmodel(),
          )
        : NotificationPermission(
            viewmodel: NotificationViewmodel(),
          );
  }
}
