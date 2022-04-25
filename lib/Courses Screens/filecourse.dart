import 'dart:io';

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:learnifyflutter/Courses%20Screens/addLessons.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:learnifyflutter/widgets/Custom_waiting_dialog.dart';
import 'package:learnifyflutter/widgets/custom_dialog_basic.dart';
import 'package:learnifyflutter/widgets/custom_dialog_box.dart';
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
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String userid;
  String? coursename;
  String? coursedesc;
  String? price;
  String? tag;
  String? Coursefile;
  late FilePickerResult? result;

  Future pickImage() async {
    result = await FilePicker.platform.pickFiles();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("_id")!;

    if (result != null) {
      Coursefile = result!.files.single.path;
      print(Coursefile);
    } else {
      // User canceled the picker
    }
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
                            'Add Course',
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
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10),
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
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          offset: Offset(0, 10),
                                                          blurRadius: 50,
                                                          color: Color(
                                                              0xffEEEEEE)),
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
                                          TextFormField(
                                            decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.dashboard_customize,
                                                color: Colors.blueAccent,
                                              ),
                                              hintText: "Course Name",
                                            ),
                                            onChanged: (String? value) {
                                              coursename = value;
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.description,
                                                color: Colors.blueAccent,
                                              ),
                                              hintText: "Course Description",
                                            ),
                                            onChanged: (String? value) {
                                              coursedesc = value;
                                            },
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
                                                    "paid",
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
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      icon: Icon(
                                                        Icons.description,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      hintText: "price TND",
                                                    ),
                                                    onChanged: (String? value) {
                                                      price = value;
                                                    },
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CustomAlertDialog3(
                                                title: "Processiong",
                                                description: "",
                                              );
                                            });
                                        var uri = Uri.parse(
                                            BaseURL + "courses/new/" + userid);

                                        var request =
                                            http.MultipartRequest('POST', uri);
                                        request.fields['title'] = coursename!;
                                        request.fields['description'] =
                                            coursedesc!;
                                        request.fields['nbrSeance'] = '1';
                                        request.fields['tag'] = value!;
                                        request.fields['price'] = price ?? '0';
                                        request.files.add(
                                            await http.MultipartFile.fromPath(
                                                'image', Coursefile!));
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
                                                  courseid: value.toString()),
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
