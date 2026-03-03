import 'package:flutter/material.dart';
import 'todo.dart';
import 'todo_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoService _service = TodoService();
  final TextEditingController _controller =
      TextEditingController();

  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    todos = await _service.loadTodos();
    setState(() {});
  }

  void _addTodo() async {
    if (_controller.text.isEmpty) return;

    todos.add(Todo(title: _controller.text));
    await _service.saveTodos(todos);

    _controller.clear();
    setState(() {});
  }

  void _toggle(int index) async {
    todos[index].isDone = !todos[index].isDone;
    await _service.saveTodos(todos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo App")),
      body: Column(
        children: [
          TextField(controller: _controller),
          ElevatedButton(
            onPressed: _addTodo,
            child: const Text("Add"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    todos[index].title,
                    style: TextStyle(
                      decoration: todos[index].isDone
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  onTap: () => _toggle(index),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}