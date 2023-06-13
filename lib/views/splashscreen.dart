import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/views/user.dart';
import 'mainscreen.dart';

class SplashScreen extends StatefulWidget {
  final User user;
  const SplashScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 7),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (content) => MainScreen(user: widget.user)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bartlet",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(),
                  ),
                  Text("Version 0.1b"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
