import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/thread.dart';
import 'package:learnifyflutter/utilities/customimage.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:learnifyflutter/widgets/Custom_waiting_dialog.dart';
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
DateTime? createdat;
String? tag;
List threads = [];
late Future<bool> fetchedthreads;
String? value;
String _value = "";
final items = [
  'coding',
  'design',
  'languages',
  'business',
  'art',
  'cooking',
  'music',
  'finance',
];

Future<bool> fetchthreads() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getString("_id")!;
  http.Response response =
      await http.get(Uri.parse(BaseURL + "threads/")).then((response) async {
    print(response.statusCode);
    if (response.statusCode == 200) {
      threads = json
          .decode(response.body)
          .map((data) => Thread.fromJson(data))
          .toList();

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

  String? value;
  String _value = "";
  final items = [
    'Coding',
    'design',
    'languages',
    'business',
    'art',
    'cooking',
    'music',
    'finance',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
        onRefresh: () async {
          await fetchedthreads;
          setState(() {});
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
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
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 73),
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
                          Positioned(
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
                              ],
                            ),
                          ),
                          Positioned(
                            child: getthreads(),
                          ),
                        ],
                      )),
                ),
              );
            })
          ],
        ));
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
              // TextFormField(
              //   decoration: InputDecoration(
              //     icon: Icon(
              //       Icons.title,
              //       color: Colors.blueAccent,
              //     ),
              //     hintText: "Tag",
              //   ),
              //   onChanged: (value) {
              //     tag = value;
              //   },
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12)),
                child: DropdownButton<String>(
                  value: value,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  iconSize: 25,
                  isExpanded: true,
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //showAboutDialog(context: context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog3(
                          title: "Processiong",
                          description: "",
                        );
                      });
                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=utf-8"
                  };
                  Map<String, dynamic> body = {
                    "title": title,
                    "content": content,
                    "tag": value!,
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
      shrinkWrap: true,
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ThreadScreen(mythread: threads[index]),
              ),
            );
          },
          child: Row(
            children: [
              if (threads[index].tag == "coding")
                Image.network(
                  'https://images.unsplash.com/photo-1542831371-29b0f74f9713?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                  width: 70,
                  height: 70,
                ),
              if (threads[index].tag == "design")
                Image.network(
                  'https://images.unsplash.com/photo-1561070791-2526d30994b5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
                  width: 70,
                  height: 70,
                ),
              if (threads[index].tag == "languages")
                Image.network(
                  'https://images.unsplash.com/photo-1538708591342-2dcd6706e3b6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
                  width: 70,
                  height: 70,
                ),
              if (threads[index].tag == "business")
                Image.network(
                  'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1115&q=80',
                  width: 70,
                  height: 70,
                ),
              if (threads[index].tag == "art")
                Image.network(
                  'https://images.unsplash.com/photo-1513364776144-60967b0f800f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
                  width: 70,
                  height: 70,
                ),
              if (threads[index].tag == "cooking")
                Image.network(
                  'https://images.unsplash.com/photo-1528712306091-ed0763094c98?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=740&q=80',
                  width: 70,
                  height: 70,
                ),
              if (threads[index].tag == "music")
                Image.network(
                  'https://images.unsplash.com/photo-1507838153414-b4b713384a76?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                  width: 70,
                  height: 70,
                ),
              if (threads[index].tag == "finance")
                Image.network(
                  'https://images.unsplash.com/photo-1638913659197-46040471de1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
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
                  Text(threads[index].title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              )),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
}
