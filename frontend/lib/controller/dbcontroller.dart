import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../model/model.dart';

class dbController {
  static Database? database;
  Future<Database?> get db async {
    if (database != null) {
      return database;
    } else {
      database = await initializeDatabase();
      return database;
    }
  }

  Future<Database?> initializeDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.toString(), "sqlitedb.db");
    var db = openDatabase(path, version: 1, onCreate: (db, version) {
      String sql1 = 'create table intro(intro TEXT)';
      String user = 'create table user(email TEXT,name TEXT,image TEXT)';
      db.execute(sql1);
      db.execute(user);
    });
    return db;
  }

  Future<bool> insertUser(User user) async {
    var dbClient = await db;
    var status = await dbClient!.insert('user', user.toJson());
    return true;
  }

  Future<bool> deleteUser(String email) async {
    var dbClient = await db;
    var status =
        await dbClient!.delete('user', where: "email=?", whereArgs: [email]);
    return true;
  }

  Future<bool> updateUser(String email, User user) async {
    var dbClient = await db;
    var status = await dbClient!
        .update("user", user.toJson(), where: "email=?", whereArgs: [email]);
    return true;
  }

  Future<List<User>> getUser(String email) async {
    var dbClient = await db;
    if (dbClient == null) {
      return [];
    } else {
      final List<Map<String, Object?>> user =
          await dbClient.query("user", where: "email=?", whereArgs: [email]);
      return user.map((e) => User.fromJson(e)).toList();
    }
  }
}
