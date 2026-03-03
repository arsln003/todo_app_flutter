import 'dart:convert';

class Todo {
  String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'],
      isDone: map['isDone'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(jsonDecode(source));
}