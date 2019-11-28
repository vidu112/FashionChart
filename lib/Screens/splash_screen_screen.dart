import 'package:flutter/material.dart' as prefix0;

import '../Screens/home_screen.dart';
import '../Screens/testing_firebase.dart';

import '../Screens/login_signup_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen())
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/splash_screen.jpg',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
