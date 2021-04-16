import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as https;
import 'movie.dart';

class HttpHelperApp {
  //var urlKey = Uri.parse('4f3c518b3ef64a1cc90a8bf28f82cee2');
  var urlBase = Uri.parse(
      'https://api.themoviedb.org/3/movie/550?api_key=A4f3c518b3ef64a1cc90a8bf28f82cee////A2&language=en-US');

  var urlSearchBase = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=A4f3c518b3ef64a1cc90a8bf28f82ceea2&query=3');

  Future<List> getUpComing() async {
    var upcoming = urlBase;
    https.Response result = await https.get(upcoming);
    //var myResult = await https.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      List moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((e) {
        Movie.fromJson(e);
      }).toList();
      return movies;
    } else {
      return null;
    }
  }

  Future<List> findMovies(String title) async {
    var query = urlSearchBase;
    https.Response result = await https.get(query);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final List moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
