import 'package:flutter/material.dart';
import 'package:myshop/screens/splashscreen.dart/splashscrenarea.dart';

import '../../size_config.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().createscreensizes(context);
    return Scaffold(
      body: SplashscreenArea(),
    );
  }
}
