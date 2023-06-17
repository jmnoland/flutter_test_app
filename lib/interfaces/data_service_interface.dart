import 'package:flutter_test_app/models/dtos/user.dart';
import 'package:flutter_test_app/models/entities/user.dart';

abstract class DataServiceInterface {
  Future<bool> login(String email, String password);
  Future<void> insertUser(UserDto user);
  Future<List<User>> getUsers();
  Future<void> updateUser(User user);
  Future<void> deleteUser(int id);
}
