import 'package:khardel/models/user.dart';

class RefreshToken {
  var id;
  String token;
  User userId;
  DateTime expiryDate;

  RefreshToken({
    this.id,
    this.userId,
    this.token,
    this.expiryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "user": userId,
      "token": token,
      "expiryDate": expiryDate,
    };
  }

  factory RefreshToken.fromJson(Map<String, dynamic> item) {
    return RefreshToken(
      id: item['id'],
      userId: item['user'],
      token: item['token'],
      expiryDate: item['expiryDate'],
    );
  }
}
