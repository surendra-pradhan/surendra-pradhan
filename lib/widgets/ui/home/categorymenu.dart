import 'package:flutter/material.dart';

class CategoryMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _categoryItem(String image, String title) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ClipOval(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(title.toUpperCase())
          ],
        ),
      );
    }

    return Container(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _categoryItem('assets/images/men.jpg', "Men"),
          _categoryItem('assets/images/women.jpg', "Women"),
          _categoryItem('assets/images/kids.jpg', "Kids"),
          _categoryItem('assets/images/footwear.jpg', "Footwear"),
          _categoryItem('assets/images/beauty.jpg', "Beauty"),
          _categoryItem('assets/images/jwellery.jpg', "Jwellery"),
        ],
      ),
    );
  }
}
