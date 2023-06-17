import 'dart:async';
import 'package:flutter_test_app/interfaces/data_service_interface.dart';
import 'package:flutter_test_app/models/dtos/user.dart';
import 'package:flutter_test_app/models/entities/user.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@Injectable(as: DataServiceInterface)
class DataService implements DataServiceInterface {
  late Database _database;

  Future openLocalDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, email TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<bool> login(String email, String password) async {
    final db = _database;

    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        email: maps[i]['email'],
        password: maps[i]['password'],
      );
    }).isNotEmpty;
  }

  @override
  Future<void> insertUser(UserDto user) async {
    final db = _database;

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<List<User>> getUsers() async {
    final db = _database;

    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        email: maps[i]['email'],
        password: maps[i]['password'],
      );
    });
  }

  @override
  Future<void> updateUser(User user) async {
    final db = _database;

    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  @override
  Future<void> deleteUser(int id) async {
    final db = _database;

    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
