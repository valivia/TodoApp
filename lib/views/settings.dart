import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../state/daily_tasks.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  );

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final dailytasks = Provider.of<DailyTasks>(context);
    TextEditingController stepTargetController =
        TextEditingController(text: dailytasks.stepTarget.toString());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: stepTargetController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a target' : null,
                  decoration: const InputDecoration(
                    labelText: 'Daily Step Target',
                    hintText: 'E.g. 1000',
                    border: formBorder,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const Spacer(
                  flex: 2,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    dailytasks.stepTarget =
                        int.parse(stepTargetController.text);
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
