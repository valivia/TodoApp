import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/daily_tasks.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailytasks = Provider.of<DailyTasks>(context);
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Settings'),
      ),
    );
  }
}
