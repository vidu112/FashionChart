import './Screens/testing_firebase.dart';

import './Screens/home_screen.dart';
import './Screens/login_signup_screen.dart';
import './Screens/splash_screen_screen.dart';
import './Widgets/map.dart';

import 'package:flutter/material.dart';
var myKey = 'AIzaSyCg2E8z-VAJbWvi1559nsEDLeBXvvfqf60';

void main() {
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      //home: CatergoriesScreen(),
      routes: {
        '/': (ctx) => SplashScreen(),
        LoginOrSignup.routeName: (ctx) => LoginOrSignup(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        Map.routeName:(ctx)=> Map(),
        ListFirebase.routeName:(ctx)=>ListFirebase(),
      },
    );
  }
}
