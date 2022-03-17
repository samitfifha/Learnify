import 'package:flutter/material.dart';
import 'package:learnifyflutter/Welcome%20Screens/splashscreen.dart';

import 'package:learnifyflutter/utilities/session.dart';
import 'Welcome Screens/mainscreen.dart';

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
