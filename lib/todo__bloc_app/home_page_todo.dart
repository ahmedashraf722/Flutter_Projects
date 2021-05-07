import 'package:flutter/material.dart';
import 'package:flutter_projects/todo__bloc_app/data/todo.dart';
import 'package:flutter_projects/todo__bloc_app/data/todo_db.dart';

class HomePageTodo extends StatefulWidget {
  @override
  _HomePageTodoState createState() => _HomePageTodoState();
}

class _HomePageTodoState extends State<HomePageTodo> {
  Future _testData() async {
    TodoDb db = TodoDb();
    await db.database;
    List<Todo> todoS = await db.getTodoS();
    await db.deleteAll();
    await db.insertTodo(
        Todo('Call Donald', 'And tell him about Daisy', '7/5/2021', 1));
    await db.insertTodo(Todo('Buy Sugar', '1 Kg, brown', '7/5/2021', 2));
    await db.insertTodo(
        Todo('Go Running', '@12.00, with neighbours', '7/5/2021', 3));
    todoS = await db.getTodoS();
    Todo todoToUpdate = todoS[0];
    todoToUpdate.name = 'Call Tim';
    await db.updateTodo(todoToUpdate);
    Todo todoToDelete = todoS[1];
    await db.deleteTodo(todoToDelete);
    debugPrint('After Updates');
    todoS = await db.getTodoS();
    todoS.forEach((Todo todo) {
      debugPrint(todo.name);
    });
    /*debugPrint('First insert');
    todoS.forEach((Todo todo) {
      debugPrint(todo.name);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    _testData();
    return Container(
      color: Colors.redAccent,
    );
  }
}
