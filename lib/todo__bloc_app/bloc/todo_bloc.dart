import 'dart:async';

import 'package:flutter_projects/todo__bloc_app/data/todo.dart';
import 'package:flutter_projects/todo__bloc_app/data/todo_db.dart';

class TodoBloc {
  TodoDb db;
  List<Todo> todoList;

  final _todosStreamController = StreamController<List<Todo>>.broadcast();
  final _todoInsertController = StreamController<Todo>();
  final _todoUpdateController = StreamController<Todo>();
  final _todoDeleteController = StreamController<Todo>();

  TodoBloc() {
    db = TodoDb();
    getTodos();
    _todosStreamController.stream.listen(returnTodos);
    _todoInsertController.stream.listen(_addTodo);
    _todoUpdateController.stream.listen(_updateTodo);
    _todoDeleteController.stream.listen(_deleteTodo);
  }

  Stream<List<Todo>> get todoS => _todosStreamController.stream;

  StreamSink<List<Todo>> get todosSink => _todosStreamController.sink;

  StreamSink<Todo> get todoInsertSink => _todoInsertController.sink;

  StreamSink<Todo> get todoUpdateSink => _todoUpdateController.sink;

  StreamSink<Todo> get todoDeleteSink => _todoDeleteController.sink;

  Future getTodos() async {
    List<Todo> todoS = await db.getTodoS();
    todoList = todoS;
    todosSink.add(todoS);
  }

  List<Todo> returnTodos(todos) {
    return todos;
  }

  void _updateTodo(Todo todo) {
    db.updateTodo(todo).then((value) => getTodos());
  }

  void _addTodo(Todo todo) {
    db.insertTodo(todo).then((value) => getTodos());
  }

  void _deleteTodo(Todo todo) {
    db.deleteTodo(todo).then((value) => getTodos());
  }

  void dispose() {
    _todosStreamController.close();
    _todoInsertController.close();
    _todoUpdateController.close();
    _todoDeleteController.close();
  }
}
