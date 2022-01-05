import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import '../providers/products_provider.dart';
import 'product_item.dart';

class GridViewBuilder extends StatelessWidget {
  final bool showOnlyFavourites;

  const GridViewBuilder({required this.showOnlyFavourites});
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final productList =
        showOnlyFavourites ? productData.favtProdList : productData.productList;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: productList.length,
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider<Product>.value(
              // create: (context) => productList[i],
              value: productList[i],
              child: ProductItem(
                  // id: productList[i].id,
                  // imageUrl: productList[i].imageUrl,
                  // title: productList[i].title,
                  // price: productList[i].price,
                  ));
        });
  }
}
