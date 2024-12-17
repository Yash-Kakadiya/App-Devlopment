class User {
  List<Map<String, dynamic>> userList = [];

  void addUser({required name, required age, required email}) {
    //region addUser
    Map<String, dynamic> user = {};
    user['name'] = name;
    user['age'] = age;
    user['email'] = email;
    userList.add(user);
    //endregion
  }

  List<Map<String, dynamic>> getUserList() {
    //region getUserList
    return userList;
    //endregion
  }

  void updateUser({required id, required name, required age, required email}) {
    //region updateUser
    Map<String, dynamic> user = {};
    user['name'] = name;
    user['age'] = age;
    user['email'] = email;
    userList[id] = user;
    //endregion
  }

  void removeUser({required id}) {
    //region removeUser
    userList.removeAt(id);
    //endregion
  }
}
