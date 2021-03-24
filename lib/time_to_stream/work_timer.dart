import 'package:flutter/material.dart';
import 'package:flutter_projects/time_to_stream/button_productivity.dart';
import 'package:flutter_projects/time_to_stream/counter_down_timer.dart';
import 'package:flutter_projects/time_to_stream/settings_screen.dart';
import 'package:flutter_projects/time_to_stream/timer_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerHomePage extends StatefulWidget {
  @override
  _TimerHomePageState createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  final double defaultPadding = 5.0;

  final CounterDownTimer timer = CounterDownTimer();

  void goToSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingScreen()));
  }

  Widget build(BuildContext context) {
    timer.startWork(); //important receiver so null app stream
    final List<PopupMenuItem<String>> menuItems = [];
    menuItems.add(
      PopupMenuItem(
        value: 'Settings',
        child: Text('Settings'),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              if (s == 'Settings') {
                goToSettings(context);
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff009688),
                      text: "Work",
                      onClicked: () => timer.startWork(),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff607D8B),
                      text: "Short Break",
                      onClicked: () => timer.startBreak(true),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff455A64),
                      text: "Long Break",
                      onClicked: () => timer.startBreak(false),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
              StreamBuilder(
                initialData: "00:00",
                stream: timer.stream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  TimerModel timer = (snapshot.data == '00:00')
                      ? TimerModel('00:00', 1)
                      : snapshot.data;
                  return Expanded(
                    child: CircularPercentIndicator(
                      radius: availableWidth / 2,
                      lineWidth: 10.0,
                      percent: timer.percent,
                      center: Text(
                        timer.time,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      progressColor: Color(0xff009688),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff212121),
                      text: 'Stop',
                      onClicked: () => timer.stopTimer(),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff009688),
                      text: 'Restart',
                      onClicked: () => timer.startTimer(),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
