import 'dart:io';
import 'package:flutter_projects/todo__bloc_app/data/todo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TodoDb {
  //needs to be a singleton
  static final TodoDb _singleton = TodoDb._internal();

  //private internal constructor
  TodoDb._internal();

  factory TodoDb() {
    return _singleton;
  }

  DatabaseFactory databaseFactory = databaseFactoryIo;
  final store = intMapStoreFactory.store('todoS');
  Database _database;

  Future get database async {
    if (_database == null) {
      await _openDb().then((db) {
        _database = db;
      });
    }

    return _database;
  }

  Future _openDb() async {
    final Directory docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, 'todoS.db');
    final db = await databaseFactory.openDatabase(dbPath);
    return db;
  }

  Future insertTodo(Todo todo) async {
    await store.add(_database, todo.toMap());
  }

  Future updateTodo(Todo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.update(_database, todo.toMap(), finder: finder);
  }

  Future deleteTodo(Todo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.delete(_database, finder: finder);
  }

  Future deleteAll() async {
    await store.delete(_database);
  }

  Future<List<Todo>> getTodoS() async {
    await database;
    final finder = Finder(
      sortOrders: [
        SortOrder('priority'),
        SortOrder('id'),
      ],
    );
    final todoSSnapshot = await store.find(_database, finder: finder);
    return todoSSnapshot.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      //the id is automatically generated
      todo.id = snapshot.key;
      return todo;
    }).toList();
  }
}
