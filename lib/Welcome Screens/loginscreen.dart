import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/Welcome%20Screens/registerscreen.dart';

import 'package:learnifyflutter/Welcome Screens/mainscreen.dart';

import 'package:http/http.dart' as http;
import 'package:learnifyflutter/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "idlogin";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String? email;
  late String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.teal, Colors.cyan, Colors.indigo])),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/Untitled-2.png",
                        height: 100,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.blueAccent,
                  ),
                  hintText: "Enter Email",
                ),
                onSaved: (String? value) {
                  email = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Username must not be empty";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                obscureText: true,
                cursorColor: Color(0xffF5591F),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.blueAccent,
                    ),
                    hintText: "Enter Password",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
                onSaved: (String? value) {
                  password = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "password must not be empty";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 caracters long";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, right: 20),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Text("Forget Password ?"),
                onTap: () => {},
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (_formkey.currentState!.validate()) {
                  _formkey.currentState!.save();

                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=utf-8"
                  };
                  Map<String, dynamic> body = {
                    "email": email!,
                    "password": password!
                  };
                  http
                      .post(Uri.parse(BaseURL + "users/login"),
                          headers: headers, body: json.encode(body))
                      .then((response) async {
                    print(response.statusCode);
                    if (response.statusCode == 200) {
                      Map<String, dynamic> userData =
                          json.decode(response.body);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      //print(userData["_id"]);
                      prefs.setString("_id", userData["_id"]);
                      print(userData["_id"]);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MainScreen(),
                        ),
                      );
                      //Navigator.pushReplacementNamed(context, "/home");
                      print("success login");
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Informations"),
                              content:
                                  Text("Email et/ou mot de passe invalides"),
                            );
                          });
                    }
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 90),
                padding: EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                height: 54,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (new Color(0xff4B0082)),
                      (new Color(0xff00FFFF))
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ]),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have Account ?"),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()))
                    },
                    child: Text(
                      "Register Now",
                      style: TextStyle(color: Color(0xff00FFFF)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
