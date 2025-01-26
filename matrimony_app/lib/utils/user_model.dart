class UserModel {
  List<Map<String, dynamic>> userList = [];

  void addUser({required String name}) {
  }

  List<Map<String, dynamic>> getUserList() {
    //region getUserList
    return userList;
    //endregion
  }

  void updateUser({required int id}) {
  }

  void removeUser({required id}) {
    //region removeUser
    userList.removeAt(id);
    //endregion
  }
}
