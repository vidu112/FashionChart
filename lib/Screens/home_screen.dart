import '../Widgets/home_item.dart';
import '../home_categories.dart';
import 'package:flutter/material.dart';
import '../Widgets/map.dart';
import 'package:flip_card/flip_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _showAlert = false;
  var _showProfile = false;
  var _showTrips = false;
  var _showGrid = true;
  void nextWidget(String nextWidget) {
    setState(() {
      if (nextWidget == 'profile') {
        _showProfile = true;
        _showGrid = false;
      } else if (nextWidget == 'trips') {
        _showTrips = true;
        _showGrid = false;
      }
    });
  }

  String goOnlineButtonText = 'Go Online';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget buildGrid() {
    return Center(
      child: FlipCard(
        key: cardKey,
        flipOnTouch: false,
        front: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('home_categories').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new GridView.builder(
                  itemCount: snapshot.data.documents.length,
                  shrinkWrap: false,
                  padding: const EdgeInsets.all(5),
                  gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int i) {
                    DocumentSnapshot ds = snapshot.data.documents[i];
                    return HomeItem(
                      ds['id'],
                      ds['title'],
                      ds['imgUrl'],
                      ds['nextWidget'],
                      nextWidget,
                    );
                  },
                );
            }
          },
        ),
        back: Container(
          child: Map(),
        ),
      ),
    );
  }

  // void getLocation() {
  //   var geolocator = Geolocator();
  //   var locationOptions =
  //       LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  //   StreamSubscription<Position> positionStream = geolocator
  //       .getPositionStream(locationOptions)
  //       .listen((Position position) {
  //     print(position == null
  //         ? 'Unknown'
  //         : position.latitude.toString() +
  //             ', ' +
  //             position.longitude.toString());
  //                        Firestore.instance
  //                     .collection('/viduDriver').document('driverLocation')
  //                     .setData({'lat':position.latitude.toString(),'lon':position.longitude.toString()},merge: true);
                     
  //   });
  //   positionStream.resume();
  // }

  void showAlert(var state) async {
    if (state) {
      await Firestore.instance
          .collection('Driver')
          .document('heacdAKZUQ9m6oawOWYh')
          .get()
          .then((DocumentSnapshot ds) {
        if (ds['Vidu'] == '1') {
          setState(() {
            _showAlert = true;
            print(_showAlert);
          });
        } else {
          setState(() {
            _showAlert = false;
            print(_showAlert);
          });
        }
      });
    } else {
      Firestore.instance.collection('Driver');
    }
  }

  bool _showmap = false;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final List<HomeCategories> categories = [
    HomeCategories(
      id: 'M1',
      title: 'Trips',
      imgUrl:
          'https://images.pexels.com/photos/1060298/pexels-photo-1060298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ),
    HomeCategories(
      id: 'M1',
      title: 'Trips',
      imgUrl:
          'https://images.pexels.com/photos/1060298/pexels-photo-1060298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ),
    HomeCategories(
      id: 'M1',
      title: 'Trips',
      imgUrl:
          'https://images.pexels.com/photos/1060298/pexels-photo-1060298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ),
    HomeCategories(
      id: 'M1',
      title: 'Trips',
      imgUrl:
          'https://images.pexels.com/photos/1060298/pexels-photo-1060298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ),
    //HomeCategories(id: 'M1',title: 'Trips',imgUrl:'https://images.pexels.com/photos/1060298/pexels-photo-1060298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', ),
    //HomeCategories(id: 'M1',title: 'Trips',imgUrl:'https://images.pexels.com/photos/1060298/pexels-photo-1060298.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', ),
  ];
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Driver app"),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        height:
            MediaQuery.of(context).size.height - appBar.preferredSize.height,
        child: new Stack(
          children: <Widget>[
            // _showAlert ? showDialog(
            //   context: context,
            //   builder: (BuildContext ctx){
            //     return Center(child: Text('Hiiiii'),);
            //   }

            // )
            _showProfile
                ? Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Text('Profile'),
                    ),
                  )
                : _showAlert
                    ? Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Text('Alert'),
                        ),
                      )
                    : Container(),
            _showGrid
                ? Center(
                    child: FlipCard(
                      key: cardKey,
                      flipOnTouch: false,
                      front: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('home_categories')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return new Text('Loading...');
                            default:
                              return new GridView.builder(
                                itemCount: snapshot.data.documents.length,
                                shrinkWrap: false,
                                padding: const EdgeInsets.all(5),
                                gridDelegate:
                                    new SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 0.9,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (BuildContext context, int i) {
                                  DocumentSnapshot ds =
                                      snapshot.data.documents[i];
                                  return HomeItem(
                                    ds['id'],
                                    ds['title'],
                                    ds['imgUrl'],
                                    ds['nextWidget'],
                                    nextWidget,
                                  );
                                },
                              );
                          }
                        },
                      ),
                      back: Container(
                        child: Map(),
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      //getLocation();
                      if (goOnlineButtonText == 'Go Online') {
                        setState(() {
                          goOnlineButtonText = 'Go Offline';
                        });
                      } else {
                        setState(() {
                          goOnlineButtonText = 'Go Online';
                        });
                      }
                      cardKey.currentState.toggleCard();
                    },
                    elevation: 5,
                    child: Text(goOnlineButtonText),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
