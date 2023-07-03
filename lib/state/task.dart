import 'package:flutter/foundation.dart';
import 'package:todo_flutter/db/progress.dart';
import 'package:todo_flutter/state/daily_tasks.dart';

import '../db.dart';

class Task extends ChangeNotifier {
  // Fields
  int? _id;
  late String _title;
  late String _question;
  late int _target;
  late int _frequency;

  List<Progress> _progress = [];
  int _streak = 0;

  // Constructor
  Task(
    this._title,
    this._question,
    this._target,
    this._frequency,
  );

  // Getters
  int? get id => _id;
  String get title => _title;
  String get question => _question;
  int get target => _target;
  int get frequency => _frequency;
  List<Progress> get progress => _progress;
  int get streak => _streak;

  // Setters
  set title(String newTitle) {
    _title = newTitle.substring(0, 21);
  }

  set question(String newQuestion) {
    _question = newQuestion.substring(0, 51);
  }

  set target(int newTarget) {
    _target = newTarget.clamp(0, double.infinity).toInt();
  }

  set frequency(int newFrequency) {
    _frequency = newFrequency.clamp(0, double.infinity).toInt();
  }

  // Database methods
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (_id != null) {
      map['id'] = _id;
    }

    map['title'] = _title;
    map['question'] = _question;
    map['target'] = _target;
    map['frequency'] = _frequency;

    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _question = map['question'];
    _target = map['target'];
    _frequency = map['frequency'];
  }

  Future<void> upsert() async {
    final db = await DbService.instance.database;
    if (id == null) {
      _id = await db.insert('task', toMap());
    } else {
      await db.update('task', toMap(), where: 'id = ?', whereArgs: [id]);
    }
  }

  Future<void> delete() async {
    final db = await DbService.instance.database;
    await db.delete('task', where: 'id = ?', whereArgs: [id]);
  }

  // Progress
  Future<void> loadProgress() async {
    if (kDebugMode) print("Loading progress for task $id");
    final db = await DbService.instance.database;
    final progress = await db.query('progress',
        where: 'taskId = ?', whereArgs: [id], orderBy: 'date DESC');
    _progress = progress.map((entry) => Progress.fromMapObject(entry)).toList();
    _streak = getStreak();

    if (kDebugMode) {
      for (var element in _progress) {
        print('progress db entry: $element');
      }
    }
  }

  Future<void> addProgress(Progress progress) async {
    if (_id == null) {
      throw Exception('Task must be saved before creating progress');
    }
    await progress.upsert();
    _progress.add(progress);
    _streak = getStreak();
    notifyListeners();
  }

  Future<void> removeProgress(Progress progress) async {
    if (_id == null) {
      throw Exception('Task must be saved before deleting progress');
    }
    await progress.delete();
    _progress.remove(progress);
    _streak = getStreak();
    notifyListeners();
  }

  // Get the task's state for a given date
  Progress getProgress(DateTime date) {
    final a = _progress.where((element) => element.date == date);
    if (a.isEmpty) {
      final progress = Progress.fromTaskId(id!);
      progress.date = date;
      addProgress(progress);
      return progress;
    } else {
      return a.first;
    }
  }

  Future<void> complete(DateTime date, [int? change]) async {
    final progress = getProgress(date);

    if (_target == 1) {
      progress.value = progress.value == 0 ? 1 : 0;
    } else {
      change ??= 1;
      // progress.value = (progress.value + change).clamp(0, _target);
      progress.value += change;
      if (progress.value > _target) {
        progress.value = 0;
      }
    }

    _streak = getStreak();
    notifyListeners();
    await progress.upsert();
  }

  int getStreak() {
    int streak = 0;
    DateTime date = DailyTasks.convertDate(DateTime.now());
    for (var progress in _progress) {
      if (progress.date == date) {
        if (progress.value == _target) {
          streak++;
        } else {
          break;
        }
        date = date.subtract(const Duration(days: 1));
      }
    }
    if (streak == 1) streak = 0;
    return streak;
  }

  // Utility methods
  @override
  String toString() {
    return 'Task{id: $id, title: $title, question: $question, target: $target, frequency: $frequency}';
  }
}
