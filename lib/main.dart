import 'package:flutter/material.dart';

import './widgets/todo_list.dart';
import './widgets/todo_search.dart';
import './widgets/todo_new.dart';

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
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  void _createNewToto(Todo todo) {
    setState(() {
      _todosList.insert(0, todo);
    });
  }

  void _startAddNewTodo(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: TodoNew(
              createNewTodo: _createNewToto,
            ),
          );
        });
  }

  String _searchText = "";

  List<Todo> get _filteredList =>
      _todosList.where((todo) => todo.title.contains(_searchText)).toList();

  void _searchTodo(String text) {
    setState(() {
      _searchText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TodoSearch(
              searchText: _searchText,
              searchTodo: _searchTodo,
            ),
            TodoList(
              todosList: _filteredList,
              updateTodoDone: _updateTodoDone,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTodo(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
