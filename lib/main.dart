import 'package:flutter/material.dart';
import 'package:flutter_projects/game_pong/pong_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pong',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Pong(),
    );
  }
}
