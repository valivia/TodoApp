import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

class PedometerWidget extends StatefulWidget {
  @override
  _PedometerWidgetState createState() => _PedometerWidgetState();
}

class _PedometerWidgetState extends State<PedometerWidget> {
  String _stepCount = '0';
  int _dailyStepCount = 0;
  int _totalStepCount = 0;
  String _lastRecordedStepCount = '0';
  String _currentDate = DateTime.now().toString().split(' ')[0];
  late Timer _dailyResetTimer;
  late StreamSubscription<StepCount> _stepCountStream;
  Duration _timeUntilReset = Duration(minutes: 1);

  @override
  void initState() {
    super.initState();
    startListening();
    startDailyResetTimer();
  }

  void startListening() {
    _stepCountStream = Pedometer.stepCountStream.listen((StepCount event) {
      setState(() {
        _dailyStepCount = event.steps - _totalStepCount;
        _stepCount = _dailyStepCount.toString();
      });
    });
  }

  void startDailyResetTimer() {
    _dailyResetTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timeUntilReset.inSeconds > 0) {
          _timeUntilReset -= Duration(seconds: 1);
        } else {
          _totalStepCount +=
              _dailyStepCount; // Update the totalStepCount at the end of the timer
          _dailyStepCount = 0;
          _currentDate = DateTime.now().toString().split(' ')[0];
          _timeUntilReset = Duration(minutes: 1);
          _lastRecordedStepCount = _stepCount;
        }
      });
    });
  }

  @override
  void dispose() {
    _stepCountStream.cancel();
    _dailyResetTimer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Step Count:',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          _stepCount,
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Date: $_currentDate',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'Last Recorded Step Count: $_lastRecordedStepCount', // Show the totalStepCount
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 16),
        Text(
          'Time Until Reset:',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          formatDuration(_timeUntilReset),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
