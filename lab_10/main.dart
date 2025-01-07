import 'package:flutter/material.dart';
import 'package:untitled/Lab%208/pr2.dart';

import 'demoForm.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoForm(),
      title: 'Registration Form',
      debugShowCheckedModeBanner: false,
    );
  }
}
