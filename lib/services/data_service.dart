import 'dart:async';
import 'package:flutter_test_app/interfaces/data_service_interface.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataService implements DataServiceInterface {
  late Future<Database> _database;

  DataService() {
    openLocalDatabase();
  }

  void openLocalDatabase() async {
    _database = openDatabase(
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
    final db = await _database;

    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ? AND password = ?',
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
  Future<void> insertUser(User user) async {
    final db = await _database;

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<List<User>> getUsers() async {
    final db = await _database;

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
    final db = await _database;

    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  @override
  Future<void> deleteUser(int id) async {
    final db = await _database;

    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
