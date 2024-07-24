import 'package:http/http.dart' as http;
import 'dart:convert';


import '../models/todo.dart';

class TodoRepository {
  final String baseUrl = "https://669666110312447373c26117.mockapi.io/todos";

  Future<List<Todo>> loadTodos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List todos = json.decode(response.body);
      return todos.map((todo) => Todo.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> update(Todo todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${todo.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> delete(Todo todo) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/${todo.id}'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
