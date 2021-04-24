import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_projects/fire_base/models/event_detail.dart';
import 'package:flutter_projects/fire_base/models/favourite.dart';

class FireStoreHelper {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<List<Favourite>> getUserFavourites(String uid) async {
    List<Favourite> fV = [];

    QuerySnapshot docs =
        await db.collection('favourites').where('userId', isEqualTo: uid).get();

    if (docs != null) {
      for (DocumentSnapshot doc in docs.docs) {
        fV.add(Favourite.map(doc));
      }
    }
    return fV;
  }

  static Future addFavourite(EventDetail eventDetail, String uid) {
    Favourite fav = Favourite(null, eventDetail.id, uid);
    var result = db
        .collection('favourites')
        .add(fav.toMap())
        .then((value) => print(value.id))
        .catchError((error) => print(error));
    return result;
  }

  static Future deleteFavourite(String favId) async {
    await db.collection('favourites').doc(favId).delete();
  }
}
