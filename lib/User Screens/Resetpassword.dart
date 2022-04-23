import 'package:flutter/material.dart';
import 'package:learnifyflutter/widgets/password_form.dart';
import 'package:learnifyflutter/widgets/primary_button.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                height: 120,
              ),
              Text(
                'New Password',
                style: TextStyle(
                    color: Color(0xFF1B383A),
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              PASSForm(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                buttonText: 'Submit Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
