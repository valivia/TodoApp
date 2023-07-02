import 'package:flutter/material.dart';
import '../db/task.dart';
import '../widgets/date_selector.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key, required this.task, required this.refresh})
      : super(key: key);
  final Task task;
  final Function refresh;

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
            text: '${42}',
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
        actions: [
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.task.delete().then((value) => {
                      widget.refresh(),
                      Navigator.pop(context),
                    });
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DateSelector(),
            streakText,
          ],
        ),
      ),
    );
  }
}
