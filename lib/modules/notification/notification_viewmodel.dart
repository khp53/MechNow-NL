import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:hackathon_user_app/modules/home/home_view.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationViewmodel extends Viewmodel {
  checkNotificationPermission() async {
    // Check if notification permission is granted
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await requestNotificationPermission();
    } else {
      // Permission is granted
      Get.to(
        () => const HomeView(),
        transition: Transition.downToUp,
      );
    }
  }

  requestNotificationPermission() async {
    // Request notification permission
    await Permission.notification.request();
    // Check if permission is granted
    await checkNotificationPermission();
  }
}
