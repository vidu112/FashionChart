import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_cart_driver2/Screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginOrSignup extends StatefulWidget {
  static const String routeName = '/login-or-signup-screen';
  @override
  _LoginOrSignupScreenState createState() => _LoginOrSignupScreenState();
}

class _LoginOrSignupScreenState extends State<LoginOrSignup> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //final mediaQuery = MediaQuery.of(context);
    //final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              onChanged: (value) {
                _email = value;
              },
              //onSaved: (input) => _email = input,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              //onSaved: (input) => _password = input,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _email, password: _password)
                    .then((signedInUser) {
                  Firestore.instance
                      .collection('/vidu')
                      .add({
                        'email': _email,
                        'password': _password,
                      })
                      .then((onValue) {})
                      .then((value) {
                        Navigator.of(context)..popAndPushNamed(HomeScreen.routeName);
                      })
                      .catchError((e) {
                        print(e);
                      });
                });
              },
              child: Text('Sign in'),
            ),
            RaisedButton(
              onPressed: () {
                print(_email);
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _email, password: _password)
                    .then((onValue) {
                      Firestore.instance.collection('Driver').document(onValue.user.uid).setData({'userId':onValue.user.uid,'email_address':_email,'password':_password});
                  print(onValue);
                }).catchError((e){print(e);});
              },
              child: Text('Sign up'),
            )
          ],
        ),
      ),
    );
  }

  void signIn() {
    final formState = _formkey.currentState;
    if (formState.validate()) {}
    //to validate fields
    //to login to firebase
  }

  void signUp() {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      //to validate fields
      //to login to firebase
    }
  }
}
