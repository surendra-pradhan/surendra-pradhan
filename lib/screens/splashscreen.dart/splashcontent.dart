import 'package:flutter/material.dart';
import 'package:myshop/constant.dart';

import '../../size_config.dart';

class SplashContent extends StatelessWidget {
  final String text, image;

  SplashContent({this.text, this.image});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          "Tokyo",
          style: TextStyle(
            fontSize: getProportionateScreenHeight(35),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(image,
            height: getProportionateScreenHeight(265), width: 235),
      ],
    );
  }
}
