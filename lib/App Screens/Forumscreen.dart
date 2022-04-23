import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/thread.dart';
import 'package:learnifyflutter/utilities/customimage.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/ForumModel.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

late String userid;
String? title;
String? content;
DateFormat? createdat;
String? tag;
List threads = [];
late Future<bool> fetchedthreads;

Future<bool> fetchthreads() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getString("_id")!;
  http.Response response =
      await http.get(Uri.parse(BaseURL + "threads/")).then((response) async {
    print(response.statusCode);
    if (response.statusCode == 201) {
      Map<String, dynamic> data = json.decode(response.body);
      threads = data["threads"];
      print(threads);
    }

    print(threads);
    return response;
  });
  return true;
}

class _MessagesScreenState extends State<MessagesScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    fetchedthreads = fetchthreads();
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
            floatingActionButton: FloatingActionButton(
              splashColor: Colors.cyan,
              onPressed: () => openDialog(),
              child: Icon(
                Icons.add_business_outlined,
              ),
            ),
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
                            'Community',
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
                        child: Container(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.blueAccent,
                                  ),
                                  hintText: "Search",
                                ),
                              ),
                              SizedBox(
                                height: 300,
                                child: getthreads(),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          );
        })
      ],
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Center(child: Text("New thread")),
          content: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.title,
                    color: Colors.blueAccent,
                  ),
                  hintText: "Title",
                ),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.title,
                    color: Colors.blueAccent,
                  ),
                  hintText: "Description",
                ),
                onChanged: (value) {
                  content = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.title,
                    color: Colors.blueAccent,
                  ),
                  hintText: "Tag",
                ),
                onChanged: (value) {
                  tag = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=utf-8"
                  };
                  Map<String, dynamic> body = {
                    "title": title,
                    "content": content,
                    "tag": tag,
                  };
                  http
                      .post(Uri.parse(BaseURL + "threads/new/" + userid),
                          headers: headers, body: json.encode(body))
                      .then((response) async {
                    print(response.statusCode);
                    if (response.statusCode == 201) {
                      Map<String, dynamic> userData =
                          json.decode(response.body);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MessagesScreen(),
                        ),
                      );
                      //Navigator.pushReplacementNamed(context, "/home");
                      print("success addd");
                    } else {
                      print("failed");
                    }
                  });
                },
                child: Text("submit"))
          ],
        ),
      );

  Widget getthreads() {
    return ListView.builder(
      itemCount: threads.length,
      itemBuilder: (context, index) => Container(
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
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ThreadScreen()));
          },
          child: Row(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
                width: 70,
                height: 70,
              ),
              // CustomImage(
              //   funcsub(index),
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
                  Text("dsfsdfsdfs"),
                ],
              )),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
