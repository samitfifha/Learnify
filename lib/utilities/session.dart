import 'package:flutter/material.dart';
import 'package:learnifyflutter/introauth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learnifyflutter/mainscreen.dart';
import 'package:learnifyflutter/splashscreen.dart';

class Session extends StatefulWidget {
  const Session({Key? key}) : super(key: key);

  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  late String route;
  late Future<bool> fetchedUser;

  Future<bool> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("_id")) {
      route = MainScreen.id;
    } else {
      route = IntroAuth.id;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchedUser = fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (route == MainScreen.id) {
            return const MainScreen();
          } else {
            return const IntroAuth();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
