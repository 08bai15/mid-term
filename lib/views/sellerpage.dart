import 'package:flutter/material.dart';
import 'package:flutter_application_5/views/profilescreen.dart';
import 'package:flutter_application_5/views/user.dart';
import 'insertitemscreen.dart';
import 'mainscreen.dart';

class SellerScreen extends StatefulWidget {
  final User user;
  const SellerScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: const Text("Seller")),
        body: const Center(child: Text('Please Log In to link your account')),
        floatingActionButton:FloatingActionButton(
        onPressed: (){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please login/register an account")));
        },
        child: const Text(
            "+",
            style: TextStyle(fontSize: 32),
      )),
     
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountEmail: const Text('@gmail.com'),
                accountName: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: const CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.check,
                        ),
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('user'),
                        Text('@User'),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Buyer'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(user: widget.user)),
                  );
                },
              ),
              ListTile(
                title: const Text('Seller'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => SellerScreen(user: widget.user)),
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
                        builder: (context) => ProfileScreen(user: widget.user),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
