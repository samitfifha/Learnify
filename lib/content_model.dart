import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnifyflutter/addcoursescreen.dart';
import 'package:learnifyflutter/favoritescreen.dart';
import 'package:learnifyflutter/forumscreen.dart';
import 'package:learnifyflutter/messagesscreen.dart';
import 'package:learnifyflutter/profilescreen.dart';
import 'package:learnifyflutter/screen2.dart';

class UnbordingContent {
  final String image;
  final String title;
  final String discription;

  const UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  const UnbordingContent(
      title: 'Help Eachother',
      image: 'assets/images/4413059.png',
      discription: "Learnify helps you learning and teaching "
          "find what you're doing best and help others doing it as good as you do it  "
          "find someone to help you understanding subjects"),
  const UnbordingContent(
      title: 'Live VisioConference',
      image: 'assets/images/3784896.jpg',
      discription: "learnify offers you the best visioconfernce quality  "
          "including chats, screensharing, and more "
          "a shared IDE will be also available for coding & programing courses "),
  const UnbordingContent(
      title: 'Certified Courses',
      image: 'assets/images/20944350.jpg',
      discription: "Learnify will offer you over 1,000 of Certified Courses "
          "learnify offer you a certificat using BlockChain "
          "Pass the quiz after each course and get your certificate"),
];

List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300]!, blurRadius: 30, offset: Offset(0, 10))
];
List<Map> categories = [
  {'name': 'Coding', 'iconPath': 'assets/images/code.png'},
  {'name': 'maths', 'iconPath': 'assets/images/math.png'},
  {'name': 'languages', 'iconPath': 'assets/images/translate.png'},
  {'name': 'Courses', 'iconPath': 'assets/images/online-course.png'},
  {'name': 'support', 'iconPath': 'assets/images/support.png'}
];

List<Map> drawerItems = [
  {'icon': Icons.spellcheck, 'title': 'Forum', 'screen': ForumScreen()},
  {
    'icon': FontAwesomeIcons.plus,
    'title': 'Add course',
    'screen': AddCourseScreen()
  },
  {'icon': Icons.favorite, 'title': 'Favorites', 'screen': FavoriteScreen()},
  {'icon': Icons.mail, 'title': 'Messages', 'screen': MessagesScreen()},
  {
    'icon': FontAwesomeIcons.userAlt,
    'title': 'Profile',
    'screen': ProfileScreen()
  },
];
