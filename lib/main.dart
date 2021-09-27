import 'package:flutter/material.dart';
import 'package:myshop/mainscreen.dart';
import 'package:myshop/providers/authprovider.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/product.dart';
import 'package:myshop/router.dart';

import 'package:myshop/theme.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: MaterialApp(
        theme: theme(),
        home: MianScreen(),
        routes: routes,
      ),
    );
  }
}
