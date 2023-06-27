import 'package:flutter/material.dart';
import 'package:todo_flutter/theme/dark.dart';
import './views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      home: const MyHomePage(title: 'Daily Tasks'),
    );
  }
}
