import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TodoService Tests', () {
    late TodoService service;

    setUp(() {
      service = TodoService();
      SharedPreferences.setMockInitialValues({});
    });

    test('Save Todos stores data', () async {
      List<Todo> todos = [
        Todo(title: "Test Todo", isDone: false),
      ];

      await service.saveTodos(todos);

      final prefs =
          await SharedPreferences.getInstance();

      final stored =
          prefs.getStringList("todos");

      expect(stored, isNotNull);
      expect(stored!.length, 1);
    });

    test('Load Todos retrieves correct data',
        () async {
      SharedPreferences.setMockInitialValues({
        "todos": [
          Todo(title: "Loaded", isDone: true)
              .toJson()
        ]
      });

      final result = await service.loadTodos();

      expect(result.length, 1);
      expect(result[0].title, "Loaded");
      expect(result[0].isDone, true);
    });
  });
}