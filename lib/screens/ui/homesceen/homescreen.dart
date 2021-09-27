import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart';

import 'package:myshop/screens/ui/homesceen/productlist.dart';
import 'package:myshop/widgets/badge.dart';

import 'package:provider/provider.dart';
import '/widgets/ui/home/categorymenu.dart';
import '/widgets/ui/home/header.dart';

import '/widgets/ui/home/searchSection.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(),
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(
            Icons.sort_outlined,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => scaffoldKey.currentState.openDrawer(),
        ),

        actions: [
          Builder(
            builder: (context) => Consumer<Cart>(
              builder: (_, cart, ch) =>
                  Badge(child: ch, value: cart.itemCount.toString()),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_bag_rounded,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ),
        ],

        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: FaIcon(
        //       FontAwesomeIcons.shoppingBag,
        //       color: Theme.of(context).accentColor,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Header(),
              CategoryMenu(),
              SearchSection(),
              Expanded(child: ProductList())
            ],
          ),
        ),
      ),
    );
  }
}
