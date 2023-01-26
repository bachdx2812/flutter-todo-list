import 'dart:math';

import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoNew extends StatefulWidget {
  const TodoNew({
    super.key,
    required this.createNewTodo,
  });

  final void Function(Todo todo) createNewTodo;

  @override
  State<TodoNew> createState() => _TodoNewState();
}

class _TodoNewState extends State<TodoNew> {
  final _titleController = TextEditingController();

  void _submit(context) {
    final enteredTitle = _titleController.text;
    var todo =
        Todo(id: (Random()).nextInt(1000), title: enteredTitle, done: false);

    widget.createNewTodo(todo);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _submit(context);
              },
              child: const Text('Submit'),
            ),
          ],
        )
      ],
    );
  }
}
