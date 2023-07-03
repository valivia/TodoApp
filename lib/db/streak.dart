class Streak {
  int duration = 0;
  DateTime? start;
  DateTime? end;

  Streak();
  Streak.fromStartDate(this.start);
  Streak.fromEndDate(this.end);

  @override
  String toString() {
    return 'Streak: $duration days from $start to $end';
  }
}
