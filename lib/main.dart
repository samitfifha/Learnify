import 'package:flutter/material.dart';
import 'package:learnifyflutter/introauth.dart';
import 'package:learnifyflutter/splashscreen.dart';
import 'package:learnifyflutter/utilities/session.dart';

import 'drawerscreen.dart';
import 'homescreen.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(fontFamily: 'Circular'),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SplachScreen(),
    );
  }
}
