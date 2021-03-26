import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final String setting;
  final CallbackSetting callback;

  SettingButton(this.color, this.text, this.value, this.setting, this.callback);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      child: Text(text, style: TextStyle(color: Colors.white)),
      onPressed: () => callback(setting, value),
    );
  }
}
