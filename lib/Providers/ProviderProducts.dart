import 'package:flutter/cupertino.dart';
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

  showFav() {
    showFavoritesOnly = true;
    notifyListeners();
  }

  showAll() {
    showFavoritesOnly = false;
    notifyListeners();
  }

  findbyId(String id) {
    return item.firstWhere((element) => element.id == id);
  }
}
