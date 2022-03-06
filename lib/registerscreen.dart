import 'package:flutter/material.dart';
import 'package:learnifyflutter/loginscreen.dart';
import 'package:learnifyflutter/mainscreen.dart';
import 'package:learnifyflutter/utils.dart';
import 'package:http/http.dart' as http;
import 'package:learnifyflutter/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String? firstname;
  late String? lastname;
  late String? email;
  late String? phonenumber;
  late String? password;
  late String? cpassword;
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
                      BorderRadius.only(bottomRight: Radius.circular(90)),
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
                      margin: EdgeInsets.only(top: 20, left: 20),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 70),
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
                cursorColor: Color(0xffF5591F),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.indigo,
                    ),
                    hintText: "Enter First Name",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
                onSaved: (String? value) {
                  firstname = value;
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
                cursorColor: Color(0xffF5591F),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.indigo,
                    ),
                    hintText: "Enter Last Name",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
                onSaved: (String? value) {
                  lastname = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Last name must not be empty";
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
                cursorColor: Color(0xffF5591F),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.mail,
                      color: Colors.indigo,
                    ),
                    hintText: "Enter Email",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
                onSaved: (String? value) {
                  email = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Email must not be empty";
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
                cursorColor: Color(0xffF5591F),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.indigo,
                    ),
                    hintText: "Phone Number",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
                // onSaved: (String? value) {
                //   phonenumber = value;
                // },
                // validator: (String? value) {
                //   if (value == null || value.isEmpty) {
                //     return "Username must not be empty";
                //   } else {
                //     return null;
                //   }
                // },
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
                      color: Colors.indigo,
                    ),
                    hintText: "Enter Password",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
                onSaved: (String? value) {
                  password = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Password must not be empty";
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
                      Icons.lock_outline,
                      color: Colors.indigo,
                    ),
                    hintText: "Confirm Password",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
                onSaved: (String? value) {
                  cpassword = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "confirm your password";
                  } else {
                    return null;
                  }
                },
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
                    "firstName": firstname!,
                    "lastName": lastname!,
                    "email": email!,
                    "password": password!
                  };
                  http
                      .post(Uri.parse(BaseURL + "users/register"),
                          headers: headers, body: json.encode(body))
                      .then((response) async {
                    print(response.statusCode);
                    if (response.statusCode == 201) {
                      Map<String, dynamic> userData =
                          json.decode(response.body);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
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
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have Account ?"),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                    },
                    child: Text(
                      "Login Now",
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
