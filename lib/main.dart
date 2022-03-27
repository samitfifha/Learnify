import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:learnifyflutter/Courses%20Screens/addLessons.dart';
import 'package:learnifyflutter/Welcome%20Screens/splashscreen.dart';
import 'package:learnifyflutter/testscreen.dart';

import 'package:learnifyflutter/utilities/session.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Welcome Screens/mainscreen.dart';
import 'package:learnifyflutter/test.dart';

void main() {
  Stripe.publishableKey = Stripekey;
  runApp(OverlaySupport.global(
    child: MaterialApp(
      home: MyApp(),
      theme: ThemeData(fontFamily: 'Circular'),
      debugShowCheckedModeBanner: false,
    ),
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
