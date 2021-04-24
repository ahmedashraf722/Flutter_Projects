class Event {
  String id;
  String _descrizione;
  String _data;
  String _orainizio;
  String _orafine;
  String _relatore;
  bool _isFavourite;

  Event(this.id, this._descrizione, this._data, this._orainizio, this._orafine,
      this._relatore,
      [this._isFavourite = false]);

  String get descrizione => _descrizione;

  String get data => _data;

  String get orainizio => _orainizio;

  String get orafine => _orafine;

  String get relatore => _relatore;

  bool get isFavourite {
    if (_isFavourite == null) {
      return false;
    } else {
      return _isFavourite;
    }
  }

  set isFavourite(bool f) {
    _isFavourite = f;
  }

  Event.map(dynamic obj) {
    this.id = obj['id'];
    this._descrizione = obj['descrizione'];
    this._data = obj['data'];
    this._orainizio = obj['orainizio'];
    this._orafine = obj['orafine'];
    this._relatore = obj['relatore'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['descrizione'] = _descrizione;
    map['data'] = _data;
    map['orainizio'] = _orainizio;
    map['orafine'] = _orafine;
    map['relatore'] = _relatore;
    return map;
  }

  Event.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this._descrizione = map['descrizione'];
    this._data = map['data'];
    this._orainizio = map['orainizio'];
    this._orafine = map['orafine'];
    this._relatore = map['relatore'];
  }
}
