class Place {
  int id;
  String name;
  double lat;
  double long;
  String image;

  Place(
    this.id,
    this.name,
    this.lat,
    this.long,
    this.image,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'name': name,
      'latitude': lat,
      'longitude': long,
      'image': image,
    };
  }
}
