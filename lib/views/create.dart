import 'package:flutter/material.dart';

class CreateTaskForm extends StatefulWidget {
  const CreateTaskForm({Key? key}) : super(key: key);

  @override
  State<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final _formKey = GlobalKey<FormState>();

  static const formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Wrap(
        runSpacing: 16.0,
        children: <Widget>[
          // Name
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'E.g. Pushups',
              border: formBorder,
            ),
          ),
          // Question
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Question',
              hintText: 'E.g. Did you do your daily pushups?',
              border: formBorder,
            ),
          ),
          // Target
          TextFormField(
            initialValue: "0",
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Target',
              hintText: 'E.g. 10',
              errorText: "Please enter a number",
              border: formBorder,
            ),
          ),
          // Frequency
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Frequency',
              hintText: 'Every X days',
              border: formBorder,
            ),
          ),
          // Submit
          const ElevatedButton(onPressed: null, child: Text('Submit')),
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
      appBar: AppBar(title: const Text('Create Task')),
      body: const Padding(
        padding: EdgeInsets.all(32.0),
        child: CreateTaskForm(),
      ),
    );
  }
}
