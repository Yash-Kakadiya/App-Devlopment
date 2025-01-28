import 'package:flutter/material.dart';

import '../LAB10/login_screen.dart';

class Page1Screen extends StatefulWidget {
  const Page1Screen({super.key});

  @override
  State<Page1Screen> createState() => _Page1ScreenState();
}

class _Page1ScreenState extends State<Page1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Page 1',
          style: TextStyle(fontSize: 40),
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const LoginScreen();
                      });
                },
                child: const Text('Form'))
          ],
        ),
      ),
    );
  }
}
