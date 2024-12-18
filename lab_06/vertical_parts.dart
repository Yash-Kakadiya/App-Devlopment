// Write a flutter code to divide the vertical space of the screen in 3 different equal parts with different colors.

import 'package:flutter/material.dart';

class VerticalParts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vertical Parts'),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.deepOrange,
                border: Border.all(color: Colors.black, width: 3)),
          )),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3)),
          )),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: Colors.black, width: 3)),
          ))
        ],
      ),
    );
  }
}
