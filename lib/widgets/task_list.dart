import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/state/task.dart';
import 'package:todo_flutter/views/create.dart';
import 'package:todo_flutter/widgets/task.dart';
import '../state/daily_tasks.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailytasks = Provider.of<DailyTasks>(context);

    final header = Row(
      children: [
        Text('Tasks', style: Theme.of(context).textTheme.headlineMedium),
        const Spacer(),
        FloatingActionButton(
          heroTag: 'addTask',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTaskView()),
          ),
          tooltip: 'add',
          child: const Icon(Icons.add),
        ),
      ],
    );

    final list = ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemCount: dailytasks.tasks.length,
      itemBuilder: (context, index) {
        final task = dailytasks.tasks[index];
        return ChangeNotifierProvider<Task>.value(
          value: task,
          child: TaskWidget(
            key: ValueKey(task.id),
          ),
        );
      },
    );

    return Column(children: [
      header,
      const SizedBox(height: 24.0),
      list,
    ]);
  }
}
