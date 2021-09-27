import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List _products = [];

  List get products {
    return [..._products];
  }

  Map _product = {};

  get product {
    return {..._product};
  }

  void fetchSingleProduct(id) {
    print(id);
    // return _products.firstWhere((element) => element.id == id);
    _product = _products.firstWhere((prod) => prod['product_id'] == id);
  }

  Future<void> fetchAndSetPrdocuts() async {
    try {
      final url = Uri.parse(
          'https://capsodisha.com/phoenixKart/sapi312/webservice.php?method=getProductList');

      final response = await http.post(url);
      final responsedata = jsonDecode(response.body) as List;
      _products = responsedata;
      // responsedata.forEach((element) {
      //   _products.add({
      //     'product_id': element['product_id'],
      //     'product_img': element['product_img'],
      //     'product_name': element['product_name'],
      //     'product_price': element['product_price'],
      //     'final_prd_price': element['final_prd_price'],
      //     'rattig': 4,
      //     'quantity': 1,
      //     'product_details': element['product_details'],
      //   });
      // });
      // print('res => {$responsedata}');
      // print(_products);
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}
