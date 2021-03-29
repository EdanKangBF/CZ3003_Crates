import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Listing.dart';
import '../common/NavigationBar.dart';
import '../common/theme.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'nearby_MapHandler.dart';
import '../../backend/map_DataHandler.dart';

class Nearby extends StatefulWidget {
  @override
  _NearbyState createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {

  MapHandler mapHandler = new MapHandler();
  DataHandler dataHandler = new DataHandler();
  Completer<GoogleMapController> _controller = Completer();

  LatLng _center;
  BitmapDescriptor customIcon1;
  Set<Marker> markers;
  List<Listing> listing;

  double _longitude, _latitude;
  double distance;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  _NearbyState(){
    mapHandler.getLatitudeDouble().then((value) => setState((){
      _latitude = value;
    }));
    mapHandler.getLongitudeDouble().then((value) => setState((){
      _longitude = value;
    }));
    mapHandler.getCurrentLocation().then((value) => setState(() {
      _center = value;
    }));
    dataHandler.retrieveUserListing(_latitude, _longitude, distance).then((value) => setState(() {
      listing = value;
    }));
  }
  @override
  Widget build(BuildContext context) {
    mapHandler.createMarker(context, customIcon1);
    //print(dataHandler.haversine( 1.4267489378462697, 103.72670044012453, 1.4336990577109694, 103.70837558813479));
    return Scaffold(
      bottomNavigationBar: NavigationBar(2),
      backgroundColor: offWhite,
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40,20,0),
                child: IconButton(
                  icon: Icon(Icons.filter_alt),
                  iconSize: 30,
                  //TODO: filter button pressed
                  onPressed: (){},
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height:160.0,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 40),
                child: Card(
                  clipBehavior: Clip.none,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: AspectRatio(
                          aspectRatio: 1/1,
                          child: Image.asset(
                            'assets/coffee.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Old Town White Coffee",
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )
                            ),
                            SizedBox(height:10),
                            Row(
                              children: [
                                Icon(Icons.directions),
                                SizedBox(width:5),
                                Text("200m away",
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height:5),
                            Row(
                              children: [
                                Icon(Icons.date_range),
                                SizedBox(width:5),
                                Text("12/02/2021",
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height:5),
                            Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width:5),
                                Text("HoneyBee",
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:80),
                                  child: Icon(Icons.keyboard_arrow_right),
                                ),
                              ],
                            ),
                          ]
                        ),
                      )
                    ]
                  )
                ),
              ),
            ],
          ),
        ]
      )

    );
  }
}
