import 'package:flutter/material.dart';
import 'package:learnifyflutter/Courses%20Screens/addLessons.dart';
import 'package:learnifyflutter/Welcome%20Screens/splashscreen.dart';
import 'package:learnifyflutter/testscreen.dart';

import 'package:learnifyflutter/utilities/session.dart';
import 'Welcome Screens/mainscreen.dart';
import 'package:learnifyflutter/test.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(fontFamily: 'Circular'),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SplachScreen(),
      //body: AddLessons(),
    );
  }
}
