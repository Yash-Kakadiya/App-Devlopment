import 'package:flutter/material.dart';
import 'package:matrimony_app/screens/add_edit_user_screen.dart';
import 'package:matrimony_app/screens/dashboard_screen.dart';
import 'package:matrimony_app/screens/onboarding_screen.dart';
import 'package:matrimony_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matrimony App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
