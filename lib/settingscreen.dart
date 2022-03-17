import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                          'Setting',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Nisebuschgardens',
                          ),
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
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
                            height: height * 0.7,
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    height: height * 0.65,
                                    child: ListView(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Account",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 15,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        buildAccountOptionRow(
                                            context, "Change password"),
                                        buildAccountOptionRow(
                                            context, "Content settings"),
                                        buildAccountOptionRow(
                                            context, "Social"),
                                        buildAccountOptionRow(
                                            context, "Language"),
                                        buildAccountOptionRow(
                                            context, "Privacy and security"),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.volume_up_outlined,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Notifications",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 15,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        buildNotificationOptionRow(
                                            "New for you", true),
                                        buildNotificationOptionRow(
                                            "Account activity", true),
                                        buildNotificationOptionRow(
                                            "Opportunity", false),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
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

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
