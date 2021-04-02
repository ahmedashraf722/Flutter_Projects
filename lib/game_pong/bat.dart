import 'package:flutter/material.dart';

class Bat extends StatelessWidget {
  final double width;
  final double height;

  const Bat(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xffd44000),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
