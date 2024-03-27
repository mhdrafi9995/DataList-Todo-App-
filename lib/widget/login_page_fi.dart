import 'package:bloc_sample/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool passwordVisi = false;
  String keyUserName = 'username';
  String keyEmail = 'email';
  String savedValue = 'seved_value';

  final String loginImg =
      'https://i.pinimg.com/564x/8e/76/bf/8e76bf6be8a1ef49cd0072c95acaf2c1.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.black54, Colors.black12],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(loginImg),
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(Colors.black45, BlendMode.darken),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40.0, left: 14),
                child: Text(
                  "Login to your account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 14),
                child: Text("Enjoy your time with us",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 200),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.white70),
                        decoration: const InputDecoration(
                          label: Text(
                            'Enter your name...',
                            style: TextStyle(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white70, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white70),
                        decoration: const InputDecoration(
                          label: Text(
                            'Enter your email...',
                            style: TextStyle(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white70, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Space between input fields
                      TextFormField(
                        obscureText: passwordVisi,
                        keyboardType: TextInputType.number,
                        controller: _passwordController,
                        // For password input
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisi = !passwordVisi;
                              });
                            },
                            icon: Icon(
                                passwordVisi
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white),
                          ),
                          label: const Text('Enter your password',
                              style: TextStyle(color: Colors.white)),
                          hintStyle: const TextStyle(color: Colors.white70),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white70, width: 1.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 180,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () async {
                            final SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.setString(
                              keyEmail,
                              _emailController.text,
                            );
                            preferences.setString(
                              keyUserName,
                              _usernameController.text,
                            );
                            if (_usernameController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty &&
                                _emailController.text.isNotEmpty) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              loginErrorMsg(context);
                            }
                            // ignore: use_build_context_synchronously
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginErrorMsg(BuildContext context) {
    double snackBarOpacity = 0;

    final snackBar = SnackBar(
      duration: const Duration(seconds: 4),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              snackBarOpacity = 1;
            });
          });

          return AnimatedOpacity(
            opacity: snackBarOpacity,
            duration: const Duration(seconds: 1),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEB6651),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(children: [
                Icon(Icons.warning, color: Colors.white),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Somthing went wrong",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    // Show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> getSavedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString(savedValue);
    if (savedData != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    }
  }
}
