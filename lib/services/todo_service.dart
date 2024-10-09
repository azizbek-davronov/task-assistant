import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_assistant/models/todo_model.dart';

class TodoService {
  static const String _key = 'todos';

  // Получение сохраненных задач
  Future<List<TodoModel>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString(_key);

    if (todosString != null) {
      List<dynamic> jsonList = jsonDecode(todosString);
      return jsonList.map((json) => TodoModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  // Сохранение списка задач
  Future<void> saveTodos(List<TodoModel> todos) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }
}
