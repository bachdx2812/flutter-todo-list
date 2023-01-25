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
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          border: Border.all(
            color: Colors.orangeAccent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
          gradient:
              const LinearGradient(colors: [Colors.black, Colors.orangeAccent]),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, blurRadius: 2.0, offset: Offset(2.0, 2.0))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              todo.title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.amberAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.green.withOpacity(.32);
                }
                return Colors.green;
              }),
              onChanged: (value) {
                updateTodoDone(todo.id, value!);
              },
              value: todo.done,
            ),
          ],
        ),
      ),
    );
  }
}
