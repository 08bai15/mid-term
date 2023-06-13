import 'package:flutter/material.dart';
import 'package:flutter_application_5/views/splashscreen.dart';
import 'package:flutter_application_5/views/user.dart';

void main() {
  User user = User(); // Create a User object here
  runApp(MainApp(user: user));
}

class MainApp extends StatelessWidget {
  final User user;
  const MainApp({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barterlt',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
      ),
      home: SplashScreen(user: this.user),
    );
  }
}
