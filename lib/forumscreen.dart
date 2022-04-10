import 'package:flutter/material.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/utilities/customimage.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
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
                            width: 90,
                          ),
                          Text(
                            'Notifications',
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
                      SizedBox(
                        height: 400,
                        child: getMyCourses(),
                      )
                    ],
                  )),
            ),
          );
        })
      ],
    );
  }

  Widget getMyCourses() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(index),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.redAccent,
          ),
          child: Icon(Icons.delete, color: Colors.white),
          padding: const EdgeInsets.all(8.0),
        ),
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to delete this course?'),
                  actions: [
                    ElevatedButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    ElevatedButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              });
        },
        onDismissed: (direction) {
          print('Dismissed');
        },
        child: Container(
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
              // CustomImage(
              //   func(index),
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
                  Text("qsdqslkdqskjdnqsd"),
                ],
              )),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
