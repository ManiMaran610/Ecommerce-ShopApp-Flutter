import 'package:flutter/material.dart';
import 'package:flutter_app1/EditProducts.dart';
import 'package:flutter_app1/Providers/ProviderProducts.dart';

import 'package:provider/provider.dart';

class UserProducts extends StatelessWidget {
  static const routename = "/userproducts";
  const UserProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList = Provider.of<Products>(context);
    final products = ProductList.item;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditScreen.routename, arguments: '');
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: ListView.builder(
          itemCount: ProductList.item.length,
          itemBuilder: (ctx, i) {
            return Container(
              height: 75,
              child: Card(
                margin: EdgeInsets.all(6.0),
                elevation: 15,
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Image(image: NetworkImage(products[i].imageUrl)),
                    ),
                    SizedBox(width: 25),
                    Text(products[i].title),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(EditScreen.routename,
                              arguments: products[i].id);
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          ProductList.deleteItem(products[i].id);
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
