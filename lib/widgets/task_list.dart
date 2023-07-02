import 'package:flutter/material.dart';
import 'package:todo_flutter/views/create.dart';
import 'package:todo_flutter/widgets/task.dart';
import '../db/task.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    Key? key,
    required this.tasks,
    required this.refresh,
  }) : super(key: key);

  final Function refresh;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final header = Row(
      children: [
        Text('Tasks', style: Theme.of(context).textTheme.headlineMedium),
        const Spacer(),
        FloatingActionButton(
          heroTag: 'addTask',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateTaskView(refresh: refresh)),
          ),
          tooltip: 'add',
          child: const Icon(Icons.add),
        ),
      ],
    );

    final list = Expanded(
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
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        header,
        const SizedBox(height: 24.0),
        list,
      ]),
    );
  }
}
