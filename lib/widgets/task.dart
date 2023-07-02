import 'package:flutter/material.dart';
import 'package:todo_flutter/views/task.dart';
import '../db/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task, required this.refresh})
      : super(key: key);
  final Task task;
  final Function refresh;
  final progress = (
    streak: 42,
    current: 1,
  );

  @override
  Widget build(BuildContext context) {
    Widget button;
    // on/off Task
    if (task.target > 1) {
      button = Stack(
        children: [
          Center(child: Text('${progress.current}')),
          Center(
            child: SizedBox(
              width: 48.0,
              height: 48.0,
              child: CircularProgressIndicator(
                value: progress.current / task.target,
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      );
      // Counter task
    } else {
      button = FloatingActionButton(
        heroTag: task.id,
        onPressed: () => {},
        tooltip: 'Complete',
        child: const Icon(Icons.check),
      );
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskView(task: task, refresh: refresh)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: SizedBox(
            width: 48.0,
            height: 48.0,
            child: button,
          ),
          title: Text(task.title),
          subtitle: Text('${progress.streak} day streak'),
        ),
      ),
    );
  }
}
