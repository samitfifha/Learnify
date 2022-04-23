import 'package:flutter/material.dart';
import 'package:learnifyflutter/Courses%20Screens/screen2.dart';

import 'package:learnifyflutter/utilities/customimage.dart';
import 'package:learnifyflutter/utilities/utils.dart';

class FeatureItem extends StatelessWidget {
  FeatureItem(
      {Key? key,
      required this.data,
      this.width = 280,
      this.height = 290,
      this.onTap})
      : super(key: key);
  final data;
  final double width;
  final double height;
  final GestureTapCallback? onTap;

  String func() {
    final profilePicpath = data.image.toString();
    if (data.image.startsWith('public')) {
      final profilePic = profilePicpath.substring(22, profilePicpath.length);
      final imagePath = BaseURL + 'uploads/lessons/' + profilePic;
      return imagePath;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Screen2(myObject: data),
          ),
        );
      },
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            CustomImage(
              func(),
              width: double.infinity,
              height: 190,
              radius: 15,
            ),
            Positioned(
              top: 170,
              right: 15,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[900],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Text(
                  data.price.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Positioned(
              top: 210,
              child: Container(
                width: width - 20,
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getAttribute(Icons.play_circle_outlined,
                            Color(0xFF8A8989), data.nbrSeance.toString()),
                        SizedBox(
                          width: 12,
                        ),
                        getAttribute(Icons.schedule_rounded, Color(0xFF8A8989),
                            data.nbrSeance.toString()),
                        SizedBox(
                          width: 12,
                        ),
                        getAttribute(Icons.star, Color(0xFFffcb66), data.tag),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getAttribute(IconData icon, Color color, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Color(0xFF8A8989), fontSize: 13),
        ),
      ],
    );
  }
}
