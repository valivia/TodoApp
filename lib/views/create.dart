import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/util.dart';

import '../state/task.dart';
import '../state/daily_tasks.dart';

class CreateTaskForm extends StatelessWidget {
  const CreateTaskForm({Key? key}) : super(key: key);

  static const formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  );

  static const padding = 8.0;

  @override
  Widget build(BuildContext context) {
    final dailytasks = Provider.of<DailyTasks>(context);

    final formKey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController questionController = TextEditingController();
    TextEditingController targetController = TextEditingController();
    TextEditingController frequencyController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          // Name
          TextFormField(
            textCapitalization: TextCapitalization.sentences,
            maxLength: 20,
            controller: titleController,
            validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'E.g. Pushups',
              border: formBorder,
            ),
          ),
          const SizedBox(height: padding),
          // Question
          TextFormField(
            textCapitalization: TextCapitalization.sentences,
            maxLength: 50,
            controller: questionController,
            validator: (value) =>
                value!.isEmpty ? 'Please enter a question' : null,
            decoration: const InputDecoration(
              labelText: 'Question',
              hintText: 'E.g. Did you do your daily pushups?',
              border: formBorder,
            ),
          ),
          const SizedBox(height: padding),
          // Target
          TextFormField(
            controller: targetController,
            validator: (value) =>
                value!.isEmpty ? 'Please enter a question' : null,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Target',
              hintText: 'E.g. 10',
              border: formBorder,
            ),
          ),
          const SizedBox(height: padding),
          // Frequency
          TextFormField(
            controller: frequencyController,
            validator: (value) =>
                value!.isEmpty ? 'Please enter a question' : null,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Frequency',
              hintText: 'Every X days',
              border: formBorder,
            ),
          ),
          // Submit
          const Spacer(
            flex: 2,
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final task = Task(
                  titleController.text,
                  questionController.text,
                  int.parse(targetController.text),
                  int.parse(frequencyController.text),
                );

                dailytasks.addTask(task);
                Navigator.pop(context);
              }
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(
                  const Size(double.infinity, 10)),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
              ),
            ),
            child: const Text('Save',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

class CreateTaskView extends StatelessWidget {
  const CreateTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        shape: rounded,
      ),
      body: const Padding(
        padding: pagePadding,
        child: CreateTaskForm(),
      ),
    );
  }
}
