import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/daos/todo_dao.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }
}

Future<Database> initDB() async {
  final Directory documentsDirectory = await getApplicationDocumentsDirectory();
  final String path = join(documentsDirectory.path, 'ToDoDb.db');
  return await openDatabase(path, version: 1, onOpen: (Database db) {},
      onCreate: (Database db, int version) async {
    await db.execute(ToDoDao.getSqlCreateString());
  });
}
