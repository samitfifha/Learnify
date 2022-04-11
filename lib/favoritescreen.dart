import 'package:flutter/material.dart';
import 'package:learnifyflutter/explore.dart';
import 'package:learnifyflutter/screen2.dart';
import 'package:learnifyflutter/widgets/custom_dialog_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learnifyflutter/Models/coursesModel.dart';

import 'Welcome Screens/mainscreen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

List wishlist = [];
late Future<bool> fetchedCourses;

Future<bool> fetchcourses() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userid = prefs.getString("_id")!;
  http.Response response = await http
      .get(Uri.parse(BaseURL + "users/wish/" + userid))
      .then((response) async {
    //print(response.statusCode);
    if (response.statusCode == 200) {
      wishlist = json
          .decode(response.body)
          .map((data) => Course.fromJson(data))
          .toList();
    }
    return response;
  });
  return true;
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  void initState() {
    super.initState();
    fetchedCourses = fetchcourses();
  }

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
          return Center(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 73),
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
                              'My WishList',
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
                          child: getMyfavorite(),
                        )
                      ],
                    )),
              ),
            ),
          );
        })
      ],
    );
  }

  final leftEditIcon = Container(
    color: Colors.green,
    child: Icon(Icons.edit),
    alignment: Alignment.centerLeft,
  );
  final rightDeleteIcon = Container(
    color: Colors.red,
    child: Icon(Icons.delete),
    alignment: Alignment.centerRight,
  );

  Widget getMyfavorite() {
    return RefreshIndicator(
      onRefresh: () async {
        await fetchcourses();
        setState(() {});
      },
      child: ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(index),
          secondaryBackground: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blueAccent,
            ),
            child: Icon(Icons.shopping_bag, color: Colors.white),
            padding: const EdgeInsets.all(8.0),
          ),
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.redAccent,
            ),
            child: Icon(Icons.delete, color: Colors.white),
            padding: const EdgeInsets.all(8.0),
          ),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.startToEnd) {
              // Left to right
              // Nizar Zid hne fazet el delete from wishlist eli besh taamlha
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      title: "Alert",
                      description: "Are you sure you want to delete this?",
                      ontap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final userid = prefs.getString("_id")!;
                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=utf-8"
                        };
                        Map<String, dynamic> body = {
                          "courseid": wishlist[index].id.toString(),
                        };
                        http.post(
                            Uri.parse(BaseURL + "users/wishremove/" + userid),
                            headers: headers,
                            body: json.encode(body));

                        Navigator.pop(context, true);
                      },
                    );
                  });
            } else if (direction == DismissDirection.endToStart) {
              // Right to left
              // nizar zid hne fazet el payement belehy !!!!!!!!!!!!!!!!!!!
              print("Delete");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Screen2(myObject: wishlist[index]),
                ),
              );
            }
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
                    Text(wishlist[index].title.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Nisebuschgardens',
                            fontWeight: FontWeight.bold)),
                  ],
                )),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
