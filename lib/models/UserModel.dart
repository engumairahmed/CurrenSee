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
      id: json["id"],
      name: json["name"],
      email: json["email"],
      password: json["password"]
    );
  }
}