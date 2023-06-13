import 'package:flutter/material.dart';
import 'package:flutter_application_5/views/profilescreen.dart';
import 'package:flutter_application_5/views/sellerpage.dart';
import 'package:flutter_application_5/views/user.dart';
import 'package:flutter_application_5/views/loginscreen.dart';

import 'BuyerScreen.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> tabChildren;

  @override
  void initState() {
    super.initState();
    print(widget.user.name);
    print("Main Screen");
    tabChildren = [
      BuyerScreen(user: widget.user),
      SellerScreen(user: widget.user),
      ProfileScreen(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buyer")),
      body: const Center(child: Text('Please Log In to link your account')),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountEmail: const Text(
                  '@gmail.com'), // keep blank text because email is required
              accountName: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 64, 16, 126),
                      child: Icon(
                        Icons.check,
                      ),
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Unregistered'),
                      Text('Unregistered'),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Buyer'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(user: widget.user),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Seller'),
              onTap: () {
                insertDialog();
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(user: widget.user),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void insertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: const Text(
            "You have not Log in to an account!",
            style: TextStyle(),
          ),
          content: const Text("Do you want to sign in an account",
              style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                builder:
                (context) => ProfileScreen(user: widget.user);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
