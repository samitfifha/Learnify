import 'package:flutter/material.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:image_picker/image_picker.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({Key? key}) : super(key: key);

  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
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
                                        Divider(
                                          height: 15,
                                          thickness: 2,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: CheckboxListTile(
                                                title: const Text(
                                                  "Meeting",
                                                  style: TextStyle(fontSize: 6),
                                                ),
                                                value: isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                            Flexible(
                                              child: CheckboxListTile(
                                                title: const Text(
                                                  "PDF",
                                                  style: TextStyle(fontSize: 6),
                                                ),
                                                value: isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                            Flexible(
                                              child: CheckboxListTile(
                                                title: const Text(
                                                  "Videos",
                                                  style: TextStyle(fontSize: 6),
                                                ),
                                                value: isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
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
