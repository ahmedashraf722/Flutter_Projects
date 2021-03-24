import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;

  final VoidCallback onClicked;

  ProductivityButton({
    @required this.color,
    @required this.text,
    @required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(text, style: TextStyle(color: Colors.white)),
      color: color,
      onPressed: onClicked,
    );
  }
}
