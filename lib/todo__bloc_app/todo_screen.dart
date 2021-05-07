import 'package:flutter/material.dart';
import 'package:flutter_projects/todo__bloc_app/bloc/todo_bloc.dart';
import 'package:flutter_projects/todo__bloc_app/home_page_todo.dart';
import 'data/todo.dart';

class TodoScreen extends StatefulWidget {
  final Todo todo;
  final bool isNew;

  TodoScreen(this.todo, this.isNew);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoBloc bloc = TodoBloc();

  final TextEditingController txtName = TextEditingController();

  final TextEditingController txtDescription = TextEditingController();

  final TextEditingController txtCompleteBy = TextEditingController();

  final TextEditingController txtPriority = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double padding = 20.0;
    txtName.text = widget.todo.name;
    txtDescription.text = widget.todo.description;
    txtCompleteBy.text = widget.todo.completeBy;
    txtPriority.text = widget.todo.priority.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: txtName,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: 'Name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: txtDescription,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Description'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: txtCompleteBy,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Complete by'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: txtPriority,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Priority',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: MaterialButton(
                color: Colors.green,
                child: Text('Save'),
                onPressed: () {
                  setState(() {
                    save().then(
                      (_) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageTodo()),
                          (route) => false),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future save() async {
    widget.todo.name = txtName.text;
    widget.todo.description = txtDescription.text;
    widget.todo.completeBy = txtCompleteBy.text;
    widget.todo.priority = int.tryParse(txtPriority.text);
    if (widget.isNew) {
      bloc.todoInsertSink.add(widget.todo);
    } else {
      bloc.todoUpdateSink.add(widget.todo);
    }
  }
}
