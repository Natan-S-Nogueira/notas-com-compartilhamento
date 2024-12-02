import 'package:notas_com_compartilhamento/models/noteModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database?> get database async{
    if(_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async{
    return await openDatabase(join(await getDatabasesPath(), "notas_com_compartilhamento.db"),
    onCreate: (db, version) async{
      await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        creation_date DATE
      )
      ''');
    }, version:1);
  }

  addNewNote(NoteModel note) async {
    final db = await database;
    db?.insert("notes", note.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getNotes() async{
    final db = await database;
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