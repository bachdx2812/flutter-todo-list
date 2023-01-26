import 'package:flutter/material.dart';
import 'package:todo_list/widgets/todo_item.dart';

import '../models/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.listKey,
    required this.todosList,
    required this.updateTodoDone,
  });

  final List<Todo> todosList;
  final void Function(int id, bool value) updateTodoDone;
  final GlobalKey<AnimatedListState> listKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: AnimatedList(
        key: listKey,
        initialItemCount: todosList.length,
        itemBuilder: (context, index, animation) {
          var todo = todosList[index];
          return TodoItem(
            todo: todo,
            updateTodoDone: updateTodoDone,
            animation: animation,
          );
        },
      ),
    );
  }
}
