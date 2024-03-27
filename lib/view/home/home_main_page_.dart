import 'package:bloc_sample/view/drawer_animation/drawer_animation.dart';
import 'package:bloc_sample/view/home/home_page.dart';
import 'package:flutter/material.dart';

class HomePageSample extends StatelessWidget {
  const HomePageSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
         DrawerScreen(),
          HomePage()

        ],
      ),

    );
  }
}