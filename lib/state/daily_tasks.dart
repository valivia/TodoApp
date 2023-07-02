import 'package:flutter/material.dart';

import '../db/task.dart';

class DailyTasks extends ChangeNotifier {
  // Tasks
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  // Date
  DateTime _date = DateTime.now();
  DateTime get date => _date;

  void setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }
}
