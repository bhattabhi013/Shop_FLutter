import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_Drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-product-screen';
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      drawer: const AppDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
            itemCount: productsData.productList.length,
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  UserProductItem(
                    title: productsData.productList[i].title,
                    imageUrl: productsData.productList[i].imageUrl,
                    id: productsData.productList[i].id,
                  ),
                  const Divider(),
                ],
              );
            }),
      ),
    );
  }
}
