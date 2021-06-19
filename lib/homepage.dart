import 'package:flutter/material.dart';
import 'package:flutter_app1/CartScreen.dart';

import 'package:flutter_app1/GridviewBuilder.dart';
import 'package:flutter_app1/Providers/cart.dart';
import 'package:flutter_app1/widgets/AppDrawer.dart';
import 'package:flutter_app1/widgets/badge.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import 'Providers/ProviderProducts.dart';

class ProductHomeScreen extends StatefulWidget {
  bool showFav = false;

  @override
  _ProductHomeScreenState createState() => _ProductHomeScreenState();
}

enum FilterOptions { favourite, showall }

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  var isInit = true;
  var isLoading = false;
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context).fetchData().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop App"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedvalue) {
              setState(() {
                if (selectedvalue == FilterOptions.favourite) {
                  print('favourites');
                  widget.showFav = true;
                  print('setstate true');
                } else {
                  widget.showFav = false;
                  print('setstate false');
                }
              });
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                  child: Text('only Favouries'),
                  value: FilterOptions.favourite),
              PopupMenuItem(
                  child: Text('Show All'), value: FilterOptions.showall),
            ],
          ),
          Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routename);
                },
              ),
              value: cartItem.itemcount.toString(),
              color: Colors.red)
        ],
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? Center(
              child: Container(
              height: 155,
              child: Lottie.network(
                  'https://assets3.lottiefiles.com/packages/lf20_ObshHL.json'),
            ))
          : GridViewBuild(widget.showFav),
    );
  }
}
