import 'package:flutter/foundation.dart';

class cartItem with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final int quantity;

  cartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, cartItem> _items = {};

  Map<String, cartItem> get item {
    return {..._items};
  }

  int get itemcount {
    return _items.length;
  }

  double get totalamount {
    var t = 0.0;
    _items.forEach((key, cartItem) {
      t += cartItem.price * cartItem.quantity;
    });
    return t;
  }

  void additem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (exsistingvalue) => cartItem(
              id: exsistingvalue.id,
              title: exsistingvalue.title,
              price: exsistingvalue.price,
              quantity: exsistingvalue.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => cartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }
}
