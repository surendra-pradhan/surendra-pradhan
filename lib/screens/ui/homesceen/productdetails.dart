import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/product.dart';
import 'package:myshop/screens/ui/cartscreen/cartscreen.dart';

import 'package:myshop/themes/light_color.dart';
import 'package:myshop/widgets/badge.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  static const routerName = '/ProductDetailPage';

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  var products = {};
  List<String> images = [];
  Widget buildSizeButton({title, isSeleted}) {
    return MaterialButton(
      height: 40,
      minWidth: 40,
      elevation: 0,
      color: isSeleted ? Color(0xff8f7fc4) : Color(0xffe8e8e8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSeleted ? Colors.white : Color(0xff727274),
          ),
        ),
      ),
      onPressed: () {},
    );
  }

  @override
  void initState() {
    // images.add(products['product_img']);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final id = ModalRoute.of(context).settings.arguments as String;
    Provider.of<Products>(context, listen: false).fetchSingleProduct(id);
    products = Provider.of<Products>(context, listen: false).product;
    print(products['product_img']);
    images.add(products['product_img']);
    super.didChangeDependencies();
  }

  Widget _productImage() {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          scrollPhysics: ScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          height: 300,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        items: images
            .map(
              (e) => Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffb2adca).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10.0,
                      offset: -Offset(0, 3),
                    )
                  ],
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(e),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back,
                            color: Color(0xffae9fe0),
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) => Consumer<Cart>(
                          builder: (_, cart, ch) => Badge(
                              child: ch, value: cart.itemCount.toString()),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                icon: Icon(
                                  Icons.shopping_bag_rounded,
                                  color: Theme.of(context).accentColor,
                                ),
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(CartScreen.routerName)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _productDetials() {
    return DraggableScrollableSheet(
        maxChildSize: .63,
        initialChildSize: .55,
        minChildSize: .55,
        builder: (context, scrollController) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white),
              child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 5),
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                              color: LightColor.iconColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${products['product_name']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff39393b),
                                  ),
                                ),
                                Text(
                                  'RS:- ${products['product_price']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff39393b),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              '${products['product_name']}',
                              style: TextStyle(
                                color: Color(0xff979797),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Choose Size",
                                  style: TextStyle(
                                    color: Color(0xff979797),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Color(0xffac9ddd),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    buildSizeButton(
                                      title: "S",
                                      isSeleted: false,
                                    ),
                                    buildSizeButton(
                                      title: "M",
                                      isSeleted: false,
                                    ),
                                    buildSizeButton(
                                      title: "L",
                                      isSeleted: true,
                                    ),
                                    buildSizeButton(
                                      title: "XL",
                                      isSeleted: false,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Color(0xff317aaf),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Color(0xfff19a9c),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Description"),
                                    Container(
                                      width: 50,
                                      child: Divider(
                                          thickness: 3,
                                          color: Color(0xff6b648f)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Delivery"),
                                    Container(
                                      width: 50,
                                      child: Divider(
                                          thickness: 3,
                                          color: Colors.transparent),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Reviews"),
                                    Container(
                                      width: 50,
                                      child: Divider(
                                        thickness: 3,
                                        color: Colors.transparent,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${products["product_details"]}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffb2b2b2),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "relaxed,occasinal and suited fir everyday use.",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffb2b2b2),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  )));
        });
  }

  Widget _buyButtonHandler() {
    return MaterialButton(
      onPressed: () {
        Provider.of<Cart>(context, listen: false).addItems(
            products['product_id'],
            products['product_name'],
            double.parse(products['product_price']),
            products['quantity'],
            products['product_img']);
      },
      height: 50,
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff9f91cc),
              Color(0xff8471bb),
            ],
          ),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            "Add to Cart\t\t\t\ ${products['product_price']}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: _flotingButton(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xfffbfbfb),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              _productImage(),
              _productDetials(),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: _buyButtonHandler())
            ],
          ),
        ),
      ),
    );
  }
}
