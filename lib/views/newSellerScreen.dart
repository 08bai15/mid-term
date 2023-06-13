import 'package:flutter/material.dart';
import 'package:flutter_application_5/views/insertitemscreen.dart';
import 'package:flutter_application_5/views/profilescreen.dart';
import 'package:flutter_application_5/views/profiletabscreen.dart';
import 'package:flutter_application_5/views/sellerpage.dart';
import 'package:flutter_application_5/views/user.dart';

import 'BuyerScreen.dart';


class nSellerScreen extends StatefulWidget {
  final User user;

  const nSellerScreen({super.key, required this.user});

  @override
  State<nSellerScreen> createState() => _nSellerScreenState();
}

class _nSellerScreenState extends State<nSellerScreen> {
  late List<Widget> tabChildren;
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Seller";
 // List<Catch> catchList = <Catch>[];

@override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void initState() {
    super.initState();
    print(widget.user.name);
    print("new Sller Screen");
    tabChildren = [
      BuyerScreen(user: widget.user),
      SellerScreen(user: widget.user),
      ProfileScreen(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
     if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Seller")),
      body:  Center(),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          if(widget.user.id != "na"){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (content)=> InsertItemScreen(user: widget.user,)));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please login/register an account")));

            
          }
      
        },
        child: const Text(
            "+",
            style: TextStyle(fontSize: 32),
      )),
     
     
     
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
    ); } 



}