// ignore_for_file: unused_local_variable
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "detail-screen";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final productData = Provider.of<Products>(context, listen: false);
    final product = productData.findProduct(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
