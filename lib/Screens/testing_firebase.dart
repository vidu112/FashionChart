import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListFirebase extends StatefulWidget {
  static const String routeName = '/listfirebase';
  @override
  _ListFirebaseState createState() => _ListFirebaseState();
}

class _ListFirebaseState extends State<ListFirebase> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('data'),),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('home_categories').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return new ListTile(
                    title: new Text(document['id']),
                    subtitle: new Text(document['title']),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}