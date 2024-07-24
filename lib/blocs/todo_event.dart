// blocs/todo_event.dart

import '../models/todo.dart';

abstract class TodoEvent {}

class TodoLoad extends TodoEvent {}

class TodoAdd extends TodoEvent {
  final Todo todo;

  TodoAdd(this.todo);
}

class TodoUpdate extends TodoEvent {
  final Todo updatedTodo;

  TodoUpdate(this.updatedTodo);
}

class TodoDelete extends TodoEvent {
  final Todo todo;

  TodoDelete(this.todo);
}
