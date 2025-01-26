import 'package:first_project/CRUD%20UI/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormEntry extends StatefulWidget {
  const FormEntry({super.key});

  @override
  State<FormEntry> createState() => _FormEntryState();
}

class _FormEntryState extends State<FormEntry> {
  List<Model> studentlist = [];
  List<Model> filteredlist = [];
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController rollcontroller = TextEditingController();
  int select = -1;

  @override
  void initState() {
    super.initState();
    // Initially filtered list is the same as the student list
    filteredlist = List.from(studentlist);
  }

  void filterContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        // Show all students if search query is empty
        filteredlist = List.from(studentlist);
      } else {
        // Filter based on the query
        filteredlist = studentlist
            .where((c) => c.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CRUDS Operation",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter a name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
            ),
            SizedBox(height: 10),
            TextField(
              controller: rollcontroller,
              maxLength: 3,
              decoration: InputDecoration(
                  labelText: "RollNo",
                  hintText: "Enter a rollno",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String name = namecontroller.text.trim();
                      String rollno = rollcontroller.text.trim();
                      setState(() {
                        if (name.isNotEmpty && rollno.isNotEmpty) {
                          studentlist.add(Model(name: name, rollno: rollno));
                          namecontroller.text = '';
                          rollcontroller.text = '';
                          filteredlist = studentlist;
                        }
                      });
                    },
                    child: Text(
                      "ADD",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      String name = namecontroller.text.trim();
                      String rollno = rollcontroller.text.trim();
                      setState(() {
                        if (name.isNotEmpty && rollno.isNotEmpty && select != -1) {
                          namecontroller.text = '';
                          rollcontroller.text = '';
                          studentlist[select].name = name;
                          studentlist[select].rollno = rollno;
                          filteredlist = studentlist;
                          select = -1;
                        }
                      });
                    },
                    child: Text(
                      "UPDATE",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  "List of Students: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ],
            ),
            TextField(
              controller: searchcontroller,
              onChanged: filterContacts,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search by name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
            ),
            SizedBox(height: 20),
            filteredlist.isEmpty
                ? Text("No data of Students")
                : Expanded(
              child: ListView.builder(
                itemCount: filteredlist.length,
                itemBuilder: (context, index) {
                  return getList(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getList(i) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(filteredlist[i].name![0]),
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.blue,
        ),
        title: Text(filteredlist[i].name!),
        subtitle: Text(filteredlist[i].rollno!),
        trailing: SizedBox(
          width: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("DELETE"),
                          content: Text("Are you Sure??"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    studentlist.removeAt(i);
                                    filteredlist.removeAt(i);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text("YES")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("NO"))
                          ],
                        );
                      });
                },
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      namecontroller.text = filteredlist[i].name!;
                      rollcontroller.text = filteredlist[i].rollno!;
                      select = studentlist.indexOf(filteredlist[i]); // Find index in the main list
                    });
                  },
                  icon: Icon(Icons.edit))
            ],
          ),
        ),
      ),
    );
  }
}
