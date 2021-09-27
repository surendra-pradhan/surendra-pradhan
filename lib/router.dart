import 'package:flutter/material.dart';
import 'package:myshop/screens/auth/signupScreen.dart';
import 'package:myshop/screens/tabscreen.dart';
import 'package:myshop/screens/ui/cartscreen/adressScreen.dart';
import 'package:myshop/screens/ui/cartscreen/cartscreen.dart';
import 'package:myshop/screens/ui/homesceen/productdetails.dart';
import './screens/auth/loginScreen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (ctx) => LoginScreen(),
  SignUpScreen.routerName: (ctx) => SignUpScreen(),
  TabScreen.routerNmae: (ctx) => TabScreen(),
  ProductDetailPage.routerName: (ctx) => ProductDetailPage(),
  CartScreen.routerName: (ctx) => CartScreen(),
  AddressScreen.routerName: (ctx) => AddressScreen()
};
