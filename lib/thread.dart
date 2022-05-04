import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learnifyflutter/App%20Screens/Forumscreen.dart';
import 'package:learnifyflutter/Models/ForumModel.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/ForumModel.dart';

class ThreadScreen extends StatefulWidget {
  var mythread;

  ThreadScreen({Key? key, this.mythread}) : super(key: key);

  @override
  State<ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<ThreadScreen> {
  String? content1;

  _buildMessage(index) {
    final Container msg = Container(
      margin: false
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: Color(0xFFFFEFEE),
        /*borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),*/
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.mythread.comments[index]["content"],
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    /*if (isMe) {
      return msg;
    }*/
    return Row(
      children: <Widget>[
        msg,
        /*IconButton(
          icon: message.isLiked
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: message.isLiked
              ? Theme.of(context).primaryColor
              : Colors.blueGrey,
          onPressed: () {},
        )*/
      ],
    );
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
                                    builder: (context) => MessagesScreen()));
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
                          widget.mythread.title,
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
                    Container(
                      width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      child: Column(
                        children: [
                          Center(),
                          SizedBox(
                            height: 10,
                          ),
                          if (widget.mythread.tag == "coding")
                            Image.network(
                              'https://images.unsplash.com/photo-1542831371-29b0f74f9713?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                              width: 300,
                              height: 300,
                            ),
                          if (widget.mythread.tag == "design")
                            Image.network(
                              'https://images.unsplash.com/photo-1561070791-2526d30994b5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
                              width: 300,
                              height: 300,
                            ),
                          if (widget.mythread.tag == "languages")
                            Image.network(
                              'https://images.unsplash.com/photo-1538708591342-2dcd6706e3b6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
                              width: 300,
                              height: 300,
                            ),
                          if (widget.mythread.tag == "business")
                            Image.network(
                              'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1115&q=80',
                              width: 300,
                              height: 300,
                            ),
                          if (widget.mythread.tag == "art")
                            Image.network(
                              'https://images.unsplash.com/photo-1513364776144-60967b0f800f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
                              width: 300,
                              height: 300,
                            ),
                          if (widget.mythread.tag == "cooking")
                            Image.network(
                              'https://images.unsplash.com/photo-1528712306091-ed0763094c98?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=740&q=80',
                              width: 300,
                              height: 300,
                            ),
                          if (widget.mythread.tag == "music")
                            Image.network(
                              'https://images.unsplash.com/photo-1507838153414-b4b713384a76?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                              width: 300,
                              height: 300,
                            ),
                          if (widget.mythread.tag == "finance")
                            Image.network(
                              'https://images.unsplash.com/photo-1638913659197-46040471de1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                              width: 300,
                              height: 300,
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          ReadMoreText(
                            widget.mythread.content,
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      reverse: true,
                      padding: EdgeInsets.only(top: 15.0),
                      itemCount: widget.mythread.comments.length,
                      itemBuilder: (context, index) => _buildMessage(index),
                    )),
                    buildMessageComposer(),
                  ],
                ),
              ),
            ),
          );
        })
      ],
    );
  }

  buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.photo),
          //   iconSize: 25.0,
          //   color: Theme.of(context).primaryColor,
          //   onPressed: () {},
          // ),
          Expanded(
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                content1 = value;
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              userid = prefs.getString("_id")!;
              Map<String, String> headers = {
                "Content-Type": "application/json; charset=utf-8"
              };
              Map<String, dynamic> body = {
                "content": content1,
                "userid": userid,
                "threadid": widget.mythread.id,
              };
              http
                  .post(Uri.parse(BaseURL + "comments/new/"),
                      headers: headers, body: json.encode(body))
                  .then((response) async {
                print(response.statusCode);
                if (response.statusCode == 201) {
                  Map<String, dynamic> userData = json.decode(response.body);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MessagesScreen(),
                    ),
                  );
                  //Navigator.pushReplacementNamed(context, "/home");
                  print("success addd");
                } else {
                  print("failed");
                }
              });
            },
          ),
        ],
      ),
    );
  }

  // buildMessage(Thread comment, bool isMe) {
  //   final Container msg = Container(
  //     margin: isMe
  //         ? EdgeInsets.only(
  //             top: 8.0,
  //             bottom: 8.0,
  //             left: 80.0,
  //           )
  //         : EdgeInsets.only(
  //             top: 8.0,
  //             bottom: 8.0,
  //           ),
  //     padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
  //     width: MediaQuery.of(context).size.width * 0.75,
  //     decoration: BoxDecoration(
  //       color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
  //       borderRadius: isMe
  //           ? BorderRadius.only(
  //               topLeft: Radius.circular(15.0),
  //               bottomLeft: Radius.circular(15.0),
  //             )
  //           : BorderRadius.only(
  //               topRight: Radius.circular(15.0),
  //               bottomRight: Radius.circular(15.0),
  //             ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text(
  //           widget.mythread.comments[0].user.username,
  //           style: TextStyle(
  //             color: Colors.blueGrey,
  //             fontSize: 16.0,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //         SizedBox(height: 8.0),
  //         Text(
  //           widget.mythread.comments.content,
  //           style: TextStyle(
  //             color: Colors.blueGrey,
  //             fontSize: 16.0,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  //   if (isMe) {
  //     return msg;
  //   }
  //   return Row(
  //     children: <Widget>[
  //       msg,
  //       /*IconButton(
  //         icon: message.isLiked
  //             ? Icon(Icons.favorite)
  //             : Icon(Icons.favorite_border),
  //         iconSize: 30.0,
  //         color: message.isLiked
  //             ? Theme.of(context).primaryColor
  //             : Colors.blueGrey,
  //         onPressed: () {},
  //       )*/
  //     ],
  //   );
  // }
}
