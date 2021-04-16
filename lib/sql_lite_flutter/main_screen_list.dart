import 'package:flutter/material.dart';
import 'package:flutter_projects/sql_lite_flutter/sql_lite_helper/data_base_helper.dart';

import 'models/shopping_list.dart';
import 'screens/items_screen.dart';
import 'screens/shopping_list_dialog.dart';

class MainScreenList extends StatefulWidget {
  @override
  _MainScreenListState createState() => _MainScreenListState();
}

class _MainScreenListState extends State<MainScreenList> {
  List<ShoppingList> shoppingList;
  DbHelper dbHelper = DbHelper();
  ShoppingListDialog dialog;

  @override
  void initState() {
    dialog = ShoppingListDialog();
    super.initState();
  }

  Future showData() async {
    await dbHelper.openDb();
    shoppingList = await dbHelper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView.builder(
        itemCount: (shoppingList != null) ? shoppingList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(shoppingList[index].name),
            child: ListTile(
              title: Text(shoppingList[index].name),
              leading: CircleAvatar(
                child: Text(shoppingList[index].priority.toString()),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemsScreen(shoppingList[index]),
                  ),
                );
              },
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        dialog.buildDialog(context, shoppingList[index], false),
                  );
                },
              ),
            ),
            onDismissed: (direction) {
              String strName = shoppingList[index].name;
              dbHelper.deleteList(shoppingList[index]);
              setState(() {
                shoppingList.removeAt(index);
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("$strName deleted")));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                dialog.buildDialog(context, ShoppingList(0, '', 0), true),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}
