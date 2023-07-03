import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/util.dart';
import 'package:todo_flutter/views/settings.dart';
import 'package:todo_flutter/widgets/date_selector.dart';
import 'package:todo_flutter/widgets/pedometer.dart';

import '../state/daily_tasks.dart';
import '../widgets/task_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailytasks = Provider.of<DailyTasks>(context);
    // View
    final view = GestureDetector(
      onHorizontalDragEnd: (details) {
        int sensitivity = 200;
        if (details.velocity.pixelsPerSecond.dx > sensitivity) {
          dailytasks.date = dailytasks.date.subtract(const Duration(days: 1));
        } else if (details.velocity.pixelsPerSecond.dx < -sensitivity) {
          dailytasks.date = dailytasks.date.add(const Duration(days: 1));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: rounded,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsView(),
                  ),
                );
              },
            ),
          ],
        ),
        body: ListView(
          padding: pagePadding,
          shrinkWrap: true,
          children: const [
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
