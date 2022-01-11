import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = 'cart-screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(), // takes all the available space
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      'Rs.${cart.getTotalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        Provider.of<Order>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.getTotalAmount);
                        cart.clearCart();
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, i) {
                return CartItemTile(
                  id: cart.items.keys.toList()[i],
                  quantity: cart.items.values.toList()[i].quantity,
                  price: cart.items.values.toList()[i].price,
                  prodtitle: cart.items.values.toList()[i].title,
                );
              },
              itemCount: cart.getItemCount,
            ),
          ),
        ],
      ),
    );
  }
}
