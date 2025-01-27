import './string_const.dart';

class UserModel {
  static List<Map<String, dynamic>> userList = [
    {
      NAME: 'Yash',
      EMAIL: 'yash123@gmail.com',
      PASSWORD: 'Yash@123',
      MOBILE: '1234567890',
      DOB: '01-12-2005',
      AGE: '20',
      CITY: 'Rajkot',
      GENDER: 'male',
      HOBBIES: [
        'Video Games 🎮',
        'Reading 📖',
        'Music 📻',
      ],
      ISFAVORITE: true,
    },
    {
      NAME: 'Yash',
      EMAIL: 'yash123@gmail.com',
      PASSWORD: 'Yash@123',
      MOBILE: '1234567890',
      DOB: '01-12-2005',
      AGE: '20',
      CITY: 'Rajkot',
      GENDER: 'male',
      HOBBIES: [
        'Video Games 🎮',
        'Reading 📖',
        'Music 📻',
      ],
      ISFAVORITE: true,
    },
  ];

  static void addUser({
    required String name,
    required String email,
    required String password,
    required String mobile,
    required String dob,
    required String age,
    required String city,
    required String gender,
    required List hobbies,
    bool isFavorite = false,
  }) {
    Map<String, dynamic> user = {};
    user[NAME] = name;
    user[EMAIL] = email;
    user[PASSWORD] = password;
    user[MOBILE] = mobile;
    user[DOB] = dob;
    user[AGE] = age;
    user[CITY] = city;
    user[GENDER] = gender;
    user[HOBBIES] = hobbies;
    user[ISFAVORITE] = isFavorite;
    userList.add(user);
  }

  static List<Map<String, dynamic>> getUserList() {
    //region getUserList
    return userList;
    //endregion
  }

  static void updateUser({
    required int id,
    required String name,
    required String email,
    required String password,
    required String mobile,
    required String dob,
    required String age,
    required String city,
    required String gender,
    required List hobbies,
  }) {
    Map<String, dynamic> user = {};
    user[NAME] = name;
    user[EMAIL] = email;
    user[PASSWORD] = password;
    user[MOBILE] = mobile;
    user[DOB] = dob;
    user[AGE] = age;
    user[CITY] = city;
    user[HOBBIES] = hobbies;
    userList[id] = user;
  }

  static void removeUser({required id}) {
    //region removeUser
    userList.removeAt(id);
    //endregion
  }
}
