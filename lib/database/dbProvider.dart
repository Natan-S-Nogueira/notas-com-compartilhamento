import 'package:flutter/cupertino.dart';
import 'package:notas_com_compartilhamento/models/noteModel.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider with ChangeNotifier {
  String dbPath = "notas_com_compartilhamento.db";
  int dbVersion = 2;

  late Database _db;
  Database get db => _db;

  DBProvider() {
    openDatabase(dbPath, onCreate: (db, version) {
      db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        creation_date TEXT
      )
      ''');
    }, version: dbVersion).then((db) {
      _db = db;
      notifyListeners();
    });
  }

  addNewNote(NoteModel note) async {
    db?.insert("notes", note.toMap());
  }

  Future<dynamic> getNotes() async{
    var response = await db?.query("notes");
    if(response?.length == 0){
      return Null;
    }
    else {
      var resultMap = response?.toList();
      return resultMap!.isNotEmpty ? resultMap : Null;
    }
  }
}