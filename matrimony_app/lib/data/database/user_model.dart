import 'database_helper.dart';

/// UserModel provides CRUD operations on the common 'users' table.
class UserModel {
  static const String tableName = 'users';

  /// Adds a new user to the common data.
  static Future<int> addUser(Map<String, dynamic> user) async {
    int id = await DatabaseHelper.instance.createUser(user);
    print('User Added with id: $id');
    return id;
  }

  /// Retrieves a user by [id] from the common data.
  static Future<Map<String, dynamic>?> getUser(int id) async {
    return await DatabaseHelper.instance.getUser(id);
  }

  /// Retrieves all users from the common data.
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    return await DatabaseHelper.instance.getAllUsers();
  }

  /// Updates the user with the given [id] in the common data.
  static Future<bool> updateUser(int id, Map<String, dynamic> updatedUser) async {
    int result = await DatabaseHelper.instance.updateUser(id, updatedUser);
    return result > 0;
  }

  /// Deletes the user with the given [id] from the common data.
  static Future<bool> deleteUser(int id) async {
    int result = await DatabaseHelper.instance.deleteUser(id);
    return result > 0;
  }
}
