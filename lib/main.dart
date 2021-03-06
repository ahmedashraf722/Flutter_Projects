import 'package:flutter/material.dart';
import 'package:flutter_projects/todo__bloc_app/home_page_todo.dart';

//import 'package:flutter_projects/maps_camera/main_map.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'fire_base/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //testData();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePageTodo(),
    );
  }

/*Future testData() async {
    FirebaseFirestore fb = FirebaseFirestore.instance;
    var data = await fb.collection('event_details').get();
    var details = data.docs.toList();
    details.forEach((e) {
      print(e.id);
    });
  }*/
}
