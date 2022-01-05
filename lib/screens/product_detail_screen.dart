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
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 300,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Price: Rs. ${product.price}',
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              product.title,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ]),
      ),
    );
  }
}
