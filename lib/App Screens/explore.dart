import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learnifyflutter/Models/coursesModel.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/utilities/content_model.dart';
import 'package:learnifyflutter/utilities/customimage.dart';
import 'package:learnifyflutter/utilities/data.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:learnifyflutter/widgets/category_item.dart';
import 'package:http/http.dart' as http;

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

List list = [];

fetchcourses(value) async {
  list.clear();

  http.Response response = await http
      .get(Uri.parse(BaseURL + "courses/search/" + value))
      .then((response) async {
    //print(response.statusCode);
    if (response.statusCode == 200) {
      list = json
          .decode(response.body)
          .map((data) => Course.fromJson(data))
          .toList();
    }
    return response;
  });
  return true;
}

fetchbytag(tag) async {
  list.clear();
  http.Response response = await http
      .get(Uri.parse(BaseURL + "courses/tag/" + tag))
      .then((response) async {
    //print(response.statusCode);
    if (response.statusCode == 200) {
      list = json
          .decode(response.body)
          .map((data) => Course.fromJson(data))
          .toList();
      print(list);
    }
    return response;
  });
  return true;
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool isActive = false;
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
                            width: 150,
                          ),
                          Text(
                            'Explore',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Nisebuschgardens',
                            ),
                          ),
                        ],
                      ),
                      getSearchbox(),
                      Positioned(
                        child: getCategory(),
                      ),
                      Positioned(
                        child: getMyCourses(),
                      )
                    ],
                  ),
                ),
              ));
        })
      ],
    );
  }

  getSearchbox() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white70.withOpacity(.05),
                        spreadRadius: .5,
                        blurRadius: .1,
                        offset: Offset(0, 0))
                  ]),
              child: TextField(
                onChanged: (value) {
                  list.clear();
                  fetchcourses(value);
                  setState(() {});
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    hintText: "Search"),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  int selectedindex = 0;
  getCategory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 15, top: 15),
      child: Row(
        children: List.generate(
            categories1.length,
            (index) => CategoryItem(
                ontap: () {
                  setState(() {
                    selectedindex = index;
                    fetchbytag(categories1[selectedindex]["name"]
                        .toString()
                        .toLowerCase());
                    setState(() {});
                  });
                },
                isActive: selectedindex == index,
                data: categories1[index])),
      ),
    );
  }
}

String func(index) {
  final profilePicpath = list[index].image.toString();
  if (list[index].image.startsWith('public')) {
    final profilePic = profilePicpath.substring(22, profilePicpath.length);
    final imagePath = BaseURL + 'uploads/lessons/' + profilePic;
    return imagePath;
  }
  return '';
}

Widget getMyCourses() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: list.length,
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
            func(index),
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
              Text(list[index].title),
            ],
          )),
          Spacer(),
          InkWell(onTap: () {}, child: Icon(Icons.keyboard_arrow_right)),
        ],
      ),
    ),
  );
}
