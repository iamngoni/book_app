import 'dart:convert';

import 'package:bukuta_poultry/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductsController extends ChangeNotifier {
  List<Product> productList = [];
  List<Product> popular = [];

  init() async {
    var jsn = await rootBundle.loadString("assets/products/products.json");
    var jsnPp = await rootBundle.loadString("assets/products/popular.json");
    List data = json.decode(jsn);
    List dataPP = json.decode(jsnPp);
    for (int i = 0; i < data.length; i++) {
      this.productList.add(Product.fromJson(data[i]));
      notifyListeners();
    }

    for (int i = 0; i < dataPP.length; i++) {
      this.popular.add(Product.fromJson(dataPP[i]));
      notifyListeners();
    }
  }

  productByName(String name) {
    List<Product> _product = this
        .productList
        .where((Product element) => element.name == name)
        .toList();
    return _product[0];
  }
}
