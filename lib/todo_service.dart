import 'package:shared_preferences/shared_preferences.dart';
import 'todo.dart';

class TodoService {
  static const String key = "todos";

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> todoList =
        todos.map((todo) => todo.toJson()).toList();

    await prefs.setStringList(key, todoList);
  }

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? todoList =
        prefs.getStringList(key);

    if (todoList == null) return [];

    return todoList
        .map((e) => Todo.fromJson(e))
        .toList();
  }
}