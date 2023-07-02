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
      const Task(
          id: '1',
          title: 'Feed Bird',
          current: 1,
          target: 1,
          frequency: 1,
          streak: 365),
      const Task(
          id: '2',
          title: 'Play guitar',
          current: 2,
          target: 3,
          frequency: 1,
          streak: 13),
      const Task(
          id: '3',
          title: 'Read book',
          current: 1,
          target: 1,
          frequency: 7,
          streak: 1),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: TaskListWidget(tasks: tasks),
    );
  }
}
