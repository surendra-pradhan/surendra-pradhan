import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Discover",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Explore Our New Colections"),
      trailing: TextButton.icon(
        onPressed: () {},
        label: Text(
          'Sort By',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        icon: Icon(
          Icons.expand_more_outlined,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
