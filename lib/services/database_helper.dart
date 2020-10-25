import 'dart:io';

import 'package:bloc_login/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  Database database;
  String dbName = 'tasks.db';
  static final String tasksTableName = 'tasks';
  static final String taskIdColumnName = 'taskId';
  static final String taskNameColumnName = 'taskName';
  static final String taskIsCompeteColumnName = 'taskComplete';
  Future<Database> initDatabase() async {
    if (database == null) {
      return openDataBase();
    } else {
      return database;
    }
  }

  Future<Database> openDataBase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String appPath = directory.path;
      String dbPath = join(appPath, dbName);
      Database database = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) {
          db.execute('''
          CREATE TABLE $tasksTableName(
            $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $taskNameColumnName TEXT NOT NULL,
            $taskIsCompeteColumnName INTEGER
          )
          ''');
        },
      );
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<int> insertNewTask(Task task) async {
    try {
      database = await initDatabase();
      int rowIndex = await database.insert(tasksTableName, task.toJson());
      return rowIndex;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Task>> getAllTasks() async {
    try {
      database = await initDatabase();
      List<Map<String, dynamic>> rowsMaps =
          await database.query(tasksTableName);
      List<Task> tasks = rowsMaps.map((e) => Task.fromMap(e)).toList();
      return tasks;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<int> updateTask(Task task) async {
    try {
      database = await initDatabase();
      int rowCount = await database.update(tasksTableName, task.toJson(),
          where: '$taskIdColumnName = ?', whereArgs: [task.id]);
      return rowCount;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<int> deleteTask(Task task) async {
    try {
      database = await initDatabase();
      int rowCount = await database.delete(tasksTableName,
          where: '$taskIdColumnName = ?', whereArgs: [task.id]);
      return rowCount;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
