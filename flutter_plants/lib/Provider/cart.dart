import 'package:flutter/material.dart';
import 'package:flutter_plants/model/items.dart';

class Cart with ChangeNotifier {
  List selectedproducts = [];
  double price = 0;
  add(Item product) {
    selectedproducts.add(product);
    price += product.price.round();
    notifyListeners();
  }

  delete(Item product) {
    selectedproducts.remove(product);
     price -= product.price.round();
     notifyListeners();
  }
}
