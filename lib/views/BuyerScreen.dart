import 'package:flutter/material.dart';
import 'package:flutter_application_5/views/profilescreen.dart';
import 'package:flutter_application_5/views/profiletabscreen.dart';
import 'package:flutter_application_5/views/sellerpage.dart';
import 'package:flutter_application_5/views/user.dart';

import 'newSellerScreen.dart';

/*import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'mainscreen.dart';
import 'registrationscreen.dart';
import 'user.dart'; */

class BuyerScreen extends StatefulWidget {
  final User user;

  const BuyerScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  late List<Widget> tabChildren;

  @override
  void initState() {
    super.initState();
    print(widget.user.name);
    print("Buyer Screen");
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
      body: const Center(child: Text('...')),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountEmail:  Text(widget.user.email ?? ''), // keep blank text because email is required
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
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.user.name ?? ''),
                      
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
                    builder: (context) => BuyerScreen(user: widget.user),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Seller'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => nSellerScreen(user: widget.user),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileTabScreen(user: widget.user),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
