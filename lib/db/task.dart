class Task {
  // Fields
  late int _id;
  late String _title;
  late int _target;
  late int _frequency;

  // Constructor
  Task(
    this._id,
    this._title,
    this._target,
    this._frequency,
  );

  // Task.withId(
  //   this._id,
  //   this._title,
  //   this._target,
  //   this._frequency,
  // );

  // Getters
  int get id => _id;
  String get title => _title;
  int get target => _target;
  int get frequency => _frequency;

  // Setters
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set target(int newTarget) {
    if (newTarget >= 0) {
      _target = newTarget;
    }
  }

  set frequency(int newFrequency) {
    if (newFrequency >= 0) {
      _frequency = newFrequency;
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (_id != null) {
      map['id'] = _id;
    }

    map['title'] = _title;
    map['target'] = _target;
    map['frequency'] = _frequency;

    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _target = map['target'];
    _frequency = map['frequency'];
  }
}
