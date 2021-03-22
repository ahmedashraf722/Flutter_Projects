import 'package:flutter/material.dart';
import 'package:flutter_projects/measures_converter.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Projects',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MeasuresConverter(),
    );
  }
}
