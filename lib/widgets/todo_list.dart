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
    return SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: todosList.length,
        itemBuilder: (context, index) {
          var todo = todosList[index];

          return TodoItem(
            todo: todo,
            updateTodoDone: updateTodoDone,
          );
        },
      ),
    );
  }
}
