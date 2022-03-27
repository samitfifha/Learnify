import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:learnifyflutter/explore.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:learnifyflutter/widgets/feature_item.dart';
import 'package:learnifyflutter/widgets/recommend_item.dart';
import 'package:learnifyflutter/screen2.dart';
import 'package:learnifyflutter/utilities/content_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learnifyflutter/utilities/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learnifyflutter/Models/coursesModel.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;
  late Future<bool> fetchedCourses;
  List list = [];

  Future<bool> fetchcourses() async {
    http.Response response =
        await http.get(Uri.parse(BaseURL + "courses/")).then((response) async {
      //print(response.statusCode);
      if (response.statusCode == 200) {
        list = json
            .decode(response.body)
            .map((data) => Course.fromJson(data))
            .toList();

        /*username = userData["firstName"] + " " + userData["lastName"];
        profilePicpath = userData["profilePic"];

        if (profilePicpath.startsWith('public')) {
          profilePic = profilePicpath.substring(22, profilePicpath.length);
          imagePath = BaseURL + 'images/uploads/' + profilePic;
        } else if (profilePicpath.startsWith('https')) {
          profilePicpath = userData["profilePic"];
          imagePath = profilePicpath;
        }
        //print(profilePic);*/
      }
      return response;
    });
    return true;
  }

  getconn() async {
    bool hasInternet = false;
    await InternetConnectionChecker().onStatusChange.listen((event) {
      if (hasInternet = event == InternetConnectionStatus.connected) {}
      hasInternet = true;
    });
    if (hasInternet = false) {
      showSimpleNotification(Text("No Connection"), background: Colors.red);
    } else {
      showSimpleNotification(Text("Connected"), background: Colors.green);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchedCourses = fetchcourses();
    super.initState();
    getconn();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedCourses,
        builder: (context, snapshot) {
          return AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor)
              ..rotateY(isDrawerOpen ? -0.5 : 0),
            duration: Duration(milliseconds: 250),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isDrawerOpen
                            ? IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    scaleFactor = 1;
                                    isDrawerOpen = false;
                                  });
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.menu),
                                onPressed: () {
                                  setState(() {
                                    xOffset = 230;
                                    yOffset = 150;
                                    scaleFactor = 0.6;
                                    isDrawerOpen = true;
                                  });
                                }),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExploreScreen()));
                            },
                            child: Icon(Icons.search)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "With learnify you'll find Courses in ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: shadowList,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  categories[index]['iconPath'],
                                  height: 50,
                                  width: 50,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Center(child: Text(categories[index]['name']))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: Text("Featured",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                  )),
                            ),
                            getFeature(),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recommended",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "See all",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            getRecommend(),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          );
        });
  }

  getRecommend() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              list.length,
              (index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: RecommendItem(
                    data: list[index],
                    onTap: () {},
                  )))),
    );
  }

  getFeature() {
    return CarouselSlider(
        options: CarouselOptions(
          height: 290,
          enlargeCenterPage: true,
          disableCenter: true,
          viewportFraction: .75,
        ),
        items: List.generate(list.length,
            (index) => FeatureItem(onTap: () {}, data: list[index])));
  }
}
