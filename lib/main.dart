import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/db.dart';
import 'package:todo_flutter/theme/dark.dart';
import './views/home.dart';
import 'state/daily_tasks.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbService().initDB();
  await DailyTasks().loadTasks();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DailyTasks(),
      child: MaterialApp(
        title: 'Todo App',
        theme: darkTheme,
        home: const HomeView(),
      ),
    );
  }
}
