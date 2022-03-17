import 'dart:io';

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:learnifyflutter/Courses%20Screens/choicetypescreen.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:file/file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FileCourseScreen extends StatefulWidget {
  const FileCourseScreen({Key? key}) : super(key: key);

  @override
  State<FileCourseScreen> createState() => _FileCourseScreenState();
}

class _FileCourseScreenState extends State<FileCourseScreen> {
  late String userid;
  late String? coursename;
  late String? coursedesc;
  late String? price;
  late String? tag;
  late String? Coursefile;

  Future pickImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("_id")!;
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Coursefile = result.files.single.path;
    } else {
      // User canceled the picker
    }

    var uri = Uri.parse(BaseURL + "courses/new/" + userid);

    var request = http.MultipartRequest('POST', uri);
    request.files
        .add(await http.MultipartFile.fromPath('support', Coursefile!));
    var response = await request.send();
    //print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      //print(value);
    });
    sleep(const Duration(seconds: 5));
  }

  final items = ['Coding', 'programming', 'languages', 'cretifed', 'math'];
  final items1 = ['1 ', '2', '3', '4', '5', '6', '7', '8'];
  String? value;
  String _value = "";
  bool isChecked = false;

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
                                    builder: (context) => ChoiceTypeScreen()));
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Video Courses',
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
                          SizedBox(
                            height: 30,
                          ),
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
                                  Container(
                                    height: height * 0.70,
                                    child: ListView(
                                      children: [
                                        InkWell(
                                          onTap: () => pickImage(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, right: 20, top: 10),
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              alignment: Alignment.center,
                                              height: 54,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        (Colors.green),
                                                        (Colors.black)
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end: Alignment
                                                          .centerRight),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 10),
                                                        blurRadius: 50,
                                                        color:
                                                            Color(0xffEEEEEE)),
                                                  ]),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Add Image",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(width: 130),
                                                  Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 15,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.dashboard_customize,
                                              color: Colors.blueAccent,
                                            ),
                                            hintText: "Course Name",
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.description,
                                              color: Colors.blueAccent,
                                            ),
                                            hintText: "Course Description",
                                          ),
                                        ),
                                        new SizedBox(
                                          height: 20.0,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: DropdownButton<String>(
                                            value: value,
                                            icon: Icon(Icons.arrow_drop_down,
                                                color: Colors.black),
                                            iconSize: 25,
                                            isExpanded: true,
                                            items: items
                                                .map(buildMenuItem)
                                                .toList(),
                                            onChanged: (value) => setState(
                                                () => this.value = value),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Flexible(
                                              child: CheckboxListTile(
                                                title: const Text(
                                                  "payed",
                                                ),
                                                value: isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            if (isChecked)
                                              Flexible(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    icon: Icon(
                                                      Icons.description,
                                                      color: Colors.blueAccent,
                                                    ),
                                                    hintText: "price TND",
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20, top: 10),
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            alignment: Alignment.center,
                                            height: 54,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      (Colors.green),
                                                      (Colors.black)
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
                                            child: InkWell(
                                              onTap: () => pickImage(),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Add Files",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(width: 130),
                                                  Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
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
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 10),
                                              blurRadius: 50,
                                              color: Color(0xffEEEEEE)),
                                        ]),
                                    child: Text(
                                      "ADD",
                                      style: TextStyle(color: Colors.white),
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
}