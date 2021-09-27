import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myshop/constant.dart';
import 'package:myshop/helpers/httpexception.dart';
import 'package:myshop/providers/authprovider.dart';
import 'package:provider/provider.dart';

class SignupInputs extends StatefulWidget {
  @override
  _SignupInputsState createState() => _SignupInputsState();
}

class _SignupInputsState extends State<SignupInputs> {
  final _forms = GlobalKey<FormState>();
  final passwordFous = FocusNode();
  final confirmPasswordFocus = FocusNode();
  final phonefocusenode = FocusNode();
  final refralfocusenode = FocusNode();
  Map<String, String> loginData = {
    'name': '',
    'email': '',
    'password': '',
    'phone': '',
    "refralcode": ''
  };

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

  Future<void> _onSaveData() async {
    _forms.currentState.save();
    _forms.currentState.validate();
    try {
      await Provider.of<Auth>(context, listen: false).signUp(
          loginData['name'],
          loginData['email'],
          loginData['password'],
          int.parse(loginData['phone']),
          loginData["refralcode"]);
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
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _forms,
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Name',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFous);
              },
              validator: (val) {
                if (val.isEmpty) {
                  return 'field should be fill up';
                }
                return null;
              },
              onSaved: (val) {
                loginData = {
                  'name': val,
                  'email': loginData['email'],
                  'password': loginData['password'],
                  'phone': loginData['phone'],
                  "refralcode": loginData['refralcode']
                };
              },
            ),
            SizedBox(
              height: 10,
            ),
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
                loginData = {
                  'name': loginData['name'],
                  'email': val,
                  'password': loginData['password'],
                  'phone': loginData['phone'],
                  "refralcode": loginData['refralcode']
                };
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                focusNode: passwordFous,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(confirmPasswordFocus);
                },
                style: TextStyle(color: Colors.black),
                onSaved: (val) {
                  loginData = {
                    'name': loginData['name'],
                    'email': loginData['email'],
                    'password': val,
                    'phone': loginData['phone'],
                    "refralcode": loginData['refralcode']
                  };
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                obscureText: true),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              style: TextStyle(color: Colors.black),
              focusNode: confirmPasswordFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(phonefocusenode);
              },
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: phonefocusenode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(refralfocusenode);
              },
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Phone',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              onSaved: (val) {
                loginData = {
                  'name': loginData['name'],
                  'email': loginData['email'],
                  'password': loginData['password'],
                  'phone': val,
                  "refralcode": loginData['refralcode']
                };
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: refralfocusenode,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Refral Code',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              onSaved: (val) {
                loginData = {
                  'name': loginData['name'],
                  'email': loginData['email'],
                  'password': loginData['password'],
                  'phone': loginData['phone'],
                  "refralcode": val
                };
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  child: Text("Sign Up".toUpperCase(),
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
            Text("OR Sign up With".toUpperCase()),
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
                Text('Already have an account'),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Login',
                    style: TextStyle(color: kPrimaryColor),
                    textAlign: TextAlign.left,
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
