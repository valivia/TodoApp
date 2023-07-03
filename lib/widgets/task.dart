import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/state/daily_tasks.dart';
import 'package:todo_flutter/views/task.dart';
import '../db/progress.dart';
import '../state/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DailyTasks dailytasks = Provider.of<DailyTasks>(context);
    final task = Provider.of<Task>(context);
    Widget button;

    Progress progress = task.getProgress(dailytasks.date);
    // on/off Task
    if (task.target > 1) {
      button = GestureDetector(
        onTap: () => task.complete(dailytasks.date).then((value) => null),
        child: Stack(
          children: [
            Center(child: Text('${progress.value}')),
            Center(
              child: SizedBox(
                width: 48.0,
                height: 48.0,
                child: CircularProgressIndicator(
                  value: progress.value / task.target,
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
      // Counter task
    } else {
      bool isCompleted = progress.value == task.target;
      button = Ink(
        decoration: ShapeDecoration(
          color: isCompleted
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          shape: CircleBorder(
            side: isCompleted
                ? BorderSide.none
                : BorderSide(
                    color: Theme.of(context).colorScheme.onSurface,
                    width: 1,
                  ),
          ),
        ),
        child: IconButton(
          onPressed: () => task.complete(dailytasks.date).then((value) => null),
          tooltip: 'Complete',
          color: isCompleted
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSurface,
          icon: const Icon(Icons.check),
        ),
      );
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskView(task: task)),
      ),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(100.0),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          leading: SizedBox(
            width: 48.0,
            height: 48.0,
            child: button,
          ),
          title: Text(task.title),
          subtitle: Text('${task.streak} day streak'),
        ),
      ),
    );
  }
}
