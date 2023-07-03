import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/util.dart';
import 'package:todo_flutter/views/settings.dart';
import 'package:todo_flutter/widgets/date_selector.dart';
import 'package:todo_flutter/widgets/pedometer.dart';

import '../widgets/popup.dart';
import '../state/daily_tasks.dart';
import '../widgets/task_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailytasks = Provider.of<DailyTasks>(context);
    DateTime today = DailyTasks.convertDate(DateTime.now());
    bool showTextWidget = dailytasks.date != today;

    return GestureDetector(
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
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              ListView(
                padding: pagePadding,
                shrinkWrap: true,
                children: const [
                  DateSelector(),
                  SizedBox(height: 16),
                  PedometerWidget(),
                  SizedBox(height: 16),
                  TaskListWidget(),
                ],
              ),
              if (showTextWidget)
                TextDisplayWidget(
                  onTap: () {
                    dailytasks.date = today;
                  },
                  text:
                      "You're looking at a previous date. Click here to return to the current day.",
                ),
            ],
          ),
        ),
      ),
    );
  }
}
