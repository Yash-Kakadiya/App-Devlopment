import 'package:flutter/material.dart';

class CityGrid extends StatelessWidget {
  CityGrid({super.key});
  final List<String> list = [
    'City is Rajkot',
    'City is Rajkot',
    'City is Rajkot',
    'City is Rajkot',
    'City is Rajkot',
    'City is Rajkot',
    'City is Rajkot',
    'City is Rajkot',
    'City is Rajkot',
    'City is Rajkot',
    'City is Rajkot',
    'City is Rajkot'
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemCount: list.length,
      itemBuilder: (_, index) => card(index),
    );
  }

  Widget card(int i) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              list[i],
              style: TextStyle(fontSize: 30, color: Colors.orange),
            )
          ],
        ),
      ),
    );
  }
}