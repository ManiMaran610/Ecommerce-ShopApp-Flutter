import 'package:flutter/material.dart';
import 'package:flutter_app1/ProductDetail.dart';
import 'package:flutter_app1/Providers/cart.dart';

import 'package:flutter_app1/modals/Products.dart';
import 'package:provider/provider.dart';

class GridItem extends StatefulWidget {
  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetail.routename, arguments: productList.id);
          },
          child: Image(
            image: NetworkImage(productList.imageUrl),
            fit: BoxFit.fill,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            productList.title,
            textAlign: TextAlign.center,
          ),
          // leading: Consumer<Product>(
          //   builder: (ctx, product, child) =>
          leading: IconButton(
              icon: Icon(
                productList.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                productList.toggleFavorite();
                print(productList.id);
                print(productList.isFavorite);
              }),
          // child: Text(""),

          trailing: IconButton(
              onPressed: () {
                print('clicked');
                print(cart.item.toString());
                cart.additem(
                    productList.id, productList.price, productList.title);
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              )),
        ),
      ),
    );
  }
}
