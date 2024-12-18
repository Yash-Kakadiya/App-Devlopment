// Write a flutter code to divide the whole screen into 9 different size with different colors.

import 'package:flutter/material.dart';

class NineNonEqualParts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nine Non Equal Parts'),
        backgroundColor: Colors.yellow,
      ),
      body: Row(
        children: [
          Expanded(
              child: Column(
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
                    color: Colors.blue,
                    border: Border.all(color: Colors.black, width: 3)),
              ))
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.black, width: 3)),
                ),
                flex: 2,
              ),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.black, width: 3)),
                  ),
                  flex: 2),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 3)),
              ))
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Expanded(
                  child: Container(
                color: Colors.blue,
              )),
              Expanded(
                child: Container(
                  color: Colors.red,
                ),
                flex: 3,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
                flex: 2,
              )
            ],
          ))
        ],
      ),
    );
  }
}
