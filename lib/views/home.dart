import 'package:flutter/material.dart';
import 'package:todo_flutter/widgets/date_selector.dart';
import 'package:todo_flutter/widgets/pedometer.dart';

import '../widgets/task_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key});

  @override
  Widget build(BuildContext context) {
    // View
    final view = Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DateSelector(),
            PedometerWidget(),
            SizedBox(height: 32.0),
            TaskListWidget(),
          ],
        ),
      ),
    );

    return view;
  }
}
