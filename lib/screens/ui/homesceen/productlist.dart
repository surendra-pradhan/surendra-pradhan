import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myshop/providers/product.dart';

import 'package:myshop/screens/ui/homesceen/productdetails.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool isinit = true;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<Products>(context, listen: false).fetchAndSetPrdocuts(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: isloading
                  ? Container(child: Center(child: CircularProgressIndicator()))
                  : Consumer<Products>(
                      builder: (ctx, prod, _) => Container(
                        padding: EdgeInsets.only(bottom: 15),
                        child: StaggeredGridView.countBuilder(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 4,
                          itemCount: prod.products.length,
                          itemBuilder: (BuildContext context, int index) =>
                              new Container(
                            child: GestureDetector(
                                onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: ProductDetailPage.routerName,
                                          arguments: prod.products[index]
                                              ['product_id']),
                                      screen: ProductDetailPage(),
                                      withNavBar: false,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    ),
                                child:
                                    productCard(prod.products[index], context)),
                          ),
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(
                                  2, index.isEven ? 3.2 : 2.8),
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                        ),
                      ),
                    )),
    );
  }

  Widget productCard(product, ctx) {
    return Container(
        child: Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              product['product_img'],
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          product['product_name'],
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: Colors.black),
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${product['product_price']}',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(color: Colors.black),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '${product['final_prd_price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.purple,
                  color: Colors.grey),
            ),
          ],
        )
      ],
    ));
  }
}
