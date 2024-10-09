import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_assistant/models/todo_model.dart';

Future<List<TodoModel>> fetchTodos() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((todo) => TodoModel.fromJson(todo)).toList();
  } else {
    throw Exception('failed to load data');
  }
}
