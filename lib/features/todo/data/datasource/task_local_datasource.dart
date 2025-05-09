import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_scheduling_app/features/todo/data/model/todo_model.dart';
import 'package:task_scheduling_app/features/todo/domain/entity/todo.dart';

const _todoListKey = 'todo_list';

abstract interface class TaskLocalDataSource {
  Future<List<Todo>> createTask({
    required String title,
    required String description,
    required DateTime dateAndTime,
  });
  Future<List<TodoModel>> getAllTasks();
  Future<List<Todo>> deleteTask({required String id});
  Future<List<Todo>> editTask({
    required String id,
    required String title,
    required String description,
    required DateTime dateAndTime,
  });
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  @override
  Future<List<Todo>> createTask({
    required String title,
    required String description,
    required DateTime dateAndTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    final newTask = TodoModel(
      id: id,
      title: title,
      description: description,
      dateTime: dateAndTime,
    );

    print(newTask.id);
    print(newTask.title);
    print(newTask.description);
    print(newTask.dateTime);

    final existing = prefs.getStringList(_todoListKey) ?? [];
    existing.add(jsonEncode(newTask.toJson()));

    await prefs.setStringList(_todoListKey, existing);

    return getAllTasks();
  }

  @override
  Future<List<TodoModel>> getAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_todoListKey) ?? [];

    final tasks =
        data.map((item) => TodoModel.fromJson(jsonDecode(item))).toList();

    return tasks;
  }

  @override
  Future<List<Todo>> deleteTask({required String id}) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_todoListKey) ?? [];

    final updated = existing.where((item) {
      final map = jsonDecode(item);
      return map['id'] != id;
    }).toList();

    await prefs.setStringList(_todoListKey, updated);
    return getAllTasks();
  }

  @override
  Future<List<Todo>> editTask({
    required String id,
    required String title,
    required String description,
    required DateTime dateAndTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_todoListKey) ?? [];

    final newTask = TodoModel(
      id: id,
      title: title,
      description: description,
      dateTime: dateAndTime,
    );

    final updated = existing.map((item) {
      final map = jsonDecode(item);
      if (map['id'] == newTask.id) {
        return jsonEncode(newTask.toJson());
      }
      return item;
    }).toList();

    await prefs.setStringList(_todoListKey, updated);

    return getAllTasks();
  }
}
