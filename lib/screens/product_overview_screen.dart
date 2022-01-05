import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_Drawer.dart';
import 'package:shop_app/widgets/badge.dart';

import 'package:shop_app/widgets/gridview_builder.dart';

enum filterOptions { favourites, all }

class ProductOVerviewScreen extends StatefulWidget {
  @override
  State<ProductOVerviewScreen> createState() => _ProductOVerviewScreenState();
}

class _ProductOVerviewScreenState extends State<ProductOVerviewScreen> {
  bool _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (filterOptions val) {
                setState(() {
                  if (val == filterOptions.favourites) {
                    _showOnlyFavourites = true;
                  } else {
                    _showOnlyFavourites = false;
                  }
                });
              },
              itemBuilder: (ctx) {
                return [
                  const PopupMenuItem(
                      child: const Text('Favourites'),
                      value: filterOptions.favourites),
                  const PopupMenuItem(
                      child: Text('Show All'), value: filterOptions.all),
                ];
              },
            ),
            Consumer<Cart>(
              builder: (context, cart, ch) => Badge(
                child: ch as Widget,
                value: cart.getItemCount.toString(),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: GridViewBuilder(
          showOnlyFavourites: _showOnlyFavourites,
        ));
  }
}
