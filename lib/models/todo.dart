class Todo {
  final String title;
  final int id;
  bool done;

  Todo({
    required this.id,
    required this.title,
    required this.done,
  });

  factory Todo.fromJson(Map<dynamic, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      done: json['done'].toLowerCase() == 'true',
    );
  }
}
