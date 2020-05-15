import 'dart:async';
import 'package:flutter_app1/model/note.dart';
import 'package:flutter_app1/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {
  static Database database;

  Future opentDb() async {
    if (database == null) {
      String path = join(await getDatabasesPath(), 'todolist.db');
      database = await openDatabase(path, version: 1, onCreate: initDb);
    }
  }

  initDb(Database db, int version) async {
     await db.execute("CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT , date DATE)");
     await db.execute("CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , password TEXT , email TEXT )");
  }

  // USER
  Future<int> addUser(User user) async {
    await opentDb();
    return await database.insert('user', user.toMap());
  }

  Future<User> checkLoginUser(String email,String password) async {
    await opentDb();
    var reponse =
        await database.rawQuery("SELECT * FROM user WHERE email = '$email' AND password = '$password'");
    if (reponse.length == 0) {
      return null;
    } else {
      return User.fromMap(reponse.first);
    }
  }

  Future<int> getNameUser(int id) async{
    await opentDb();
   await database.rawQuery("SELECT user.name from user WHERE id = $id ");
  }




}
