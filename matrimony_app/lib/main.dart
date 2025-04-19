import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for orientation lock
import 'package:matrimony_app/screens/add_edit_user_screen.dart';
import 'package:matrimony_app/screens/dashboard_screen.dart';
import 'package:matrimony_app/screens/onboarding_screen.dart';
import 'package:matrimony_app/screens/select_admin_screen.dart';
import 'package:matrimony_app/screens/splash_screen.dart';
import 'package:matrimony_app/screens/welcome_back_screen.dart';

import 'core/app_colors.dart';

void main() {
  // Lock the app to portrait mode
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Portrait mode only
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeartLink.net',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
