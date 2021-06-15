import 'package:flutter/material.dart';
import 'package:flutter_app1/Providers/ProviderProducts.dart';
import 'package:provider/provider.dart';

import 'widgets/gridItem.dart';

// ignore: must_be_immutable
class GridViewBuild extends StatefulWidget {
  bool fav;
  GridViewBuild(this.fav);

  @override
  _GridViewBuildState createState() => _GridViewBuildState();
}

class _GridViewBuildState extends State<GridViewBuild> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
    print('${widget.fav} in grid view builder');
    final productList = widget.fav ? product.favourite : product.item;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: productList.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: productList[i],
        child: GridItem(),
      ),
    );
  }
}
