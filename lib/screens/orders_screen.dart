import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/app_Drawer.dart';
import 'package:shop_app/widgets/order_item_tile.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = 'order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderList.getOrderItems.length,
        itemBuilder: (context, i) {
          return OrderItemTile(order: orderList.getOrderItems[i]);
        },
      ),
    );
  }
}
