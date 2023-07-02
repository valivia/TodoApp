import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../db.dart';
import '../db/task.dart';

class CreateTaskForm extends StatefulWidget {
  const CreateTaskForm({Key? key, required this.refresh}) : super(key: key);
  final Function refresh;

  Future<void> createTask(Task task) async {
    final db = await DbService.instance.database;
    await db.insert('task', task.toMap());

    refresh();
  }

  @override
  State<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final _formKey = GlobalKey<FormState>();

  static const formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  );

  final padding = 8.0;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // runSpacing: 8.0,
        children: <Widget>[
          // Name
          TextFormField(
            maxLength: 20,
            controller: _titleController,
            validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'E.g. Pushups',
              border: formBorder,
            ),
          ),
          SizedBox(height: padding),
          // Question
          TextFormField(
            maxLength: 50,
            controller: _questionController,
            validator: (value) =>
                value!.isEmpty ? 'Please enter a question' : null,
            decoration: const InputDecoration(
              labelText: 'Question',
              hintText: 'E.g. Did you do your daily pushups?',
              border: formBorder,
            ),
          ),
          SizedBox(height: padding),
          // Target
          TextFormField(
            controller: _targetController,
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
          SizedBox(height: padding),
          // Frequency
          SizedBox(height: padding),
          TextFormField(
            controller: _frequencyController,
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
              if (_formKey.currentState!.validate()) {
                final task = Task(
                  _titleController.text,
                  _questionController.text,
                  int.parse(_targetController.text),
                  int.parse(_frequencyController.text),
                );

                widget.createTask(task);
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
  const CreateTaskView({Key? key, required this.refresh}) : super(key: key);
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CreateTaskForm(refresh: refresh),
      ),
    );
  }
}
