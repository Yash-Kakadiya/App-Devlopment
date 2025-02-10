import 'package:matrimony_app/utils/string_constants.dart';

class UserModel {
  // Our in-memory "database" of users.
  static List<Map<String, dynamic>> userList = [
    {
      NAME: "Prof. Mehul Bhundiya",
      EMAIL: "mehul.bhundiya@darshan.ac.in",
      PASSWORD: "Mehul@123",
      PHONE: "9428231065",
      GENDER: "male",
      BIRTHDATE: "01/01/2000",
      AGE: '25',
      HEIGHT: "5'9 ft",
      WEIGHT: "75 kg",
      HOBBIES: [
        'Travel 🌍',
        'Cooking 🍳',
        'Reading 📚',
        'Fitness 🏋️',
        'Music 🎵',
      ],
      EDUCATION: "Master's Degree",
      OCCUPATION: "Software Engineer",
      EMPLOYED_IN: "Private Sector",
      INCOME: "Above ₹12,00,000",
      MARITAL_STATUS: "Never Married",
      MOTHER_TONGUE: "English",
      RELIGION: "Hinduism 🕉️",
      COUNTRY: "USA",
      STATE: "California",
      CITY: "Los Angeles",
      ISFAVORITE: true,
    },
    {
      NAME: "Yash Kakadiya",
      EMAIL: "23010101121@darshan.ac.in",
      PASSWORD: "Yash@123",
      PHONE: "9876541230",
      GENDER: "male",
      BIRTHDATE: "01/12/2005",
      AGE: '19',
      HEIGHT: "6'0 ft",
      WEIGHT: "70 kg",
      HOBBIES: [
        'Reading 📚',
        'Fitness 🏋️',
        'Music 🎵',
        'Movies 🎬',
        'Gaming 🎮',
        'Technology 💻',
      ],
      EDUCATION: "Bachelor\'s Degree",
      OCCUPATION: "Business Owner",
      EMPLOYED_IN: "Self-Employed",
      INCOME: "Above ₹12,00,000",
      MARITAL_STATUS: "Never Married",
      MOTHER_TONGUE: "'Gujarati'",
      RELIGION: "Hinduism 🕉️",
      COUNTRY: "India",
      STATE: "Gujarat",
      CITY: "Rajkot",
      ISFAVORITE: true,
    },
    {
      NAME: "Pooja",
      EMAIL: "pooja123@gmail.com",
      PASSWORD: "Pooja@123",
      PHONE: "1236541230",
      GENDER: "female",
      BIRTHDATE: "01/10/2005",
      AGE: '19',
      HEIGHT: "5'5 ft",
      WEIGHT: "55 kg",
      HOBBIES: [
        'Reading 📚',
        'Fitness 🏋️',
        'Music 🎵',
        'Movies 🎬',
        'Gaming 🎮',
      ],
      EDUCATION: "Bachelor\'s Degree",
      OCCUPATION: "Business Owner",
      EMPLOYED_IN: "Self-Employed",
      INCOME: "Above ₹12,00,000",
      MARITAL_STATUS: "Never Married",
      MOTHER_TONGUE: "'Gujarati'",
      RELIGION: "Hinduism 🕉️",
      COUNTRY: "India",
      STATE: "Gujarat",
      CITY: "Rajkot",
      ISFAVORITE: false,
    },
  ];

  /// CREATE: Adds a new user.
  /// The user map must contain every detail using the defined keys.
  static void addUser(Map<String, dynamic> user) {
    userList.add(user);
    print('User Added. from model');
    print('UserList $userList');
  }

  /// READ: Returns the user at [index], or null if the index is invalid.
  static Map<String, dynamic>? getUser(int index) {
    if (index >= 0 && index < userList.length) {
      return userList[index];
    }
    return null;
  }

  /// READ: Returns all users.
  static List<Map<String, dynamic>> getAllUsers() {
    return userList;
  }

  /// UPDATE: Updates the user at [index] with [updatedUser] details.
  /// Returns true if the update was successful.
  static bool updateUser(int index, Map<String, dynamic> updatedUser) {
    if (index >= 0 && index < userList.length) {
      userList[index] = updatedUser;
      print('User updated. fro model');
      print('UserList $userList');
      return true;
    }
    return false;
  }

  /// DELETE: Removes the user at [index].
  /// Returns true if the deletion was successful.
  static Future<bool> deleteUser(int index) async {
    if (index >= 0 && index < userList.length) {
      userList.removeAt(index);
      print('user deleted');
      return true;
    }
    return false;
  }
}
