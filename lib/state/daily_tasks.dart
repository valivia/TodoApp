import 'package:flutter/foundation.dart';
import 'package:todo_flutter/db.dart';

import '../db/task.dart';

class DailyTasks extends ChangeNotifier {
  // Singleton
  static final DailyTasks _singleton = DailyTasks._internal();

  factory DailyTasks() {
    return _singleton;
  }

  DailyTasks._internal();
  
  // Tasks
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> addTask(Task task) async {
    await task.upsert();
    if (kDebugMode) print(task);

    _tasks.add(task);
    notifyListeners();
  }

  Future<void> removeTask(Task task) async {
    await task.delete();
    _tasks.remove(task);
    notifyListeners();
  }

  Future<List<Task>> loadTasks() async {
    if (kDebugMode) print("fetching tasks");
    _tasks = await DbService.instance.getTasks(date);
    _tasks.map((task) => task.loadProgress());
    notifyListeners();
    return _tasks;
  }

  // Date
  static DateTime convertDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  DateTime _date = convertDate(DateTime.now());
  DateTime get date => _date;
  set date(DateTime date) {
    if (date.difference(convertDate(DateTime.now())).inMilliseconds > 0) return;
    _date = date;
    notifyListeners();
  }
}
