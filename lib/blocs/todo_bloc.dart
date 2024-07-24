// blocs/todo_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import '../models/todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> todos = []; // Initial empty list of todos

  TodoBloc() : super(TodoLoading());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoLoad) {
      yield* _mapLoadToState();
    } else if (event is TodoAdd) {
      yield* _mapAddToState(event);
    } else if (event is TodoUpdate) {
      yield* _mapUpdateToState(event);
    } else if (event is TodoDelete) {
      yield* _mapDeleteToState(event);
    }
  }

  Stream<TodoState> _mapLoadToState() async* {
    yield TodoLoading();
    try {
      final response = await http.get(Uri.parse('https://669666110312447373c26117.mockapi.io/todos'));
      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        todos = json.map((e) => Todo.fromJson(e)).toList();
        yield TodoLoaded(List.from(todos));
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      yield TodoError('Failed to load todos');
    }
  }

  Stream<TodoState> _mapAddToState(TodoAdd event) async* {
    try {
      // Simulate adding todo to API
      await Future.delayed(Duration(seconds: 1));
      todos.add(event.todo); // Replace with actual API call to add todo
      yield TodoLoaded(List.from(todos));
    } catch (e) {
      yield TodoError('Failed to add todo');
    }
  }

  Stream<TodoState> _mapUpdateToState(TodoUpdate event) async* {
    try {
      // Simulate updating todo in API
      await Future.delayed(Duration(seconds: 1));
      final index = todos.indexWhere((todo) => todo.id == event.updatedTodo.id);
      if (index >= 0) {
        todos[index] = event.updatedTodo; // Replace with actual API call to update todo
      }
      yield TodoLoaded(List.from(todos));
    } catch (e) {
      yield TodoError('Failed to update todo');
    }
  }

  Stream<TodoState> _mapDeleteToState(TodoDelete event) async* {
    try {
      // Simulate deleting todo in API
      await Future.delayed(Duration(seconds: 1));
      todos.removeWhere((todo) => todo.id == event.todo.id); // Replace with actual API call to delete todo
      yield TodoLoaded(List.from(todos));
    } catch (e) {
      yield TodoError('Failed to delete todo');
    }
  }
}
