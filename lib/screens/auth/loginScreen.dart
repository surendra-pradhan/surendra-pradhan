import 'package:flutter/material.dart';
import '../../widgets/auth/loginiputs.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/signinScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: Image.asset('assets/images/loginimage.png',
                  height: MediaQuery.of(context).size.height * 0.35),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Login Now",
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Please enter details below to continue",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            LoginInputs()
          ],
        ),
      ),
    );
  }
}
