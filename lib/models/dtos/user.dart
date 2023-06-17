import 'package:flutter_test_app/models/entities/user.dart';

class UserDto {
  late int id;
  late String email;
  late String password;

  User toEntity() {
    return User(id: id, email: email, password: password);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
