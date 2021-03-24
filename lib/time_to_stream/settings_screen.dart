import 'package:flutter/material.dart';
import 'package:flutter_projects/time_to_stream/settings_button.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextStyle textStyle = TextStyle(fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: settings(),
    );
  }

  Widget settings() {
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingButton(Color(0xff455A64), "-", -1),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingButton(Color(0xff009688), "+", 1),
          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingButton(Color(0xff455A64), "-", -1),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingButton(Color(0xff009688), "+", 1),
          Text("Long", style: textStyle),
          Text(""),
          Text(""),
          SettingButton(Color(0xff455A64), "-", -1),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingButton(Color(0xff009688), "+", 1),
        ],
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}
