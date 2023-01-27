import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  List<Todo> _todosList = [];

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    _todosList = [];

    final response = await http
        .get(Uri.parse('http://localhost:3000/todos?title_like=$_searchText'));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);

      setState(() {
        for (Map todo in responseJson) {
          _todosList.add(Todo.fromJson(todo));
        }
      });
    } else {
      throw Exception('Failed to load todo');
    }
  }

  void _updateTodoDone(int id, bool value) {
    int index = _todosList.indexWhere((todo) => todo.id == id); // -1

    if (index != -1) {
      setState(() {
        _todosList[index].done = value;
      });
    }
  }

  Future<void> _createNewToto(Todo todo) async {
    setState(() => _todosListKey = GlobalKey());

    Map data = {
      'title': todo.title,
      'done': false.toString(),
    };

    final response = await http.post(
      Uri.parse('http://localhost:3000/todos'),
      body: data,
    );

    if (response.statusCode == 201) {
      setState(() {
        _todosList.insert(0, Todo.fromJson(json.decode(response.body)));
        _todosListKey.currentState?.insertItem(0);
      });
    } else {
      throw Exception('Failed to load todo');
    }
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
      },
    );
  }

  String _searchText = "";
  var _todosListKey = GlobalKey<AnimatedListState>();

  List<Todo> get _filteredList {
    setState(() => _todosListKey = GlobalKey());

    return _todosList
        .where(
          (element) => element.title.contains(_searchText),
        )
        .toList();
  }

  void _searchTodo(String text) {
    setState(() {
      _searchText = text;
    });

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TodoSearch(
              searchText: _searchText,
              searchTodo: _searchTodo,
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: const Text(
                  'All ToDos',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: TodoList(
                listKey: _todosListKey,
                todosList: _filteredList,
                updateTodoDone: _updateTodoDone,
              ),
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
