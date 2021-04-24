import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/fire_base/models/event_detail.dart';
import 'package:flutter_projects/fire_base/models/favourite.dart';
import 'package:flutter_projects/fire_base/settings/firestore_helper.dart';

import '../models/event_detail.dart';

class EventList extends StatefulWidget {
  final String uid;

  EventList(this.uid);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<EventDetail> details = [];
  List<Favourite> favourites = [];

  @override
  void initState() {
    getDetailsList().then((data) {
      setState(() {
        details = data;
      });
    });
    FireStoreHelper.getUserFavourites(widget.uid).then((data) {
      setState(() {
        favourites = data;
      });
    });
    super.initState();
  }

  Future<List<EventDetail>> getDetailsList() async {
    var data = await db.collection('event_details').get();
    int i = 0;
    if (data != null) {
      details =
          data.docs.map((document) => EventDetail.fromMap(document)).toList();
      details.forEach((detail) {
        detail.id = data.docs[i].id;
        i++;
      });
    }
    return details;
  }

  toggleFavourite(EventDetail ed) async {
    if (isUserFavourite(ed.id)) {
      Favourite favourite =
          favourites.firstWhere((Favourite f) => f.eventId == ed.id);
      String favId = favourite.id;
      await FireStoreHelper.deleteFavourite(favId);
    } else {
      FireStoreHelper.addFavourite(ed, widget.uid);
    }
    List<Favourite> updatedFavourites =
        await FireStoreHelper.getUserFavourites(widget.uid);
    setState(() {
      favourites = updatedFavourites;
    });
  }

  bool isUserFavourite(String eventId) {
    Favourite favourite = favourites.firstWhere(
        (Favourite f) => (f.eventId == eventId),
        orElse: () => null);

    if (favourite == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (details != null) ? details.length : 0,
      itemBuilder: (context, position) {
        String sub =
            'Date: ${details[position].date} - Start: ${details[position].startTime} - End: ${details[position].endTime}';
        Color starColor = (isUserFavourite(details[position].id)
            ? Colors.redAccent
            : Colors.grey);
        return ListTile(
          title: Text(details[position].description),
          subtitle: Text(sub),
          trailing: IconButton(
            icon: Icon(Icons.star, color: starColor),
            onPressed: () {
              toggleFavourite(details[position]);
            },
          ),
        );
      },
    );
  }
}
