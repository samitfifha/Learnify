import 'package:flutter/material.dart';
import 'package:learnifyflutter/widgets/custom_dialog_box.dart';

import 'Welcome Screens/mainscreen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
    return ListView.builder(
      itemCount: 3,
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
                    ontap: () {
                      Navigator.pop(context, true);
                    },
                  );
                });
            print("Edit");
          } else if (direction == DismissDirection.endToStart) {
            // Right to left
            // nizar zid hne fazet el payement belehy !!!!!!!!!!!!!!!!!!!
            print("Delete");

            setState(() {});
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
