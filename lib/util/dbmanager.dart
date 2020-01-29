import 'dart:async';
import 'package:flutter_app1/model/note.dart';
import 'package:flutter_app1/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {
  Database _database;

  Future opentDb() async {
    if (_database == null) {
      String path = join(await getDatabasesPath(), 'todolist.db');
      _database = await openDatabase(path, version: 1, onCreate: initDb);
    }
  }

  initDb(Database db, int version) async {
     await db.execute("CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT , date DATE)");
     await db.execute("CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , password TEXT , email TEXT )");
  }

  // USER
  Future<int> addUser(User user) async {
    await opentDb();
    return await _database.insert('user', user.toMap());
  }

  Future<User> checkLoginUser(String email) async {
    await opentDb();
    var reponse =
        await _database.rawQuery("SELECT * FROM user WHERE email = '$email'");
    if (reponse.length == 0) {
      return null;
    } else {
      return User.fromMap(reponse.first);
    }
  }

  Future<int> getNameUser(int id) async{
    await opentDb();
   await _database.rawQuery("SELECT user.name from user WHERE id = $id ");
  }

  // NOTE
  Future<int> addNote(Note note) async{
    await opentDb();
    _database.insert('note', note.toMap());
  }
  Future<List<Note>> getAllListNote() async {
    await opentDb();
    var reponse = await _database.query("note");
    List<Note>arrNote = reponse.map((c)=>Note.fromJson(c)).toList();
    return arrNote;
  }
  Future<int> deleteNote(int id )async {
    await opentDb();
    return await _database.delete('note',where: "id = ? ",whereArgs: [id]);
  }

}
