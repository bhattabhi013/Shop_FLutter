import 'package:flutter/material.dart';
import 'package:shop_app/widgets/gridview_builder.dart';

class ProductOVerviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
        ),
        body: GridViewBuilder());
  }
}
