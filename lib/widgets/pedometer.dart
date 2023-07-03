import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class PedometerWidget extends StatefulWidget {
  const PedometerWidget({super.key});

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
  Duration _timeUntilReset = const Duration(minutes: 1);

  void requestPermission() async {
    PermissionStatus status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      // Permission granted, continue with the pedometer functionality
      startListening();
      startDailyResetTimer();
    } else {
      // Permission denied, handle accordingly
      // You can show an error message or disable the pedometer functionality
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
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
    _dailyResetTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        DateTime now = DateTime.now();
        DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
        Duration timeUntilReset = tomorrow.difference(now);
        if (timeUntilReset.inSeconds > 0) {
          timeUntilReset -= const Duration(seconds: 1);
        } else {
          _totalStepCount +=
              _dailyStepCount; // Update the totalStepCount at the end of the timer
          _dailyStepCount = 0;
          _currentDate = DateTime.now().toString().split(' ')[0];
          timeUntilReset = tomorrow.difference(DateTime.now());
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
  double get progressPercentage {
    double stepCount = double.parse(_stepCount);
    double stepGoal = 6000; // Replace with your step goal value
    return stepCount / stepGoal;
  }

  Widget build(BuildContext context) {
    String timeUntilResetFormatted = formatDuration(_timeUntilReset);

    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Step Count:',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _stepCount,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' / ',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '6000', // Replace with your step goal value
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: progressPercentage,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
