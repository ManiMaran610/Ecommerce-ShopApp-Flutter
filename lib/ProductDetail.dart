import 'package:flutter/material.dart';
import 'package:flutter_app1/Providers/ProviderProducts.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  static const routename = "/ProductDetail";
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final products = Provider.of<Products>(context);
    final productList = products.findbyId(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(productList.title),
      ),
    );
  }
}
