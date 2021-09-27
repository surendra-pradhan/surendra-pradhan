import 'package:flutter/material.dart';
import 'package:myshop/models/cartitem.dart';
import 'package:myshop/providers/authprovider.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/screens/auth/loginScreen.dart';
import 'package:myshop/screens/ui/cartscreen/adressScreen.dart';
import 'package:myshop/screens/ui/cartscreen/orderSumery.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routerName = '/cartScreen';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<String, CartItem> cartItem = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Cart>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('My Cart'),
        ),
        body: product.items.values.toList().isEmpty
            ? Center(
                // child: Image.asset(
                //   'assets/images/emptycart.png',
                //   fit: BoxFit.fill,
                //   height: MediaQuery.of(context).size.height * 0.8,
                // ),
                child: Text('Shop Now'),
              )
            : Column(children: [
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                          children: product.items.values
                              .map((e) => OrderSummery(e, ValueKey(e.id)))
                              .toList()

                          // itemBuilder: (context, index) =>
                          //     OrderSummery(product.items.values.toList()[index]),
                          // itemCount: product.items.values.toList().length,
                          ),
                      Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PRICE DETAILS',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Price (${product.itemCount} ${product.itemCount > 1 ? "items" : "item"} )'),
                                  Text('Rs:- ${product.totaAmount}')
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Deliver Charges'),
                                  Text(
                                    "Free",
                                    style: TextStyle(color: Colors.green),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Rs:- ${product.totaAmount}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(4),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Chip(
                          label: Text(
                            '\$${product.totaAmount}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6
                                    .color),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Spacer(),
                        Orderbutton(cart: product)
                      ],
                    ),
                  ),
                ),
              ]));
  }
}

class Orderbutton extends StatefulWidget {
  const Orderbutton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderbuttonState createState() => _OrderbuttonState();
}

class _OrderbuttonState extends State<Orderbutton> {
  var _isLoading = false;
  var _isinit = true;

  @override
  void didChangeDependencies() {
    if (_isinit) {
      Provider.of<Auth>(context).tryAutoLogin();
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final token = Provider.of<Auth>(context, listen: false).authenticate;
          print(token);
          if (token) {
            Navigator.of(context).pushNamed(AddressScreen.routerName);
          } else {
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          }
        },
        child: _isLoading ? CircularProgressIndicator() : Text('Order Now'));
  }
}
