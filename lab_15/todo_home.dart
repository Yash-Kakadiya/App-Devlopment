import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo HomePage'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
