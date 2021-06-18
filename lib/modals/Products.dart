import 'package:flutter/widgets.dart';

class Product with ChangeNotifier {
  dynamic id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite = false;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.id,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
