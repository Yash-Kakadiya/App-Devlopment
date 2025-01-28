import 'package:first_project/lab_13/page1_screen.dart';
import 'package:first_project/lab_13/page2_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    List list = [
      const Page1Screen(),
      const Page2Screen(),
    ];
    return Scaffold(
      body: list[idx],
      bottomNavigationBar: BottomNavigationBar(0
          iconSize: 30,
          showUnselectedLabels: false,
          selectedItemColor: Colors.red,
          selectedFontSize: 25,
          unselectedFontSize: 15,
          onTap: (value) {
            setState(() {
              idx = value;
            });
          },
          currentIndex: idx,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
              ),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.call,
              ),
              label: 'Calls',
            ),
          ]),
    );
  }
}
