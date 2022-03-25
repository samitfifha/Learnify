import 'dart:io';

import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:learnifyflutter/Models/CoursesModel.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/utilities/content_model.dart';
import 'package:learnifyflutter/utilities/customimage.dart';
import 'package:learnifyflutter/utilities/data.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learnifyflutter/Models/coursesModel.dart';

class Screen2 extends StatefulWidget {
  var myObject;
  Screen2({this.myObject});
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late Future<bool> fetchedLessons;

  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    //print(widget.myObject.lessons);
    //print(widget.myObject.lessons[0]["title"],);
  }

  String func() {
    final profilePicpath = widget.myObject.image;
    if (profilePicpath.startsWith('public')) {
      final profilePic = profilePicpath.substring(22, profilePicpath.length);
      final imagePath = BaseURL + 'uploads/lessons/' + profilePic;
      return imagePath;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.teal, Colors.indigo],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Detail',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Nisebuschgardens',
                        ),
                      ),
                      Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 30),
                    child: Column(
                      children: [
                        CustomImage(
                          func(),
                          radius: 10,
                          width: double.infinity,
                          height: 200,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(height: 50),
                                  Text(
                                    widget.myObject.title.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.bookmark_add_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.myObject.nbrSeance.toString(),
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.schedule_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.myObject.nbrSeance.toString(),
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.myObject.tag.toString(),
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "About Course ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 200,
                                      )
                                    ],
                                  ),
                                  ReadMoreText(
                                    widget.myObject.description.toString(),
                                    trimLines: 2,
                                    trimMode: TrimMode.Line,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white70),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                child: TabBar(
                                  controller: tabController,
                                  tabs: [
                                    Tab(
                                      child: Text("Lessons"),
                                    ),
                                    Tab(
                                      child: Text("Excerices"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child:
                              TabBarView(controller: tabController, children: [
                            getlesson(),
                            Center(
                                child: Text(
                              "Coming Soon...",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            )),
                          ]),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Price",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.myObject.price.toString(),
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                padding: EdgeInsets.only(left: 20, right: 20),
                                alignment: Alignment.center,
                                height: 55,
                                width: 240,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "buy",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getlesson() {
    return ListView.builder(
      itemCount: widget.myObject.lessons.length,
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
        child: Row(
          children: [
            CustomImage(
              func(),
              radius: 10,
              width: 70,
              height: 70,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.myObject.lessons[index]["title"]),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
