import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.updateTodoDone,
  });

  final Todo todo;
  final void Function(int id, bool value) updateTodoDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(todo.title),
        Checkbox(
          onChanged: (value) {
            updateTodoDone(todo.id, value!);
          },
          value: todo.done,
        ),
      ],
    );
  }
}
