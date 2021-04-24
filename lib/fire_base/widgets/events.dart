import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/fire_base/models/event.dart';
import 'package:flutter_projects/fire_base/models/favourite.dart';
import 'package:flutter_projects/fire_base/shared/authentication.dart';
import 'package:flutter_projects/fire_base/widgets/login.dart';

class EventsScreen extends StatefulWidget {
  final String title;
  final String uid;

  const EventsScreen({Key key, this.title, this.uid}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState(uid);
}

class _EventsScreenState extends State<EventsScreen> {
  String uid;

  _EventsScreenState(uid);

  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Event> events = [];
  List<Favourite> favourites = [];
  final Authentication auth = Authentication();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getData();
    }
  }

  Future getData() async {
    List<Favourite> fav = await getUserFavourites();
    events = await getEventsList();
    events.forEach((Event event) {
      if (isUserFavourite(event)) {
        event.isFavourite = true;
      } else {
        event.isFavourite = false;
      }
    });
    setState(() {
      this.events = events;
      this.favourites = fav;
    });
  }

  Future<List<Event>> getEventsList() async {
    var data = await db.collection('events').get();
    int i = 0;
    if (data != null) {
      events = data.docs
          .map((documentSnapshot) => Event.fromMap(documentSnapshot.data()))
          .toList();
      events.forEach((f) {
        f.id = data.docs[i].id;
        i++;
      });
    }
    return events;
  }

  Future<List<Favourite>> getUserFavourites() async {
    //retrieves only the documents that belong to the current user
    CollectionReference fav = db.collection('favourites');
    int i = 0;
    var data = await fav.where('userId', isEqualTo: uid).get();
    if (data != null) {
      favourites = data.docs
          .map((documentSnapshot) => Favourite.fromMap(documentSnapshot.data()))
          .toList();
      favourites.forEach((f) {
        f.id = data.docs[i].id;
        i++;
      });
    }
    return favourites;
  }

  bool isUserFavourite(Event e) {
    //checks whether the event that was passed is a user's favourite
    String eventId = e.id;
    if (favourites != null) {
      Favourite f = favourites.firstWhere((Favourite f) => f.eventId == eventId,
          orElse: () => null);
      if (f == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              auth.signOut().then((value) => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login())));
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: (events == null) ? 0 : events.length,
          itemBuilder: (context, position) {
            String sub =
                'Date: ${events[position].data} - Start: ${events[position].orainizio} - End: ${events[position].orafine}';
            return ListTile(
              title: Text(events[position].descrizione),
              subtitle: Text(sub),
              trailing: (events[position].isFavourite)
                  ? IconButton(
                      icon: Icon(Icons.star, color: Colors.redAccent),
                      onPressed: () {
                        toggleFavourite(events[position], position);
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.star_border, color: Colors.grey),
                      onPressed: () {
                        toggleFavourite(events[position], position);
                      },
                    ),
            );
          },
        ),
      ),
    );
  }

  void toggleFavourite(Event event, position) {
    event.isFavourite = !event.isFavourite;
    if (event.isFavourite) {
      addFavourite(event, uid);
    } else {
      Favourite f = favourites.firstWhere((Favourite f) {
        return (f.eventId == event.id && f.userId == uid);
      });
      deleteFavourite(f.id);
    }
    setState(() {
      events[position] = event;
    });
  }

  Future addFavourite(event, uid) async {
    var fav = {'userId': uid, 'eventId': event.id};

    db
        .collection('favourites')
        .add(fav)
        .then((onValue) => print('Insert favourite OK'));
  }

  Future deleteFavourite(String favId) async {
    await db.collection('favourites').doc(favId).delete();
  }
}
