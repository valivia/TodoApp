class Progress {
  late String _id;
  late String _taskId;
  late int _value;
  late DateTime _date;

  Progress(
    this._id,
    this._taskId,
    this._value,
    this._date,
  );

  Progress.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _taskId = map['taskId'];
    _value = map['value'];
    _date = DateTime.parse(map['date']);
  }

  // Getters
  String get id => _id;
  String get taskId => _taskId;
  int get value => _value;
  DateTime get date => _date;

  // Setters
  set taskId(String newTaskId) {
    if (newTaskId.length <= 255) {
      _taskId = newTaskId;
    }
  }

  set value(int newValue) {
    if (newValue >= 0) {
      _value = newValue;
    }
  }

  set date(DateTime newDate) {
    _date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (_id != null) {
      map['id'] = _id;
    }

    map['taskId'] = _taskId;
    map['value'] = _value;
    map['date'] = _date.toIso8601String();

    return map;
  }
}
