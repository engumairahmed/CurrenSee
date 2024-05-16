// ignore: file_names
class UserModel{
  late String id;
  late String name;
  late String email;
  late String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password
});

  static UserModel convertFromJson(Map<String, dynamic> json){
    return UserModel(
      id: json["User_ID"],
      name: json["Name"],
      email: json["Email"],
      password: json["Password"]
    );
  }
}