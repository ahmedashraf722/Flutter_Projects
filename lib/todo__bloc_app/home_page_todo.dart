import 'package:flutter/material.dart';
import 'package:flutter_projects/todo__bloc_app/data/todo.dart';
import 'package:flutter_projects/todo__bloc_app/todo_screen.dart';
import 'bloc/todo_bloc.dart';

class HomePageTodo extends StatefulWidget {
  @override
  _HomePageTodoState createState() => _HomePageTodoState();
}

class _HomePageTodoState extends State<HomePageTodo> {
  TodoBloc todoBloc;
  List<Todo> todos;

  @override
  void initState() {
    todoBloc = TodoBloc();
    super.initState();
  }

  @override
  void dispose() {
    todoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_testData();
    Todo todo = Todo('', '', '', 0);
    todos = todoBloc.todoList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Bloc List"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoScreen(todo, true)),
          );
        },
      ),
      body: Container(
        child: StreamBuilder<List<Todo>>(
          stream: todoBloc.todoS,
          initialData: todos,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemCount: (snapshot.hasData) ? snapshot.data.length : 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data[index].id.toString()),
                  onDismissed: (_) {
                    todoBloc.todoDeleteSink.add(snapshot.data[index]);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).highlightColor,
                      child: Text("${snapshot.data[index].priority}"),
                    ),
                    title: Text("${snapshot.data[index].name}"),
                    subtitle: Text("${snapshot.data[index].description}"),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodoScreen(todo, false)));
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

/* Future _testData() async {
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
    */ /*debugPrint('First insert');
    todoS.forEach((Todo todo) {
      debugPrint(todo.name);
    });*/ /*
  }*/

}
