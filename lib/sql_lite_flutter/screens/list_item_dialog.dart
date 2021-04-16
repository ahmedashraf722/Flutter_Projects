import 'package:flutter/material.dart';
import 'package:flutter_projects/sql_lite_flutter/models/items_list.dart';
import 'package:flutter_projects/sql_lite_flutter/sql_lite_helper/data_base_helper.dart';

class ListItemDialog {
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();

  Widget buildAlert(BuildContext context, ListItem item, bool isNew) {
    DbHelper helper = DbHelper();
    helper.openDb();
    if (!isNew) {
      txtName.text = item.name;
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;
    }
    return AlertDialog(
      title: Text((isNew) ? 'New shopping item' : 'Edit shopping item'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(hintText: 'Item Name'),
            ),
            TextField(
              controller: txtQuantity,
              decoration: InputDecoration(hintText: 'Quantity'),
            ),
            TextField(
              controller: txtNote,
              decoration: InputDecoration(hintText: 'Note'),
            ),
            ElevatedButton(
              onPressed: () {
                item.name = txtName.text;
                item.quantity = txtQuantity.text;
                item.note = txtNote.text;
                helper.insertItem(item);
                Navigator.pop(context);
              },
              child: Text('Saved Item'),
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
