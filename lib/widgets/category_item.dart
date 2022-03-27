import 'package:flutter/material.dart';
import 'package:learnifyflutter/utilities/content_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key, required this.data, this.isActive = false, this.ontap})
      : super(key: key);
  final data;
  final bool isActive;
  final GestureTapCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
            color: isActive ? Colors.blueAccent : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.white70.withOpacity(.05),
                  blurRadius: .5,
                  spreadRadius: .5,
                  offset: Offset(1, 1))
            ]),
        child: Row(
          children: [
            Image.asset(data['icon'],
                height: 15,
                width: 15,
                color: isActive ? Colors.white : Colors.black),
            SizedBox(
              width: 5,
            ),
            Text(
              data['name'],
              style: TextStyle(color: isActive ? Colors.white : Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
