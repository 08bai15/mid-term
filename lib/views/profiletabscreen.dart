import 'package:flutter/material.dart';
import 'package:flutter_application_5/views/user.dart';




class ProfileTabScreen extends StatefulWidget {
  final User user;

  const ProfileTabScreen({super.key, required this.user});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  late List<Widget> tabchildren;
  String maintitle = "Profile";
  late double screenHeight, screenWidth, cardwitdh;

  @override
  void initState() {
    super.initState();
    print("Profile");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body: Center(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: screenHeight * 0.25,
            width: screenWidth,
            child: Card(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.all(4),
                  width: screenWidth * 0.5,
                  child: Image.asset(
                    "assets/images/profile.png",
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Text(
                          widget.user.name.toString(),
                          style: const TextStyle(fontSize: 33),
                        ),
                        Text(widget.user.email.toString(),style: const TextStyle(fontSize: 20)),
                        Text(''),
                        Text(widget.user.phone.toString(),style: const TextStyle(fontSize: 20)),
                        Text(''),
                        Text(widget.user.datereg.toString(),style: const TextStyle(fontSize: 20)),
                      ],
                    )),
              ]),
            ),
          ),
          Container(
            width: screenWidth*0.9,
            alignment: Alignment.center,
            color: Color.fromARGB(255, 233, 166, 66),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(7, 9, 7, 9),
              child: 
                  Text("PROFILE SETTINGS",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),]
        )));
           }
}