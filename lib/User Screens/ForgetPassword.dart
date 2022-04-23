import 'package:flutter/material.dart';
import 'package:learnifyflutter/User%20Screens/loginscreen.dart';
import 'package:learnifyflutter/widgets/primary_button.dart';
import 'package:learnifyflutter/widgets/reset_form.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
            ),
            Text(
              'Reset Password',
              style: TextStyle(
                  color: Color(0xFF1B383A),
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Please enter your email address',
              style: TextStyle(
                      color: Color(0xFF59706F),
                      fontSize: 18,
                      fontWeight: FontWeight.w500)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            ResetForm(),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: PrimaryButton(buttonText: 'Reset Password')),
            SizedBox(height: 35),
            Row(
              children: [
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                              color: Color(0xFF59706F),
                              fontSize: 18,
                              fontWeight: FontWeight.w500)
                          .copyWith(fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
