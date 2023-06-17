import 'package:flutter_test_app/models/user.dart';

abstract class DataServiceInterface {
  Future<bool> login(String email, String password);
  Future<void> insertUser(User user);
  Future<List<User>> getUsers();
  Future<void> updateUser(User user);
  Future<void> deleteUser(int id);
}
