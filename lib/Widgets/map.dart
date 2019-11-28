import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Map extends StatefulWidget {
  static const String routeName = '/map_screen';

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  //   var geolocator = Geolocator();
  // var locationOptions =
  //     LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  LocationData _startLocation;
  LocationData _currentLocation;
  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(0, 0),
    zoom: 4,
  );

  CameraPosition _currentCameraPosition;
  GoogleMap googleMap;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            double testLat = result.latitude;
            print(testLat);

            _currentCameraPosition = CameraPosition(
                target: LatLng(result.latitude, result.longitude), zoom: 16);
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(_currentCameraPosition));
            Firestore.instance
                .collection('/viduDriver')
                .document('driverLocation')
                .setData({
              'lat': result.latitude.toString(),
              'lon': result.longitude.toString()
            }, merge: true);
            print("location: ${result.latitude}");
            Firestore.instance
                .collection('/Driver')
                .where("driverId", isEqualTo: "D0001")
                .limit(1)
                .getDocuments()
                .then((documents) {
              DocumentSnapshot driverDs = documents.documents[0];
              Firestore.instance
                  .collection('/Driver')
                  .document(driverDs.documentID)
                  .setData({
                'lat': result.latitude.toString(),
                'lon': result.longitude.toString()
              }, merge: true);
            });
            if (mounted) {
              setState(() {
                _currentLocation = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition: _initialCamera,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ],
    );
  }
}
