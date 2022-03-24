import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:learnifyflutter/utilities/data.dart';

class Course {
  Course(
      {required this.id,
      required this.title,
      required this.description,
      required this.nbrSeance,
      required this.tag,
      required this.price,
      required this.user,
      required this.image});
  final String id;
  final String title;
  final String description;
  final int nbrSeance;
  final String tag;
  final int price;
  final String user;
  final String image;

  factory Course.fromJson(Map<String, dynamic> data) {
    final id = data['_id'] as String; // cast as non-nullable String
    final title = data['title'] as String; // cast as non-nullable String
    final description = data['description'] as String; // cast as nullable int
    final nbrSeance = data['nbrSeance'] as int; // cast as nullable int
    final tag = data['tag'] as String; // cast as nullable int
    final price = data['price'] as int; // cast as nullable int
    final user = data['user'] as String; // cast as nullable int
    final image = data['image'] as String; // cast as nullable int

    return Course(
        id: id,
        title: title,
        description: description,
        nbrSeance: nbrSeance,
        tag: tag,
        price: price,
        user: user,
        image: image);
  }
}
