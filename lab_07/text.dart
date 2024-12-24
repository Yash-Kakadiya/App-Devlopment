// Write a flutter code to use TextField and print the input value into the terminal using the controller.
// Write a flutter code to create a custom Text widget with different fonts & use it.
// Write a flutter code to use TextField and print the input value into the terminal using the controller.
// Write a flutter code to use TextField & apply different borders, floating labels, hint text etc.
// Write a flutter code to print TextField value into Text widget on a click of a Button

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldEx extends StatefulWidget {
  @override
  State<TextFieldEx> createState() => _TextFieldExState();
}

class _TextFieldExState extends State<TextFieldEx> {
  TextEditingController phoneController = TextEditingController();
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(border: OutlineInputBorder()))),
          ElevatedButton(
              onPressed: () {
                print('Click value: ${phoneController.text}');
                setState(() {
                  value = phoneController.text;
                  phoneController.text = '';
                });
              },
              child: Text("Click",style: GoogleFonts.aboreto(fontSize:35, color: Colors.orange)),
          ),
          Text(value,
              style: GoogleFonts.aguafinaScript(fontSize:70, color: Colors.orange))
        ],
      ),
    );
  }
}
