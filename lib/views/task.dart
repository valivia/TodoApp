import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/util.dart';
import 'package:todo_flutter/widgets/streaks.dart';
import '../state/task.dart';
import '../state/daily_tasks.dart';
import '../widgets/date_selector.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    final dailytasks = Provider.of<DailyTasks>(context);

    // Streak text
    var streakText = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.headlineMedium,
        children: [
          TextSpan(
            text: task.streak.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          const TextSpan(text: ' day streak'),
        ],
      ),
    );
    // view
    return GestureDetector(
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
          title: Text(task.title),
          shape: rounded,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                dailytasks
                    .removeTask(task)
                    .then((value) => {Navigator.pop(context)});
              },
            ),
          ],
        ),
        body: ListView(
          padding: pagePadding,
          children: [
            const DateSelector(),
            Center(child: streakText),
            const SizedBox(height: 16),
            StreakDisplayWidget(task: task),
          ],
        ),
      ),
    );
  }
}
