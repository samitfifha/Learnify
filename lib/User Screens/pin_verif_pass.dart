import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learnifyflutter/widgets/OtpForm.dart';
import 'package:learnifyflutter/widgets/primary_button.dart';

class Pin_verif extends StatefulWidget {
  const Pin_verif({Key? key}) : super(key: key);

  @override
  State<Pin_verif> createState() => _Pin_verifState();
}

class _Pin_verifState extends State<Pin_verif> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  startTimer() {
    timer = Timer(Duration(seconds: 1), () {
      setState(() => seconds--);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                'Verification Code',
                style: TextStyle(
                    color: Color(0xFF1B383A),
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'We have sent the verification code to your email address Please enter the code below to verify your account',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 50,
              ),
              OtpForm(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black),
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ).copyWith(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.cyan),
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ).copyWith(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
