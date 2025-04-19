import 'api_services.dart';

/// UserModel provides CRUD operations on the common 'users' list via API calls.
class UserModel {
  // Create a singleton instance of ApiService with your API's base URL.
  static final ApiService apiService = ApiService(
      baseUrl: 'https://67cd19d2dd7651e464ed60a1.mockapi.io/heartlink');

  /// Adds a new user using the API.
  static Future<String> addUser(Map<String, dynamic> user) async {
    String id = await apiService.addUser(user);
    print('User added with id: $id');
    return id;
  }

  /// Retrieves a user by [id] using the API.
  static Future<Map<String, dynamic>?> getUser(String id) async {
    print('model : $id');
    dynamic user = await apiService.getUser(id);
    print('user::::::::::::::$user');
    return user;
  }

  /// Retrieves all users using the API.
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    List<dynamic> data = await apiService.getAllUsers();
    // Convert each element to Map<String, dynamic>
    return List<Map<String, dynamic>>.from(data);
  }

  /// Updates the user with the given [id] using the API.
  static Future<bool> updateUser(
      String id, Map<String, dynamic> updatedUser) async {
    return await apiService.updateUser(id, updatedUser);
  }

  /// Deletes the user with the given [id] using the API.
  static Future<bool> deleteUser(String id) async {
    return await apiService.deleteUser(id);
  }
}
