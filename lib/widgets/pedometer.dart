import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

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
    _dailyResetTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timeUntilReset.inSeconds > 0) {
          _timeUntilReset -= const Duration(seconds: 1);
        } else {
          _totalStepCount +=
              _dailyStepCount; // Update the totalStepCount at the end of the timer
          _dailyStepCount = 0;
          _currentDate = DateTime.now().toString().split(' ')[0];
          _timeUntilReset = const Duration(minutes: 1);
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
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 150,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             'Step Count:',
//             style: TextStyle(fontSize: 24),
//           ),
//           Text(
//             _stepCount,
//             style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
//           ),
//           // Text(
//           //   'Last Recorded Step Count: $_lastRecordedStepCount', // Show the totalStepCount
//           //   style: const TextStyle(fontSize: 18),
//           // ),
//           // const SizedBox(height: 16),
//           // const Text(
//           //   'Time Until Reset:',
//           //   style: TextStyle(fontSize: 18),
//           // ),
//           // Text(
//           //   formatDuration(_timeUntilReset),
//           //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           // ),
//         ],
//       ),
//     );
//   }
// }

  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Step Count:',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _stepCount,
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const Text(
                  ' / ',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  '10,000', // Replace with your step goal value
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
