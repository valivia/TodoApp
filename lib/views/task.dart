import 'package:flutter/material.dart';
import 'package:todo_flutter/widgets/task.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    // Streak text
    var streakText = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.headlineMedium,
        children: [
          TextSpan(
            text: '${widget.task.streak}',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          const TextSpan(text: ' day streak'),
        ],
      ),
    );

    // view
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: double.infinity),
            streakText,
          ],
        ),
      ),
    );
  }
}
