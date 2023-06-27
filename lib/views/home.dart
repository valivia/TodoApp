import 'package:flutter/material.dart';
import 'package:todo_flutter/widgets/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = [
      const Task(id: '1', title: 'Feed Bird', streak: 365),
      const Task(id: '1', title: 'Play guitar', streak: 13),
    ];

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: TaskListWidget(tasks: tasks),
    );
  }
}
