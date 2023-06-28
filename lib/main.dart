// import 'package:flutter/material.dart';
// import 'package:todo_flutter/theme/dark.dart';
// import './views/home.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: darkTheme,
//       home: const MyHomePage(title: 'Daily Tasks'),
//     );
//   }
// }

// Ik weet even niet hoe ik het anmders doe sorry :)

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

class PedometerApp extends StatefulWidget {
  @override
  _PedometerAppState createState() => _PedometerAppState();
}

class _PedometerAppState extends State<PedometerApp> {
  String _stepCount = '0';
  int _dailyStepCount = 0;
  int _lastRecordedStepCount = 0;
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
        _dailyStepCount = event.steps - _lastRecordedStepCount;
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
          _lastRecordedStepCount = _dailyStepCount;
          _dailyStepCount += 0;
          _currentDate = DateTime.now().toString().split(' ')[0];
          _timeUntilReset = Duration(minutes: 1);
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pedometer App'),
        ),
        body: Center(
          child: Column(
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
                'Last Recorded Daily Step Count: $_lastRecordedStepCount',
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
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(PedometerApp());
}
