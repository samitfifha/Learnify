import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  final double _borderRadius = 20;
  final String title, description;

  CustomDialogBox({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: width,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(
                top: 24,
                left: 20,
                right: 20,
                bottom: 80,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_borderRadius),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 1.5,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
