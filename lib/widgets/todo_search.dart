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
  final searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: searchTextController,
            ),
          ),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
              ),
              onPressed: () {
                widget.searchTodo(searchTextController.text);
              },
              child: const Text('Search'),
            ),
          )
        ],
      ),
    );
  }
}
