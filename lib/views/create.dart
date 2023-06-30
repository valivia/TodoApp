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

  final padding = 8.0;

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
            decoration: const InputDecoration(
              labelText: 'Question',
              hintText: 'E.g. Did you do your daily pushups?',
              border: formBorder,
            ),
          ),
          SizedBox(height: padding),
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
          SizedBox(height: padding),
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
          const Spacer(
            flex: 2,
          ),
          ElevatedButton(
            onPressed: () => {},
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
      appBar: AppBar(title: const Text('Create Task')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CreateTaskForm(),
      ),
    );
  }
}
