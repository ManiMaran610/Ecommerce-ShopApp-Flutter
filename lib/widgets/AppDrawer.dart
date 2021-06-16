import 'package:flutter/material.dart';
import 'package:flutter_app1/widgets/UserProducts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.shop_rounded),
            title: Text('User Products'),
            onTap: () {
              Navigator.of(context).pushNamed(UserProducts.routename);
            },
          ),
        ),
      ],
    ));
  }
}
