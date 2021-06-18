import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_app1/modals/Products.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://banner2.cleanpng.com/20180920/lt/kisspng-t-shirt-clothing-hoodie-fanatics-foto-kim-hyung-joong-sebelum-operasi-plastik-5ba32705a202a2.0533801515374190136636.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://t3.ftcdn.net/jpg/02/36/92/96/360_F_236929627_4EwLazU8s67jgquQ0DoNCXLg7oPKOvpI.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Rain Court',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://img.favpng.com/6/0/20/rain-cartoon-png-favpng-RWpzmN8zvKKp0iXL3H5Ps95Am.jpg',
    ),
    Product(
        id: 'p4',
        title: 'Modern Elegance',
        description: 'Prepare any meal you want.',
        price: 49.99,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0JaKE3rsEeEaAnayoOeTQ0UTgBaMH5qvM7BZfj5somDWMMkTSPGElEJoRCWTKLKA1NPY&usqp=CAU'),
  ];
  var showFavoritesOnly = false;

  List<Product> get item {
    // if (showFavoritesOnly) {
    //   return _items.where((element) => element.isFavorite == true).toList();
    // }
    return [..._items];
  }

  List<Product> get favourite {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  Future<void> addproducts(Product product) {
    const url =
        'https://email-authentication-74444.firebaseio.com/Products.json';
    return http
        .post(Uri.parse(url),
            body: json.encode({
              'title': product.title,
              'price': product.price,
              'discription': product.description,
              'imageUrl': product.imageUrl,
            }))
        .then((response) {
      // dynamic res = json.decode(response.body);

      final newProduct = Product(
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          id: json.decode(response.body)['name']);
      _items.add(newProduct);
      notifyListeners();

      // print(json.decode(response.body)['title']);
    });
  }

  void deleteItem(String productId) {
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

  findbyId(String id) {
    return item.firstWhere((element) => element.id == id);
  }

  void updateProduct(String id, Product newProduct) {
    if (_items.contains(id)) {
      final prodIndex = _items.indexWhere((prod) => prod.id == id);
      if (prodIndex >= 0) {
        _items[prodIndex] = newProduct;
        notifyListeners();
      } else {
        print('...');
      }
    }
  }
}
