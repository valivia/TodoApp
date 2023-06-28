import 'package:flutter/material.dart';

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.streak,
  });

  final String id;
  final String title;
  final int streak;
  final bool isCompleted = false;
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: FloatingActionButton(
          onPressed: () => {},
          tooltip: 'Complete',
          child: const Icon(Icons.check),
        ),
        title: Text(task.title),
        subtitle: Text('${task.streak} day streak'),
      ),
    );
  }
}

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({Key? key, required this.tasks}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        // Header
        Row(
          children: [
            Text('Tasks', style: Theme.of(context).textTheme.headlineMedium),
            const Spacer(),
            FloatingActionButton(
              onPressed: () => {},
              tooltip: 'add',
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        // Tasks
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskWidget(
                task: tasks[index],
                key: ValueKey(tasks[index].id),
              );
            },
          ),
        ),
      ]),
    );
  }
}
