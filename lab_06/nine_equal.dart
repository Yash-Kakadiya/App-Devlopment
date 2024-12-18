// Write a flutter code to divide the vertical space of the screen in 3 different equal parts with different colors.

import 'package:flutter/material.dart';

class NineEqualParts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nine Equal Parts'),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Container(
                color: Colors.red,
              )),
              Expanded(
                  child: Container(
                color: Colors.white,
              )),
              Expanded(
                  child: Container(
                color: Colors.blue,
              ))
            ],
          )),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Container(
                color: Colors.white,
              )),
              Expanded(
                  child: Container(
                color: Colors.blue,
              )),
              Expanded(
                  child: Container(
                color: Colors.red,
              ))
            ],
          )),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Container(
                color: Colors.blue,
              )),
              Expanded(
                  child: Container(
                color: Colors.white,
              )),
              Expanded(
                  child: Container(
                color: Colors.red,
              ))
            ],
          ))
        ],
      ),
    );
  }
}
