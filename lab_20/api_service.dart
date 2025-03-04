import 'dart:convert';
import '../lab_19/user.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  String baseUrl = "https://6671937fe083e62ee43c341e.mockapi.io/Students";

  Future<List<User>> getAllUser() async {
    var res = await http.get(Uri.parse(baseUrl));
    List<dynamic> data = jsonDecode(res.body);
    List<User> users = [];
    data.forEach((element) {
      users.add(User.toUser(element));
    });
    return users;
  }

  Future<User> getUserById(String id) async {
    var res = await http.get(Uri.parse("$baseUrl/$id"));
    dynamic data = jsonDecode(res.body);
    User user = User.toUser(data);
    return user;
  }

  Future<void> addUser(User user) async {
    var res = await http.post(Uri.parse(baseUrl), body: user.toMap());
    print(res.body);
    print(res.statusCode);
  }

  Future<void> deleteUser(String id) async {
    var res = await http.delete(Uri.parse("$baseUrl/id"));
  }
}
