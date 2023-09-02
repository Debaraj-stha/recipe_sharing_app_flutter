import 'package:http/http.dart';
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
      String intro = 'create table intro(intro TEXT)';
      String user = 'create table user(email TEXT,name TEXT,image TEXT)';
      String search = 'create table search(query TEXT,id TEXT)';
      String saverecipe =
          'create table saverecipe(shareTitle Text,shareId Integer,image TEXT,title TEXT,description TEXT,ingredients Text,steps Text,hashtags Text,pk Integer,user Text,addedAt integer,totalReact integer,totalCount integer,totalShare integer,isShare Text,reaction Text,owner Text)';

      db.execute(intro);
      db.execute(user);
      db.execute(search);
      db.execute(saverecipe);
    });
    return db;
  }

  Future<bool> insertIntro(Intro i) async {
    var dbClient = await db;
    var status = await dbClient!.insert('intro', i.toJson());
    return true;
  }

  Future<List<Intro>> getIntro() async {
    var dbClient = await db;
    if (dbClient == null) {
      return [];
    } else {
      final List<Map<String, Object?>> intros = await dbClient.query(
        "intro",
      );
      return intros.map((e) => Intro.fromJson(e)).toList();
    }
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

  Future<bool> insertSearch(Search s) async {
    var dbClient = await db;
    await dbClient!.insert('search', s.toJson());
    return true;
  }

  Future<bool> deleteSearch(String id) async {
    var dbClient = await db;
    await dbClient!.delete('search', where: "id=?", whereArgs: [id]);
    return true;
  }

  Future<List<Search>> getSearch() async {
    var dbClient = await db;
    if (dbClient == null) {
      return [];
    } else {
      final List<Map<String, Object?>> search = await dbClient.query("search");
      return search.map((e) => Search.fromJson(e)).toList();
    }
  }

  Future<bool> insertRecipe(RecipeItem recipeItem) async {
    try {
      var dbClient = await db;
      await dbClient!.insert("saverecipe", recipeItem.toJson());
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
    Future<bool> deleteRecipe(int pk) async {
    try {
      var dbClient = await db;
      await dbClient!.delete("saverecipe",where: "pk=?",whereArgs: [pk]);
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
  Future<List<RecipeItem>> getRecipe() async {
    var dbClient=await db;
    if(dbClient==null){
      return [];
    }
    else{
      final List<Map<String, Object?>> result=await dbClient.query("saverecipe");
      return result.map((e) => RecipeItem.fromJson(e)).toList();
    }
  }
}
