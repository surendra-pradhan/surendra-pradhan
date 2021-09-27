import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myshop/constant.dart';
import 'package:myshop/helpers/httpexception.dart';
import 'package:myshop/providers/authprovider.dart';
import 'package:myshop/screens/auth/signupScreen.dart';
import 'package:myshop/screens/ui/cartscreen/adressScreen.dart';

import 'package:provider/provider.dart';

class LoginInputs extends StatefulWidget {
  @override
  _LoginInputsState createState() => _LoginInputsState();
}

class _LoginInputsState extends State<LoginInputs> {
  bool _hidepassword = true;
  final _forms = GlobalKey<FormState>();
  final passwordFous = FocusNode();
  Map<String, String> loginData = {'email': '', 'password': ''};

  void _showDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error Occured'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('okay'),
          )
        ],
      ),
    );
  }

  void _onSaveData() async {
    _forms.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false)
          .signIn(loginData['email'], loginData['password']);
      // Navigator.of(context).pushNamed(AddressScreen.routerName);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AddressScreen(),
        ),
      );
    } on HttpException catch (error) {
      _showDialog(error.toString());
    } catch (err) {
      print(err);
      var errormsg = 'Could not Authenticate ! Please try Again later';
      _showDialog(errormsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    void _showHidePassword() {
      setState(() {
        _hidepassword = !_hidepassword;
      });
    }

    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _forms,
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Email Address',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFous);
              },
              onSaved: (val) {
                loginData = {'email': val, 'password': loginData['password']};
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                focusNode: passwordFous,
                style: TextStyle(color: Colors.black),
                onSaved: (val) {
                  loginData = {'email': loginData['email'], 'password': val};
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: _showHidePassword,
                    icon: Icon(_hidepassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    color: Colors.black,
                  ),
                  hintText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                obscureText: _hidepassword),
            SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: Text('Forgot Password?'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  child: Text("Login".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Sanspro',
                      )),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  onPressed: _onSaveData),
            ),
            SizedBox(
              height: 15,
            ),
            Text("OR Login With".toUpperCase()),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.google),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text('OR'),
                SizedBox(
                  width: 15,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.facebookF),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignUpScreen.routerName);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
