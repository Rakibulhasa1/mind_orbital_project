// pages/todo_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo_bloc.dart';
import '../blocs/todo_event.dart';
import '../blocs/todo_state.dart';
import '../models/todo.dart';

class TodoPage extends StatelessWidget {
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To Do')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _todoController,
              decoration: InputDecoration(labelText: 'New To Do'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newTodo = Todo(
                id: '',
                title: _todoController.text,
                completed: false,
              );
              BlocProvider.of<TodoBloc>(context).add(TodoAdd(newTodo));
              _todoController.clear();
            },
            child: Text('Add To Do'),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: state.todos.length,
          //     itemBuilder: (context, index) {
          //       final todo = state.todos[index];
          //       return ListTile(
          //         title: Text(todo.title),
          //         trailing: IconButton(
          //           icon: Icon(Icons.delete),
          //           onPressed: () {
          //             BlocProvider.of<TodoBloc>(context).add(TodoDelete(todo));
          //           },
          //         ),
          //         onTap: () {
          //           // Handle todo completion toggle
          //           // final updatedTodo = todo.copyWith(completed: !todo.completed);
          //           // BlocProvider.of<TodoBloc>(context).add(TodoUpdate(updatedTodo));
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
