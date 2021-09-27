import 'package:flutter/cupertino.dart';
import 'package:myshop/models/cartitem.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totaAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });

    return total;
  }

  int get itemCount {
    return _items.length;
  }

  increaseProductQuantity(prodId, qty) {
    var prod = _items.values.toList();
    var item = prod.firstWhere((element) => element.id == prodId);

    item.quantity = qty;

    notifyListeners();
  }

  void addItems(String productid, String title, double price, int quantity,
      String imageurl) {
    if (_items.containsKey(productid)) {
      _items.update(
          productid,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1,
              imageUrl: imageurl));
    } else {
      _items.putIfAbsent(
        productid,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1,
            imageUrl: imageurl),
      );
    }

    notifyListeners();
  }

  void removeItem(productid) {
    _items.removeWhere((key, prod) => prod.id == productid);
    notifyListeners();
  }

  void cleracart() {
    _items = {};
    notifyListeners();
  }
}
