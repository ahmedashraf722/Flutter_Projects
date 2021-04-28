import 'package:flutter/material.dart';
import 'package:flutter_projects/maps_camera/db_helpers_m.dart';
import 'package:flutter_projects/maps_camera/place.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainMap extends StatefulWidget {
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  List<Marker> _markers = [];
  DbHelperMap dbHelperMap;

  final CameraPosition position = CameraPosition(
    target: LatLng(31.0409, 31.3785),
    zoom: 12,
  );

  Future _getCurrentLocation() async {
    bool isGeolocationAvailable = await Geolocator.isLocationServiceEnabled();
    Position _position = Position(
      longitude: position.target.longitude,
      latitude: position.target.latitude,
      heading: null,
      speed: null,
      speedAccuracy: null,
      altitude: null,
      timestamp: null,
      accuracy: null,
    );
    if (isGeolocationAvailable) {
      try {
        _position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        print('ok');
      } catch (error) {
        return _position;
      }
    }
    return _position;
  }

  void _addMarker(Position pos, String markerId, String markerTitle) {
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: LatLng(pos.latitude, pos.longitude),
      infoWindow: InfoWindow(title: markerTitle),
      icon: (markerId == "currentPos")
          ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
          : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );
    _markers.add(marker);
    setState(() {
      _markers = _markers;
    });
  }

  Future _getData() async {
    await dbHelperMap.openDb();

    List<Place> _places = await dbHelperMap.getPlaces();
    for (Place p in _places) {
      var pp = Position(
        latitude: p.lat,
        longitude: p.long,
      );
      _addMarker(
        pp,
        p.id.toString(),
        p.name,
      );
    }
    setState(() {
      _markers = _markers;
    });
  }

  @override
  void initState() {
    dbHelperMap = DbHelperMap();
    dbHelperMap.insertMockData();
    _getData();
    _getCurrentLocation()
        .then((pos) => _addMarker(pos, "currentPos", "You are here!"))
        .catchError((err) => print(err.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
      ),
      body: Container(
        child: GoogleMap(
          initialCameraPosition: position,
          markers: Set<Marker>.of(_markers),
        ),
      ),
    );
  }
}
