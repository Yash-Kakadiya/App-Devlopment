import 'package:first_project/lab_13/home_screen.dart';
import 'package:first_project/lab_13/page1_screen.dart';
import 'package:flutter/material.dart';

class Page2Screen extends StatefulWidget {
  const Page2Screen({super.key});

  @override
  State<Page2Screen> createState() => _Page2ScreenState();
}

class _Page2ScreenState extends State<Page2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Page 2',
          style: TextStyle(fontSize: 40),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const Page1Screen();
                    });
              },
              child: const Text('Page 1'))
        ],
      ),
    );
  }
}
