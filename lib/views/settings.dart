import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/util.dart';
import '../state/daily_tasks.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  );

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(shape: rounded),
      body: Padding(
          padding: pagePadding,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, 10)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                    ),
                  ),
                  child: const Text('Save',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
          )),
    );
  }
}
