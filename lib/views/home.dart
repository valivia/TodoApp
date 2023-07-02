import 'package:flutter/material.dart';
import 'package:todo_flutter/db/task.dart';

import '../db.dart';
import '../widgets/task_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<List<Task>> fetchTasks() async {
    final db = await DbService.instance.database;
    final tasks = await db.query('task');
    return tasks.map((e) => Task.fromMapObject(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No tasks yet!'));
            } else {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                ),
                body: TaskListWidget(tasks: snapshot.data!),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        future: fetchTasks());
    // final List<Task> tasks = [
    //   const Task(
    //       id: '1',
    //       title: 'Feed Bird',
    //       current: 1,
    //       target: 1,
    //       frequency: 1,
    //       streak: 365),
    //   const Task(
    //       id: '2',
    //       title: 'Play guitar',
    //       current: 2,
    //       target: 3,
    //       frequency: 1,
    //       streak: 13),
    //   const Task(
    //       id: '3',
    //       title: 'Read book',
    //       current: 1,
    //       target: 1,
    //       frequency: 7,
    //       streak: 1),
    // ];
  }
}
