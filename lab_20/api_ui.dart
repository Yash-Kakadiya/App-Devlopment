import 'package:first_project/lab_20/user_profile.dart';
import 'package:flutter/material.dart';

import '../lab_19/user.dart';
import 'api_service.dart';

class ApiUI extends StatefulWidget {
  const ApiUI({super.key});

  @override
  State<ApiUI> createState() => _ApiUIState();
}

class _ApiUIState extends State<ApiUI> {
  @override
  Widget build(BuildContext context) {
    Apiservice apiservice = Apiservice();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Api Demo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: apiservice.getAllUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<User>? user = snapshot.data;
            return ListView.builder(
              itemCount: user?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text(
                        user![index].name[0],
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          user![index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              await apiservice.deleteUser(user![index].id);
                              setState(() {});
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                    subtitle: Text("RollNo: " + user![index].id),
                    trailing: Icon(Icons.arrow_forward_ios_sharp),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserProfile(
                          id: user[index].id,
                        ),
                      ));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
                child: Text(
              "Error",
              style: TextStyle(fontSize: 30),
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        tooltip: 'Add User',
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Enter name'),
                content: TextFormField(
                    // controller: nameController,
                    ),
              );
            },
          );
        },
      ),
    );
  }
}
