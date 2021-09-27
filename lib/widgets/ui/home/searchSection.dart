import 'package:flutter/material.dart';

class SearchSection extends StatefulWidget {
  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              color: Theme.of(context).accentColor,
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
            hintText: 'Search For Products',
            labelStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
