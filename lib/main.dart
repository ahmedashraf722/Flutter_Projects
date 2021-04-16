import 'package:flutter/material.dart';
import 'package:flutter_projects/sql_lite_flutter/main_screen_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLiIteF',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MainScreenList(),
    );
  }
}
