// Write a flutter code to display “hello world” using Text widget. Change color & size of text using different properties.
//Write a flutter code to create a custom Text widget with different fonts & use it.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelloWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Hello World',
              style: GoogleFonts.roboto(fontSize: 50, color: Colors.orange))
        ],
      ),
    );
  }
}
