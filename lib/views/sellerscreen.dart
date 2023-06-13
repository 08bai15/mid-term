import 'package:flutter/material.dart';


class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Seller"),
          actions: [
            IconButton(
              onPressed: _registrationForm,
              icon: const Icon(Icons.app_registration),
            )
          ],
        ),
        body: const Center(child: Text('Seller')),
      ),
    );
  }

  void _registrationForm() {
    // Add your logic for the registration form here
  }
}