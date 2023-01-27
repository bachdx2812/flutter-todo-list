import 'package:flutter/material.dart';

class TodoSearch extends StatefulWidget {
  const TodoSearch(
      {super.key, required this.searchText, required this.searchTodo});

  final String searchText;
  final void Function(String searchText) searchTodo;

  @override
  State<TodoSearch> createState() => _TodoSearchState();
}

class _TodoSearchState extends State<TodoSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => widget.searchTodo(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
