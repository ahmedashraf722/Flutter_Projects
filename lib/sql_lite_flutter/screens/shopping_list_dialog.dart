import 'package:flutter/material.dart';
import 'package:flutter_projects/sql_lite_flutter/models/shopping_list.dart';
import 'package:flutter_projects/sql_lite_flutter/sql_lite_helper/data_base_helper.dart';

class ShoppingListDialog {
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew) {
    DbHelper helper = DbHelper();
    if (!isNew) {
      txtName.text = list.name;
      txtPriority.text = list.priority.toString();
    }
    return AlertDialog(
      title: Text((isNew) ? 'New shopping list' : 'Edit shopping list'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(hintText: 'Shopping List Name'),
            ),
            TextField(
              controller: txtPriority,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(hintText: 'Shopping List Priority (1-3)'),
            ),
            ElevatedButton(
              child: Text('Saved Shopping List'),
              onPressed: () {
                list.name = txtName.text;
                list.priority = int.parse(txtPriority.text);
                helper.insertList(list);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
