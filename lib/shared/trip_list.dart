// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:learning_animations/models/trip.dart';
import 'package:learning_animations/screens/details_screen.dart';

class TripList extends StatefulWidget {
  const TripList({super.key});

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  List<Widget> _tripTiles = [];
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addTrips();
  }

  void _addTrips() {
    // get data from db
    List<Trip> _trips = [
      Trip(title: 'Beach Paradise', price: '350', nights: '3', img: 'assets/images/beach.png'),
      Trip(title: 'City Break', price: '400', nights: '5', img: 'assets/images/city.png'),
      Trip(title: 'Ski Adventure', price: '750', nights: '2', img: 'assets/images/ski.png'),
      Trip(title: 'Space Blast', price: '600', nights: '4', img: 'assets/images/space.png'),
    ];

    _trips.forEach((Trip trip) {
      _tripTiles.add(_buildTile(trip));
    });
  }

  Widget _buildTile(Trip trip) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(trip: trip)));
      },
      contentPadding: const EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${trip.nights} nights',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300])),
          Text(trip.title, style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          trip.img,
          height: 50.0,
        ),
      ),
      trailing: Text('\$${trip.price}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: _listKey,
      itemCount: _tripTiles.length,
      itemBuilder: (context, index) {
        return _tripTiles[index];
      }
    );
  }
}