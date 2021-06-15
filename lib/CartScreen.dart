import 'package:flutter/material.dart';
import 'package:flutter_app1/widgets/cart_item.dart';
import 'package:provider/provider.dart';

import 'Providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const routename = "/cartScreen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Total"),
                ),
                SizedBox(width: 20),
                Chip(
                  label: Text(
                    '\$${cart.totalamount}',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.orange,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cart.itemcount,
                  itemBuilder: (ctx, i) {
                    return CartItem(
                        cart.item.values.toList()[i].id,
                        cart.item.keys.toList()[i].toString(),
                        cart.item.values.toList()[i].price,
                        cart.item.values.toList()[i].quantity,
                        cart.item.values.toList()[i].title);
                  }))
        ],
      ),
    );
  }
}
