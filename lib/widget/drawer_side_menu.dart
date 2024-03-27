import 'package:bloc_sample/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/564x/82/19/e9/8219e955fd50a0eb26959d17f4b173c7.jpg'),
              radius: 90,
              backgroundColor: Colors.white,
            ),
            accountName: Text(
              "$finalUserName...",
              style: const TextStyle(fontSize: 20),
            ),
            accountEmail:  Text("$finalEmail..."),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    'https://i.pinimg.com/564x/2c/bd/86/2cbd860274e76a184d049da6751e1e42.jpg',
                  ),
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
