import 'package:first_project/lab_06/horizontal_parts.dart';
import 'package:first_project/lab_06/nine_equal.dart';
import 'package:first_project/lab_06/vertical_parts.dart';
import 'package:flutter/material.dart';

import 'nine_non_equal_parts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//Write a flutter code to divide horizontal space of screen in 3 different equal parts with different colors.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horizontal Parts',
      home: HorizontalParts(),
    );
  }

  //Write a flutter code to divide the vertical space of the screen in 3 different equal parts with different colors.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Vertical Parts',
  //     home: VerticalParts(),
  //   );
  // }

// Write a flutter code to divide the vertical space of the screen in 3 different equal parts with different colors.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Nine Equal Parts',
//       home: NineEqualParts(),
//     );
//   }

  //

  // Write a flutter code to divide the whole screen into 9 different size with different colors.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Nine Non Equal Parts',
  //     home: NineNonEqualParts(),
  //   );
  // }
}
