import 'package:flutter/material.dart';
import 'package:flutter_projects/time_to_stream/work_timer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: TimerHomePage(),
    );
  }
}
