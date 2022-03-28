import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class AddLessons extends StatefulWidget {
  var courseid;
  AddLessons({this.courseid});

  @override
  State<AddLessons> createState() => _AddLessonsState();
}

class _AddLessonsState extends State<AddLessons> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late FilePickerResult? result;
  String? Lessonfile;
  String? lessonname;

  Future pickImage() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Lessonfile = result!.files.single.path;
    } else {
      // User canceled the picker
    }
  }

  String code = '';
  String createcode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
    return code;
  }

  String checkid() {
    if (widget.courseid.toString().length != 24) {
      String id1 = widget.courseid.substring(1);
      String id2 = id1.substring(0, id1.length - 1);
      return id2;
    } else {
      return widget.courseid.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(checkid());
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
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
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
                            'Add Lesson',
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.dashboard_customize,
                                                color: Colors.blueAccent,
                                              ),
                                              hintText: "Lesson Name",
                                            ),
                                            onChanged: (String? value) {
                                              lessonname = value;
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          new SizedBox(
                                            height: 20.0,
                                          ),
                                          SizedBox(
                                            height: 15,
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
                                    InkWell(
                                      onTap: () async {
                                        var uri = Uri.parse(BaseURL +
                                            "lessons/new/" +
                                            checkid());
                                        print(uri);

                                        var request =
                                            http.MultipartRequest('POST', uri);
                                        request.fields['title'] = lessonname!;
                                        request.fields['meetCode'] =
                                            createcode();

                                        try {
                                          request.files.add(
                                              await http.MultipartFile.fromPath(
                                                  'support', Lessonfile ?? ''));
                                        } catch (error) {
                                          print(error);
                                        }
                                        var response = await request.send();
                                        //print(response);
                                        response.stream
                                            .transform(utf8.decoder)
                                            .listen((value) {
                                          //print(value);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => AddLessons(
                                                  courseid: checkid()),
                                            ),
                                          );
                                        });
                                        sleep(const Duration(seconds: 5));
                                      },
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
                                          "ADD",
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
