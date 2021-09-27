import 'package:flutter/material.dart';
import 'package:myshop/providers/authprovider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<Auth>(context, listen: false).logOut();
          },
          child: Text('LogOut'),
        ),
      ),
    );
  }
}
