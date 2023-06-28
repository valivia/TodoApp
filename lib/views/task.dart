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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: const Center(
        child: Text('Task View'),
      ),
    );
  }
}
