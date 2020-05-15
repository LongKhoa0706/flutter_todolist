
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'model/note.dart';
import 'model/note.dart';
import 'util/dbmanager.dart';
import 'util/dbmanager.dart';

class NoteProvider with ChangeNotifier{
  List<Note> arr = [];
  var dbManager = DbManager();
  var db = DbManager.database;

  Future<List<Note>> getAllListNote() async {
    await dbManager.opentDb();
    var reponse = await db.query("note");
    reponse.forEach((element) {
      arr.add(Note.fromJson(element));
    });
    notifyListeners();
    return arr;
  }
  // NOTE
  Future<Note> addNote(String title,String date) async{
    await dbManager.opentDb();
    Note note = Note(title: title,date: date);
    db.insert('note', note.toMap());
    notifyListeners();
    return note;
  }

  Future<int> deleteNote(int id )async {
    await dbManager.opentDb();
    return await db.delete('note',where: "id = ? ",whereArgs: [id]);
  }
}