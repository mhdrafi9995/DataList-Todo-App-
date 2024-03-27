import 'package:bloc_sample/configration.dart';
import 'package:bloc_sample/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  DrawerScreenState createState() => DrawerScreenState();
}
String profileImg='https://post.healthline.com/wp-content/uploads/2021/12/happy-hiking-alone-portrait-1296x728-header.jpg';

class DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 866,
            color: primaryGreen,
            padding: const EdgeInsets.only(top: 50, bottom: 70, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                     CircleAvatar(
                      backgroundImage: NetworkImage(profileImg),
                      
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          finalUserName,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(finalEmail,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
                Column(
                  children: drawerItems
                      .map((element) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  element['icon'],
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(element['title'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))
                              ],
                            ),
                          ))
                      .toList(),
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Powered by   I B I N U",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.heart_broken, color: Colors.red),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                          color: Colors.white54, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
