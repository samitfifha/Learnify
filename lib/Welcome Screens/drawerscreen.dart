import 'package:flutter/material.dart';
import 'package:learnifyflutter/Welcome%20Screens/loginscreen.dart';

import 'package:learnifyflutter/settingscreen.dart';
import 'package:learnifyflutter/utilities/content_model.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late String username;
  late String profilePicpath;
  late String profilePic;
  late String imagePath;

  late Future<bool> fetchedUser;

  Future<bool> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString("_id")!;

    try {
      http.Response response = await http
          .get(Uri.parse(BaseURL + "users/" + userid))
          .then((response) async {
        print(response.statusCode);
        if (response.statusCode == 201) {
          Map<String, dynamic> userData = json.decode(response.body);

          username = userData["firstName"] + " " + userData["lastName"];
          profilePicpath = userData["profilePic"];

          if (profilePicpath.startsWith('public')) {
            profilePic = profilePicpath.substring(22, profilePicpath.length);
            imagePath = BaseURL + 'images/uploads/' + profilePic;
          } else if (profilePicpath.startsWith('https')) {
            profilePicpath = userData["profilePic"];
            imagePath = profilePicpath;
          }
          //print(profilePic);
        }
        return response;
      });
    } catch (err) {
      print(err);
      return true;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    try {
      fetchedUser = fetchUser();
    } catch (err) {
      print(err);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.teal, Colors.indigo],
              )),
              padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      imagePath,
                                    ))),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: drawerItems
                        .map((element) => Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  element['screen']));
                                    },
                                    child: Icon(
                                      element['icon'],
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  element['screen']));
                                    },
                                    child: Text(element['title'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingScreen()));
                        },
                        child: Text(
                          'Settings',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 2,
                        height: 20,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove("_id");

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Log out',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
