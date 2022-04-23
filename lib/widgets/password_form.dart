import 'package:flutter/material.dart';

class PASSForm extends StatefulWidget {
  @override
  _PASSFormState createState() => _PASSFormState();
}

class _PASSFormState extends State<PASSForm> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Password', true),
        buildInputForm('Confirm Password', true),
      ],
    );
  }

  Padding buildInputForm(String label, bool pass) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Color(0xFF979797),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1B383A)),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? Icon(
                            Icons.visibility_off,
                            color: Color(0xFF979797),
                          )
                        : Icon(
                            Icons.visibility,
                            color: Color(0xFF1B383A),
                          ),
                  )
                : null),
      ),
    );
  }
}
