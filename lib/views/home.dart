import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/widgets/date_selector.dart';

import '../state/daily_tasks.dart';
import '../widgets/task_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final dailytasks = Provider.of<DailyTasks>(context);
    // View
    final view = GestureDetector(
      onHorizontalDragEnd: (details) {
        int sensitivity = 10;
        if (details.velocity.pixelsPerSecond.dx > sensitivity) {
          dailytasks.date = dailytasks.date.subtract(const Duration(days: 1));
        } else if (details.velocity.pixelsPerSecond.dx < -sensitivity) {
          dailytasks.date = dailytasks.date.add(const Duration(days: 1));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              DateSelector(),
              TaskListWidget(),
            ],
          ),
        ),
      ),
    );

    return view;
  }
}
