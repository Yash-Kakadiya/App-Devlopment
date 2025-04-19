import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin.dart';

class AdminPrefs {
  // Key used to store the list of admin JSON strings.
  static const String adminKey = 'adminList';

  /// Saves the list of admins to SharedPreferences.
  /// Each admin is converted to a JSON string.
  static Future<void> saveAdmins(List<Admin> admins) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert each Admin object to a Map and then encode it as a JSON string.
    List<String> adminStrings = admins.map((admin) {
      Map<String, dynamic> adminMap = {
        'username': admin.username,
        'password': admin.password,
      };
      return jsonEncode(adminMap);
    }).toList();
    await prefs.setStringList(adminKey, adminStrings);
  }

  /// Retrieves the list of admins from SharedPreferences.
  static Future<List<Admin>> getAdmins() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? adminStrings = prefs.getStringList(adminKey);
    if (adminStrings != null) {
      return adminStrings.map((s) {
        Map<String, dynamic> adminMap = jsonDecode(s);
        return Admin(
          username: adminMap['username'],
          password: adminMap['password'],
        );
      }).toList();
    }
    return [];
  }
}
