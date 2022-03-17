import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnifyflutter/User%20Screens/profilescreen.dart';
import 'package:learnifyflutter/favoritescreen.dart';
import 'package:learnifyflutter/forumscreen.dart';
import 'package:learnifyflutter/messagesscreen.dart';
import 'package:learnifyflutter/screen2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../Courses Screens/choicetypescreen.dart';

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
  {"name": 'All', 'iconPath': 'assets/images/all.png'},
  {'name': 'Coding', 'iconPath': 'assets/images/coding.png'},
  {'name': 'education', 'iconPath': 'assets/images/education.png'},
  {'name': 'design', 'iconPath': 'assets/images/design.png'},
  {'name': 'business', 'iconPath': 'assets/images/business.png'},
  {'name': 'cooking', 'iconPath': 'assets/images/cooking.png'},
  {'name': 'music', 'iconPath': 'assets/images/music.png'},
  {'name': 'art', 'iconPath': 'assets/images/art.png'},
  {'name': 'finance', 'iconPath': 'assets/images/finance.png'},
];

List<Map> drawerItems = [
  {
    'icon': Icons.notifications,
    'title': 'Notification',
    'screen': ForumScreen()
  },
  {
    'icon': FontAwesomeIcons.plus,
    'title': 'Add course',
    'screen': ChoiceTypeScreen()
  },
  {
    'icon': Icons.favorite_border,
    'title': 'Favorites',
    'screen': FavoriteScreen()
  },
  {
    'icon': Icons.mark_email_unread,
    'title': 'Messages',
    'screen': MessagesScreen()
  },
  {
    'icon': FontAwesomeIcons.userAlt,
    'title': 'Profile',
    'screen': ProfileScreen()
  },
];
