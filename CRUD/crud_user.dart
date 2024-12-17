//CRUD in userlist

import 'dart:io';
import 'package:first_project/CRUD/user.dart';

void main() {
  User userObj = User();

  int n;
  do {
    print('Options:'
        '\n 1. Create User'
        '\n 2. Get User List'
        '\n 3. Update User'
        '\n 4. Remove User'
        '\n 5. Exit');
    stdout.write('Enter Option: ');
    n = int.parse(stdin.readLineSync()!);

    switch (n) {
      case 1:
        stdout.write('Enter User Name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter User Age: ');
        int age = int.parse(stdin.readLineSync()!);
        stdout.write('Enter User Email: ');
        String email = stdin.readLineSync()!;
        userObj.addUser(name: name, age: age, email: email);
        break;
      case 2:
        List<Map<String, dynamic>> userList = userObj.getUserList();
        for (var element in userList) {
          print('Name: ${element['name']} '
              '\n Age: ${element['age']}'
              ' \n Email: ${element['email']} |');
        }
        break;
      case 3:
        stdout.write('Enter User Id to update user: ');
        int id = int.parse(stdin.readLineSync()!);
        stdout.write('Enter User Name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter User Age: ');
        int age = int.parse(stdin.readLineSync()!);
        stdout.write('Enter User Email: ');
        String email = stdin.readLineSync()!;
        userObj.updateUser(id: id, name: name, age: age, email: email);
        break;
      case 4:
        stdout.write('Enter User Id remove user: ');
        int id = int.parse(stdin.readLineSync()!);
        userObj.removeUser(id: id);
        break;
      case 5:
        print('Exting...');
      default:
        print('Invalid Option');
    }
  } while (n != 5);
}
