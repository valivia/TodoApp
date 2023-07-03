import 'package:flutter/material.dart';
import 'package:todo_flutter/views/settings.dart';
import 'package:todo_flutter/widgets/date_selector.dart';
import '../widgets/task_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // View
    final view = Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsView()),
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DateSelector(),
            TaskListWidget(),
          ],
        ),
      ),
    );

    return view;
  }
}
