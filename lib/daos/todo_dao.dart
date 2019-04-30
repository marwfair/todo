import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart' show ConflictAlgorithm;
import 'package:to_do/database/database.dart';
import 'package:to_do/models/todo_item.dart';

class ToDoDao {
  static String getSqlCreateString() {
    return 'CREATE TABLE IF NOT EXISTS todo_item('
        'id INTEGER PRIMARY KEY,'
        'title TEXT,'
        'description TEXT,'
        'timestamp INTEGER,'
        'sort_order INTEGER,'
        'completed INTEGER)';
  }

  static Future<List<ToDoItem>> getToDoItems() async {
    final Database database = await DBProvider.db.database;
    final List<Map<String, dynamic>> result = await database
        .rawQuery('SELECT * FROM todo_item ORDER BY sort_order ASC');

    final List<ToDoItem> toDoList = <ToDoItem>[];
    for (Map<String, dynamic> map in result.toList()) {
      final ToDoItem toDoItem = ToDoItem.fromMap(map);
      toDoList.add(toDoItem);
    }

    return toDoList;
  }

  static Future<int> saveSortOrder(ToDoItem toDoItem) async {
    final Map<String, dynamic> row = <String, dynamic>{
      'sort_order': toDoItem.sortOrder,
    };

    final Database database = await DBProvider.db.database;
    return await database.update('todo_item', row,
        where: 'id=?',
        whereArgs: <dynamic>[toDoItem.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> saveCompleted(ToDoItem toDoItem) async {
    final Map<String, dynamic> row = <String, dynamic>{
      'completed': toDoItem.completed,
    };

    final Database database = await DBProvider.db.database;
    return await database.update('todo_item', row,
        where: 'id=?',
        whereArgs: <dynamic>[toDoItem.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> saveToDoItem(ToDoItem toDoItem) async {
    final Database database = await DBProvider.db.database;
    return await database.insert('todo_item', toDoItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteToDoItem(ToDoItem toDoItem) async {
    final Database database = await DBProvider.db.database;
    return await database
        .delete('todo_item', where: 'id=?', whereArgs: <dynamic>[toDoItem.id]);
  }
}
