import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItemTile extends StatelessWidget {
  final String id;
  final int quantity;
  final String prodtitle;
  final double price;

  CartItemTile(
      {required this.id,
      required this.quantity,
      required this.prodtitle,
      required this.price});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(id);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text("Do you want to remove item?"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('No')),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Yes')),
                  ],
                ));
      },
      background: Container(
        color: Colors.white,
        child: const Icon(
          Icons.delete,
          color: Colors.red,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: FittedBox(
              fit: BoxFit.contain,
              child: CircleAvatar(
                minRadius: 40,
                child: Text('Rs. $price'),
              ),
            ),
            title: Text(prodtitle),
            subtitle: Text('Total : ${quantity * price}'),
            trailing: Text(' x $quantity'),
          ),
        ),
      ),
    );
  }
}
