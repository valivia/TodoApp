import 'package:flutter/material.dart';
import 'package:todo_flutter/widgets/task.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});
  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = [
      const Task(id: '1', title: 'Feed Bird', streak: 365),
      const Task(id: '2', title: 'Play guitar', streak: 13),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(
          "Daily Tasks",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: TaskListWidget(tasks: tasks),
    );
  }
}
