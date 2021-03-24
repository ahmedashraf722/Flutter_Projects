import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;

  SettingButton(this.color, this.text, this.value);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      child: Text(text, style: TextStyle(color: Colors.white)),
      onPressed: () {},
    );
  }
}
