import 'package:flutter/material.dart';
import 'package:todo_list/widgets/todo_list.dart';

import 'models/todo.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> _todosList = [
    Todo(id: 1, title: "eat", done: true),
    Todo(id: 2, title: "sleep", done: false),
    Todo(id: 3, title: "code", done: false),
    Todo(id: 4, title: "workout", done: false),
  ];

  void _updateTodoDone(int id, bool value) {
    int index = _todosList.indexWhere((todo) => todo.id == id); // -1

    if (index != -1) {
      setState(() {
        _todosList[index].done = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TodoList(
              todosList: _todosList,
              updateTodoDone: _updateTodoDone,
            ),
          ],
        ),
      ),
    );
  }
}
