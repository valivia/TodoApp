import 'package:flutter/foundation.dart';
import 'package:todo_flutter/state/daily_tasks.dart';

import '../db.dart';

class Progress {
  // Fields
  int? _id;
  late int _taskId;
  late int _value = 0;
  late DateTime _date = DailyTasks.convertDate(DateTime.now());

  // Constructors
  Progress(
    this._id,
    this._taskId,
    this._value,
    this._date,
  );

  Progress.fromTaskId(this._taskId);

  // Getters
  int? get id => _id;
  int get taskId => _taskId;
  int get value => _value;
  DateTime get date => _date;

  // Setters
  set taskId(int newTaskId) {
    _taskId = newTaskId;
  }

  set value(int newValue) {
    _value = newValue.clamp(0, double.infinity).toInt();
  }

  set date(DateTime newDate) {
    _date = newDate;
  }

  // Database methods
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (_id != null) {
      map['id'] = _id;
    }

    map['taskId'] = _taskId;
    map['value'] = _value;
    map['date'] = _date.millisecondsSinceEpoch;

    return map;
  }

  Progress.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _taskId = map['taskId'];
    _value = map['value'];
    _date = DateTime.fromMillisecondsSinceEpoch(map['date']);
  }

  Future<void> upsert() async {
    final db = await DbService().database;
    if (kDebugMode) print('Progress.upsert(): $this');
    if (id == null) {
      _id = await db.insert('progress', toMap());
    } else {
      await db.update('progress', toMap(), where: 'id = ?', whereArgs: [id]);
    }
  }

  Future<void> delete() async {
    final db = await DbService().database;
    await db.delete('progress', where: 'id = ?', whereArgs: [id]);
  }

  // Other methods

  @override
  String toString() {
    return 'Progress(id: $id, taskId: $taskId, value: $value, date: $date)';
  }
}
