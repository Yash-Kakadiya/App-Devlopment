import 'dart:convert';
import 'package:first_project/lab_19/user.dart';
import 'package:flutter/material.dart';

class JsonDemo extends StatefulWidget {
  const JsonDemo({super.key});

  @override
  State<JsonDemo> createState() => _JsonDemoState();
}

class _JsonDemoState extends State<JsonDemo> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    getList();
  }

  Future<void> getList() async {
    String response = await DefaultAssetBundle.of(context)
        .loadString('assets/data.json');
    List<dynamic> data = jsonDecode(response);

    List<User> loadedUsers = [];
    for (var element in data) {
      loadedUsers.add(User.toUser(element));
    }
    setState(() {
      users = loadedUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Demo'),
        backgroundColor: Colors.blue,
      ),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(child: Text(user.id)),
            title: Text(user.name),
          );
        },
      ),
    );
  }
}
