import 'package:flutter/material.dart';
import 'package:to_do/screens/list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListScreen(),
    );
  }
}
