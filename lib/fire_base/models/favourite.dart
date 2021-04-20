import 'package:cloud_firestore/cloud_firestore.dart';

class Favourite {
  String id;
  String _eventId;
  String _userId;

  Favourite(this.id, this._eventId, this._userId);

  String get eventId => _eventId;

  String get userId => _userId;

  Favourite.map(dynamic obj) {
    this.id = obj['id'];
    this._eventId = obj['eventId'];
    this._userId = obj['userId'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['eventId'] = _eventId;
    map['userId'] = _userId;

    return map;
  }

  Favourite.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this._eventId = map['eventId'];
    this._userId = map['userId'];
  }
}
