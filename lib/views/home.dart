import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/db/task.dart';
import 'package:todo_flutter/widgets/date_selector.dart';
import 'package:todo_flutter/widgets/pedometer.dart';

import '../db.dart';
import '../state/daily_tasks.dart';
import '../widgets/task_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static Future<List<Task>> _fetchTasks() async {
    final db = await DbService.instance.database;
    final tasks = await db.query('task');
    if (kDebugMode) print("fetching tasks");
    return tasks.map((e) => Task.fromMapObject(e)).toList();
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<Task>> _tasks = HomeView._fetchTasks();

  @override
  Widget build(BuildContext context) {
    // View
    view(snapshot) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const DateSelector(),
                PedometerWidget(),
                TaskListWidget(
                  tasks: snapshot.data!,
                  refresh: () {
                    if (kDebugMode) print("refreshing");
                    setState(() {
                      _tasks = HomeView._fetchTasks();
                    });
                  },
                ),
              ],
            ),
          ),
        );

    // Builder
    final builder = FutureBuilder(
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.hasData) {
          return view(snapshot);
        } else if (snapshot.hasError) {
          return const Text("An error occurred");
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      future: _tasks,
    );
    return builder;
  }
}
