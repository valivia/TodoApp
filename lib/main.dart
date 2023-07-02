import 'package:flutter/material.dart';
import 'package:todo_flutter/db.dart';
import 'package:todo_flutter/theme/dark.dart';
import './views/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbService.instance.initDB();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      home: const HomeView(),
    );
  }
}
