import 'package:bukuta_poultry/models/products.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  List<CartItem> _cart = [];

  void addItemToCart(Product product) {
    List _exists =
        _cart.where((element) => element.name == product.name).toList();
    if (_exists.length > 0) {
      _cart[_cart.indexOf(_exists[0])].count++;
    } else {
      CartItem item = new CartItem(
        name: product.name,
        category: product.category,
        price: product.price,
        count: 1,
      );
      _cart.add(item);
    }

    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }

  get cartItems => _cart;

  double cost() {
    double _cost = 0;
    for (CartItem item in _cart) {
      double total = double.parse(item.price) * item.count;
      _cost += total;
    }
    return _cost;
  }
}

class CartItem {
  String name;
  String category;
  String price;
  int count;
  CartItem({this.name, this.category, this.price, this.count = 0});
}
