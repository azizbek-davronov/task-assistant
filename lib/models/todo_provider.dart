import 'package:flutter/material.dart';
import 'package:task_assistant/models/todo_model.dart';
import 'package:task_assistant/services/api_service.dart';
import 'package:task_assistant/services/todo_service.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _todos = [];
  List<TodoModel> _apiTodos = [];
  final TodoService _todoService = TodoService();

  // Получение списка задач
  List<TodoModel> get todos => _todos;
  List<TodoModel> get apiTodos => _apiTodos;

  // Загрузка задач из локального хранилища и API
  Future<void> loadTodos() async {
    _todos = await _todoService.getTodos();
    _apiTodos = await fetchTodos();
    notifyListeners();
  }

  // Добавление новой задачи
  void addTodo(String title) {
    final newTodo = TodoModel(
      id: _todos.length + 1,
      title: title,
    );
    _todos.add(newTodo);
    _todoService.saveTodos(_todos);
    notifyListeners();
  }

  // Удаление задачи
  void deleteTodo(TodoModel todo) {
    _todos.remove(todo);
    _todoService.saveTodos(_todos);
    notifyListeners();
  }

  // Обновление статуса задачи
  void toggleTodoCompletion(TodoModel todo) {
    todo.completed = !todo.completed;
    _todoService.saveTodos(_todos);
    notifyListeners();
  }
}
