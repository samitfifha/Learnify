import 'package:flutter/material.dart';

class ResetForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyle(color: Color(0xFF979797)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1B383A)))),
      ),
    );
  }
}
