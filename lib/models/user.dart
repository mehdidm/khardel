import 'package:khardel/models/role.dart';

class User {
  var id;
  String username;
  String email;
  String password;
 List<String> role;

  User(
      {this.id,
        this.username,
        this.email,
        this.password,
        this.role,
      });
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "username": username,
      "email": email,
      "password": password,
      "roles":role,
    };
  }

  factory User.fromJson(Map<String, dynamic> item) {
    return User(
      id: item['_id'],
      username: item['username'],
      email: item['email'],
      password: item['password'],
      role: item['roles'].cast<String>(),
    );
  }
}
