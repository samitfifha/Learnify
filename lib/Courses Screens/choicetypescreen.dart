import 'package:flutter/material.dart';
import 'package:learnifyflutter/Courses%20Screens/filecourse.dart';
import 'package:learnifyflutter/Courses%20Screens/meetvisiocourse.dart';
import 'package:learnifyflutter/Courses%20Screens/videocourse.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';

class ChoiceTypeScreen extends StatefulWidget {
  const ChoiceTypeScreen({Key? key}) : super(key: key);

  @override
  State<ChoiceTypeScreen> createState() => _ChoiceTypeScreenState();
}

class _ChoiceTypeScreenState extends State<ChoiceTypeScreen> {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
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
                          'Add Courses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Nisebuschgardens',
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: height * 0.80,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MeetCourseScreen()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 100),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      alignment: Alignment.center,
                                      height: 54,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                (new Color(0xff4B0082)),
                                                (new Color(0xff00FFFF))
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 10),
                                                blurRadius: 50,
                                                color: Color(0xffEEEEEE)),
                                          ]),
                                      child: Text(
                                        "Mett VisioConference Course",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoCourseScreen()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 100),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      alignment: Alignment.center,
                                      height: 54,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                (new Color(0xff4B0082)),
                                                (new Color(0xff00FFFF))
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 10),
                                                blurRadius: 50,
                                                color: Color(0xffEEEEEE)),
                                          ]),
                                      child: Text(
                                        "Videos Courses",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FileCourseScreen()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 100),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      alignment: Alignment.center,
                                      height: 54,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                (new Color(0xff4B0082)),
                                                (new Color(0xff00FFFF))
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 10),
                                                blurRadius: 50,
                                                color: Color(0xffEEEEEE)),
                                          ]),
                                      child: Text(
                                        "Courses PDF",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        )
      ],
    );
  }
}
