import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import 'package:myshop/screens/splashscreen.dart/splashscreen.dart';
import 'package:myshop/screens/tabscreen.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'providers/authprovider.dart';

class MianScreen extends StatefulWidget {
  @override
  _MianScreenState createState() => _MianScreenState();
}

class _MianScreenState extends State<MianScreen>
    with AfterLayoutMixin<MianScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => TabScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => SplashScreen()));
    }
  }

  bool _isinit = true;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      Provider.of<Auth>(context).tryAutoLogin();
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }
}
