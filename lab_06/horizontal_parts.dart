//Write a flutter code to divide horizontal space of screen in 3 different equal parts with different colors.

import 'package:flutter/material.dart';

class HorizontalParts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal Parts'),
        backgroundColor: Colors.yellow,
      ),
      body: Row(
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
