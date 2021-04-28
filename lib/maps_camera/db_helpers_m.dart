import 'package:flutter_projects/maps_camera/place.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelperMap {
  final int version = 2;
  Database db;
  List<Place> places = [];
  static final DbHelperMap _dbHelperMap = DbHelperMap._internal();

  DbHelperMap._internal();

  factory DbHelperMap() {
    return _dbHelperMap;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'maps.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE places(id INTEGER PRIMARY KEY, name TEXT, lat DOUBLE, lon DOUBLE, image TEXT)');
      }, version: version);
    }

    return db;
  }

  Future insertMockData() async {
    db = await openDb();
    await db.execute(
        'INSERT INTO places VALUES (1, "Beautiful park", 31.0409, 31.3815,"")');
    await db.execute(
        'INSERT INTO places VALUES (2, "Best Pizza", 31.0409, 31.3785,"")');
    await db.execute(
        'INSERT INTO places VALUES (3, "The best iceCream", 31.0409, 31.3875,"")');

    List places = await db.rawQuery('select * from places');
    print(places[0].toString());
  }

  Future<List<Place>> getPlaces() async {
    final List<Map<String, dynamic>> maps = await db.query('places');
    this.places = List.generate(maps.length, (i) {
      return Place(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['lat'],
        maps[i]['long'],
        maps[i]['image'],
      );
    });
    return places;
  }

  Future<int> insertPlace(Place place) async {
    int id = await db.insert(
      'places',
      place.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> updatePlace(Place place) async {
    // Get a reference to the database.

    int id = await this.db.update(
          'places',
          place.toMap(),
        );
    return id;
  }

  Future<int> deletePlace(Place place) async {
    int result =
        await db.delete("places", where: "id = ?", whereArgs: [place.id]);
    return result;
  }
}
