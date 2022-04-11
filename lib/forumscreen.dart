import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:learnifyflutter/widgets/custom_dialog_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Models/notificationsModel.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

List notifications = [];

late Future<bool> fetchedCourses;

Future<bool> fetchcourses() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userid = prefs.getString("_id")!;
  http.Response response = await http
      .get(Uri.parse(BaseURL + "users/notifications/" + userid))
      .then((response) async {
    //print(response.statusCode);
    if (response.statusCode == 200) {
      notifications = json
          .decode(response.body)
          .map((data) => NotificationUser.fromJson(data))
          .toList();
    }
    return response;
  });
  return true;
}

class _ForumScreenState extends State<ForumScreen> {
  void initState() {
    super.initState();
    fetchedCourses = fetchcourses();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.grey.shade100),
        ),
        FutureBuilder(builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 90,
                          ),
                          Text(
                            'Notifications',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Nisebuschgardens',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 400,
                        child: getMyCourses(),
                      )
                    ],
                  )),
            ),
          );
        })
      ],
    );
  }

  Widget getMyCourses() {
    return RefreshIndicator(
      onRefresh: () async {
        await fetchcourses();
        setState(() {});
      },
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(index),
          direction: DismissDirection.endToStart,
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.redAccent,
            ),
            child: Icon(Icons.delete, color: Colors.white),
            padding: const EdgeInsets.all(8.0),
          ),
          confirmDismiss: (direction) {
            return showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(
                    title: "Alert",
                    description: "Are you sure you want to delete this?",
                    ontap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final userid = prefs.getString("_id")!;
                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=utf-8"
                      };
                      print(notifications[index].id.toString());
                      Map<String, dynamic> body = {
                        "notificationid": notifications[index].id.toString(),
                      };
                      http.post(
                          Uri.parse(BaseURL + "users/notifications/" + userid),
                          headers: headers,
                          body: json.encode(body));

                      Navigator.pop(context, true);
                      setState(() {
                        notifications.removeAt(index);
                      });
                    },
                  );
                });
          },
          onDismissed: (direction) {
            print('Dismissed');
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white70.withOpacity(.07),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1),
                  )
                ]),
            child: Row(
              children: [
                // CustomImage(
                //   func(index),
                //   radius: 10,
                //   width: 70,
                //   height: 70,
                // ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notifications[index].body.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Nisebuschgardens',
                            fontWeight: FontWeight.bold)),
                  ],
                )),
                //Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
