import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:learnifyflutter/Courses%20Screens/addLessons.dart';
import 'package:learnifyflutter/User%20Screens/ForgetPassword.dart';
import 'package:learnifyflutter/User%20Screens/Resetpassword.dart';
import 'package:learnifyflutter/User%20Screens/pin_verif_pass.dart';
import 'package:learnifyflutter/Welcome%20Screens/splashscreen.dart';
import 'package:learnifyflutter/utilities/notification_service.dart';
import 'package:learnifyflutter/widgets/chewie_list_item.dart';
import 'package:learnifyflutter/testscreen.dart';

import 'package:learnifyflutter/utilities/session.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:learnifyflutter/widgets/videoplayer.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:video_player/video_player.dart';
import 'Welcome Screens/mainscreen.dart';
import 'package:learnifyflutter/test.dart';
import 'widgets/chewie_list_item.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
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
      //body: testScreen(),
      //body:
    );
  }
}
