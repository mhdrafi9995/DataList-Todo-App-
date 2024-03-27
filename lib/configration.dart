import 'package:flutter/material.dart';


Color primaryGreen = const Color(0xff008080);
List<BoxShadow> shadowList = [
  BoxShadow(
      color: Colors.grey[300]!, blurRadius: 30, offset: const Offset(0, 10)),
];



List<Map> drawerItems = [
  {'icon': Icons.star, 'title': 'Raiting'},
  {'icon': Icons.notifications, 'title': 'Notification'},
  {'icon': Icons.favorite, 'title': 'Favorites'},
  {'icon': Icons.mail, 'title': 'Messages'},
  {'icon': Icons.settings, 'title': 'Settings'},
];
