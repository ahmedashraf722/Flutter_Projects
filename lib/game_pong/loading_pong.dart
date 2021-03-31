import 'package:flutter/material.dart';
import 'package:flutter_projects/game_pong/pong_game.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purpleAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Pong()),
                  (route) => false);
            },
            child: Text(
              "Play",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.deepOrangeAccent,
          )),
        ],
      ),
    );
  }
}
