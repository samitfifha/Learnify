import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learnifyflutter/Welcome%20Screens/drawerscreen.dart';
import 'package:learnifyflutter/Welcome%20Screens/homescreen.dart';

class MainScreen extends StatefulWidget {
  static const String id = "idmainscreen";
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), HomeScreen()],
      ),
    );
  }
}
