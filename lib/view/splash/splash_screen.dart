import 'dart:async';
import 'dart:developer';
import 'package:bloc_sample/view/home/home_main_page_.dart';

import 'package:bloc_sample/widget/login_page_fi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

late String finalUserName;
late String finalEmail;
String keyUserName = 'username';
String keyEmail = 'email';

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidation().whenComplete(() async {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => finalUserName == '' && finalEmail == ''
                    ? const LoginPage()
                    : const HomePageSample())),
      );
    });
    super.initState();
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var useName = sharedPreferences.getString(
      keyUserName,
    );
    var email = sharedPreferences.getString(
      keyEmail,
    );
    setState(() {
      finalUserName = useName ?? '';
      finalEmail = email ?? '';
    });
    log(finalUserName);
    log(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 200,
              color: Colors.blue,
            ),
            Text("Data List", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
