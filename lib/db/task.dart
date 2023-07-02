import '../db.dart';

class Task {
  // Fields
  int? _id;
  late String _title;
  late String _question;
  late int _target;
  late int _frequency;

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

  // Utility methods
  @override
  String toString() {
    return 'Task{id: $id, title: $title, question: $question, target: $target, frequency: $frequency}';
  }
}
