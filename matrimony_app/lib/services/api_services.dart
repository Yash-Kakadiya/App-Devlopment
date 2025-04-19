import 'dart:convert';
import 'package:http/http.dart' as http;

/// A service class that handles API calls for user operations.
class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  /// Fetch a single user by [id].
  Future<Map<String, dynamic>> getUser(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  /// Fetch all users.
  Future<List<dynamic>> getAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  /// Add a new user.
  /// Assumes that the API returns the created user with its ID.
  Future<String> addUser(Map<String, dynamic> user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['id']; // Assumes API returns JSON with an "id" field.
    } else {
      throw Exception('Failed to add user');
    }
  }

  /// Update an existing user.
  Future<bool> updateUser(String id, Map<String, dynamic> user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user),
    );
    return response.statusCode == 200;
  }

  /// Delete a user.
  Future<bool> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    return response.statusCode == 200;
  }
}
