import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:learnifyflutter/utilities/data.dart';

class NotificationUser {
  NotificationUser({
    required this.id,
    required this.body,
    required this.date,
    required this.user,
  });
  final String id;
  final String body;
  final String date;
  final String user;

  factory NotificationUser.fromJson(Map<String, dynamic> data) {
    final id = data['_id'] as String; // cast as non-nullable String
    final body = data['body'] as String; // cast as non-nullable String
    final date = data['date'] as String; // cast as nullable int
    final user = data['user'] as String; // cast as nullable int
    return NotificationUser(
      id: id,
      body: body,
      date: date,
      user: user,
    );
  }
}
