import 'package:flutter/material.dart';
import 'package:flutter_projects/fire_base/screens/events_list.dart';
import 'package:flutter_projects/fire_base/screens/login_screen.dart';
import 'package:flutter_projects/fire_base/shared/authentication.dart';

class EventScreen extends StatelessWidget {
  final String uid;

  EventScreen(this.uid);

  @override
  Widget build(BuildContext context) {
    Authentication auth = Authentication();
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              auth.signOut().then((result) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            },
          )
        ],
      ),
      body: EventList(uid),
    );
  }
}
