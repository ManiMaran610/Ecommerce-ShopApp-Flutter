import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/CartScreen.dart';
import 'package:flutter_app1/ProductDetail.dart';
import 'package:flutter_app1/Providers/ProviderProducts.dart';
import 'package:flutter_app1/Providers/cart.dart';
import 'package:flutter_app1/homepage.dart';
import 'package:provider/provider.dart';

import 'modals/Products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.orangeAccent,
            fontFamily: 'Lato'),
        home: ProductHomeScreen(),
        routes: {
          ProductDetail.routename: (ctx) => ProductDetail(),
          CartScreen.routename: (ctx) => CartScreen()
        },
      ),
    );
  }
}
