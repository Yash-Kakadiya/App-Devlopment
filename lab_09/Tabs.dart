import 'package:flutter/material.dart';
import 'package:lab_06/lab_09/Home.dart';
import 'package:lab_06/lab_09/Page1.dart';
import 'package:lab_06/lab_09/Page2.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Sure! you to logout?"),
                            content: Text("Tink again"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {}, child: Text("Yes")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No"))
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.logout))
            ],
            bottom: TabBar(tabs: [
              Tab(
                text: "Home",
              ),
              Tab(
                text: "Page1",
              ),
              Tab(
                text: "Page2",
              )
            ]),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                    child: Text(
                  "Company name",
                  style: TextStyle(fontSize: 20),
                )),
                ListTile(
                  title: Text("Home"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  },
                ),
                ListTile(
                  title: Text("Page1"),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Page1()));
                  },
                ),
                ListTile(
                  title: Text("Page2"),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Page2()));
                  },
                ),
              ],
            ),
          ),
          body: TabBarView(children: [Home(), Page1(), Page2()]),
        ));
  }
}
