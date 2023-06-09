import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'state/task.dart';

class DbService {
  // Singleton
  static final DbService _singleton = DbService._internal();
  DbService._internal();

  factory DbService() {
    return _singleton;
  }

  // Database
  static Database? _database;
  static const dbVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  // initialize the database
  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'task.db');
    if (kDebugMode) print('path is $path');

    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  static void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, question Text, target INTEGER, frequency INTEGER)',
    );

    await db.execute(
      'CREATE TABLE progress(id INTEGER PRIMARY KEY, taskId INTEGER, value INTEGER, date INTEGER, FOREIGN KEY(taskId) REFERENCES task(id), UNIQUE(taskId, date) ON CONFLICT FAIL)',
    );
  }

  // Utils
  Future<List<Task>> getTasks(DateTime date) async {
    final db = await database;
    final tasks = await db.query('task');
    return tasks.map((e) => Task.fromMapObject(e)).toList();
  }
}
