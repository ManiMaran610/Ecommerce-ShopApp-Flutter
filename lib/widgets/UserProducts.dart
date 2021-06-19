import 'package:flutter/material.dart';
import 'package:flutter_app1/EditProducts.dart';
import 'package:flutter_app1/Providers/ProviderProducts.dart';

import 'package:provider/provider.dart';

class UserProducts extends StatelessWidget {
  static const routename = "/userproducts";
  const UserProducts({Key? key}) : super(key: key);

  Future<void> _refreshIndicator(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<Products>(context);
    final products = productList.item;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditScreen.routename,
                );
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _refreshIndicator(context);
        },
        child: ListView.builder(
            itemCount: productList.item.length,
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
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.of(context).pushNamed(
                      //           EditScreen.routename,
                      //           arguments: products[i].id);
                      //     },
                      //     icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            productList.deleteItem(products[i].id);
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
