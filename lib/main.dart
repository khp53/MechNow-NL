import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hackathon_user_app/firebase_options.dart';
import 'package:hackathon_user_app/modules/onboard/onboard_view.dart';
import 'package:hackathon_user_app/dependencies/dependency_injection.dart'
    as di;
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          headlineSmall: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: Color(0xFFA1A6B0),
          ),
          bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme(
          primary: Color(0xFFFFC801),
          secondary: Color(0xFFA1A6B0),
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ).copyWith(background: Colors.white, surface: Colors.white),
      ),
      home: const OnboardView(),
    );
  }
}
