import 'package:flutter/material.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:learnifyflutter/Courses%20Screens/addLessons.dart';
import 'package:learnifyflutter/Welcome%20Screens/splashscreen.dart';
import 'package:learnifyflutter/chewie_list_item.dart';
import 'package:learnifyflutter/testscreen.dart';

import 'package:learnifyflutter/utilities/session.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:learnifyflutter/videoplayer.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:video_player/video_player.dart';
import 'Welcome Screens/mainscreen.dart';
import 'package:learnifyflutter/test.dart';
import 'chewie_list_item.dart';





void main() async {

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
      //body: MyVideoPlayer(),
      //body:
    );
  }
}
