import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/fire_base/widgets/events.dart';
import 'package:flutter_projects/fire_base/widgets/login.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SplashPage> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot snapshot) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EventsScreen(
                          title: "Events",
                          uid: user.uid,
                        ))))
            .catchError((err) => print(err));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}
