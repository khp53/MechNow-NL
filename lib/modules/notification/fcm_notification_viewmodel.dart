import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:hackathon_user_app/dependencies/dependency_injection.dart';
import 'package:hackathon_user_app/model/push_notification_model.dart';
import 'package:hackathon_user_app/services/user_services/user_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

UserServices get _pushNotificationServices => dependency();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showLocalNotification(message);
}

Future<void> showLocalNotification(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  // iOS heads up notification setting
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  // android channel setting
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
    showBadge: true,
  );
  // initialize local notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel', //channel.id,
          'High Importance Notifications', //channel.name,
        ),
      ),
      payload: json.encode(message.data),
    );
  }
}

// initial notification implementation
var notificationInfo = PushNotification();

// For handling notification when the app is in terminated state
checkForInitialMessage() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // ignore: unused_local_variable
    PushNotification notification = PushNotification(
      title: initialMessage.notification?.title,
      body: initialMessage.notification?.body,
    );
  }
}

registerNotification() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseMessaging messaging;
  messaging = FirebaseMessaging.instance;
  var userBox = Hive.box('user');
  var existingToken = userBox.get('deviceToken');
  debugPrint("existing token: $existingToken");
  messaging.getToken().then((value) async {
    debugPrint("new token: $value");
    if (existingToken == null) {
      await userBox.put('deviceToken', value);
      // send to server
      await _pushNotificationServices.updateFcmToken(value!);
    } else {
      if (existingToken != value) {
        await userBox.put('deviceToken', value);
        // send to server
        await _pushNotificationServices.updateFcmToken(value!);
      }
    }
  });
  RemoteMessage? initialMessage = await messaging.getInitialMessage();
  // Handle background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // On iOS, this helps to take the user permissions
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted permission');
    // For handling the received notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Parse the message received
      notificationInfo = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );

      debugPrint(message.notification?.title ?? "Test");
    });
  } else {
    debugPrint('User declined or has not accepted permission');
  }
  if (initialMessage != null) {
    handleMessage(initialMessage);
  }
  // initialize local notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  final didNotificationLaunchApp =
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  if (didNotificationLaunchApp) {
    onSelectNotification(notificationAppLaunchDetails?.notificationResponse);
  }
  // when notification is received in foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    showLocalNotification(message);
  });
  // when notification is clicked / tapped / opened
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
    handleMessage(remoteMessage!);
  });
}

void handleMessage(RemoteMessage message) async {
  debugPrint("message data: ${message.data} ");
  //if (message.data["assign_job_id"] != null) {
  // Get.to(
  //   () => JobDetailsView(
  //     assignJobId: int.parse(message.data['assign_job_id']),
  //     viewmodel: DashboardViewmodel(),
  //   ),
  // );
  //}
}

Future<void> onSelectNotification(NotificationResponse? payload) async {
  debugPrint("on Select Notification");
  if (payload?.payload != null) {
    Map<String, dynamic> data = jsonDecode(payload?.payload ?? "");
    if (data['screen'] == "message") {
      debugPrint("on Select Notification");
    }
  }
}
