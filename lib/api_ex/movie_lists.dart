import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_projects/api_ex/https_helper_app.dart';
import 'package:http/http.dart' as https;

class MovieLists extends StatefulWidget {
  @override
  _MovieListsState createState() => _MovieListsState();
}

class _MovieListsState extends State<MovieLists> {
  HttpHelperApp httpHelperApp;
  String result;
  int moviesCount;
  List movies;

  var worldData;

  fetchWorldWideData() async {
    WidgetsFlutterBinding.ensureInitialized();
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/550?api_key=A4f3c518b3ef64aA1cc90a8bf28f82ceeA2&language=en-US');
    https.Response result = await https.get(url);
    setState(() {
      worldData = json.decode(result.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    //httpHelperApp = HttpHelperApp();
    ///initialize();
    super.initState();
  }

  /*Future initialize() async {
    movies = [];
    movies = await httpHelperApp.getUpComing();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    /*httpHelperApp.getUpComing().then((value) {
      setState(() {
        result = value ?? "";
      });
    });*/
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: Text(worldData.toString()),
    );
  }
}
