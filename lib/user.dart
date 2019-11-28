import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String userName;
  final String telNo;

  const User({
    @required this.id,
    @required this.userName,
    @required this.telNo,
  });
}