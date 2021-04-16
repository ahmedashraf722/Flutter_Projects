import 'package:flutter/material.dart';
import 'package:flutter_projects/sql_lite_flutter/models/items_list.dart';
import 'package:flutter_projects/sql_lite_flutter/models/shopping_list.dart';
import 'package:flutter_projects/sql_lite_flutter/sql_lite_helper/data_base_helper.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;

  ItemsScreen(this.shoppingList);

  @override
  _ItemsScreenState createState() => _ItemsScreenState(this.shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList shoppingList;
  DbHelper helper;
  List<ListItem> items;

  _ItemsScreenState(this.shoppingList);

  Future showData(int idList) async {
    await helper.openDb();
    items = await helper.getItems(idList);
  }

  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    //helper.openDb();
    showData(this.shoppingList.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: ListView.builder(
        itemCount: (items != null) ? items.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(items[index].name),
            subtitle: Text(
              'Quantity: ${items[index].quantity} - Note:  ${items[index].note}',
            ),
            onTap: () {},
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
