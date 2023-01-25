import 'package:flutter/material.dart';
import 'package:todo_list/widgets/todo_item.dart';

import '../models/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todosList,
    required this.updateTodoDone,
  });

  final List<Todo> todosList;
  final void Function(int id, bool value) updateTodoDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: todosList
          .map(
            (todo) => TodoItem(
              todo: todo,
              updateTodoDone: updateTodoDone,
            ),
          )
          .toList(),
    );
  }
}
