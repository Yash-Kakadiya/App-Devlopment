import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class JsonDisplayScreen extends StatefulWidget {
  @override
  _JsonDisplayScreenState createState() => _JsonDisplayScreenState();
}

class _JsonDisplayScreenState extends State<JsonDisplayScreen> {
  List<dynamic> data = [];

  // Function to load JSON data from the asset
  Future<void> loadJsonData() async {
    // Load the JSON from the asset file
    String jsonString = await rootBundle.loadString('assets/data.json');

    // Decode the JSON string into a List of objects
    final List parsedList = json.decode(jsonString);

    setState(() {
      data = parsedList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadJsonData(); // Load data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON Data Display"),
      ),
      body: data.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching data
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var item = data[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('Age: ${item['age']}'),
                );
              },
            ),
    );
  }
}
