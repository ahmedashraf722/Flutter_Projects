import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  @override
  Widget build(BuildContext context) {
    final double d = 35;
    return Center(
      child: Container(
        width: d,
        height: d,
        decoration: BoxDecoration(
          color: Color(0xffff7a00),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
