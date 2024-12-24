import 'package:first_project/lab_07/text.dart';
import 'package:flutter/material.dart';

import 'hello_world.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Write a flutter code to display “hello world” using Text widget. Change color & size of text using different properties.
  // Write a flutter code to create a custom Text widget with different fonts & use it.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Hello World',
  //     home: HelloWorld(),
  //   );
  // }

  // Write a flutter code to use TextField and print the input value into the terminal using the controller.
  // Write a flutter code to create a custom Text widget with different fonts & use it.
  // Write a flutter code to use TextField and print the input value into the terminal using the controller.
  // Write a flutter code to use TextField & apply different borders, floating labels, hint text etc.
  // Write a flutter code to print TextField value into Text widget on a click of a Button
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TextField',
      home: TextFieldEx(),
    );
  }
}
