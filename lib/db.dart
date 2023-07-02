import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbService {
  DbService._internal() {
    // if (_database == null) database;
  }

  static final DbService instance = DbService._internal();
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
    if (kDebugMode) {
      print('path is $path');
    }
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, question Text, target INTEGER, frequency INTEGER)',
    );

    await db.execute(
      'CREATE TABLE progress(id INTEGER PRIMARY KEY, taskId INTEGER, value INTEGER, date TEXT)',
    );
  }
}
