import 'package:flutter_projects/sql_lite_flutter/models/items_list.dart';
import 'package:flutter_projects/sql_lite_flutter/models/shopping_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 2;
  Database db;
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future testDb() async {
    db = await openDb();
    await db.execute('INSERT INTO lists VALUES (0, "Fruit", 1)');
    await db.execute(
        'INSERT INTO items VALUES(0, 0, "Apples", "2 Kg", "Better if they are green")');
    List lists = await db.rawQuery('select * from lists');
    List items = await db.rawQuery('select * from items');
    print(lists[0].toString());
    print(items[0].toString());
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(
        join(await getDatabasesPath(), 'shopping.db'),
        onCreate: (database, version) {
          database.execute(
              'CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
          database.execute(
              'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity TEXT, note TEXT, ' +
                  'FOREIGN KEY(idList) REFERENCES lists(id))');
        },
        version: version,
      );
    }
    return db;
  }

  Future<int> insertList(ShoppingList shoppingList) async {
    int id = await db.insert(
      'lists',
      shoppingList.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<ShoppingList>> getLists() async {
    final List<Map<String, dynamic>> maps = await db.query('lists');
    return List.generate(
      maps.length,
      (index) {
        return ShoppingList(
          maps[index]['id'],
          maps[index]['name'],
          maps[index]['priority'],
        );
      },
    );
  }

  Future<int> insertItem(ListItem listItem) async {
    int id = await db.insert(
      'items',
      listItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<ListItem>> getItems(int idList) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      where: 'idList = ?',
      whereArgs: [idList],
    );
    return List.generate(
      maps.length,
      (index) {
        return ListItem(
          maps[index]['id'],
          maps[index]['idList'],
          maps[index]['name'],
          maps[index]['quantity'],
          maps[index]['note'],
        );
      },
    );
  }

  Future<int> deleteList(ShoppingList list) async {
    int result = await db.delete(
      'items',
      where: "idList = ?",
      whereArgs: [list.id],
    );
    result = await db.delete(
      'lists',
      where: "id = ?",
      whereArgs: [list.id],
    );
    return result;
  }
}
