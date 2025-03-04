class User{
  late String id;
  late String name;

  User({required this.id , required this.name});

  static User toUser(Map<String,dynamic> u){
    return User(id: u["id"], name: u["name"]);
  }

  Map<String , dynamic> toMap(){
    return {"id" : this.id , "name" : this.name};
  }

}