import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/orders.dart';

class OrderItemTile extends StatefulWidget {
  const OrderItemTile({required this.order});
  final OrderItem order;

  @override
  State<OrderItemTile> createState() => _OrderItemTileState();
}

class _OrderItemTileState extends State<OrderItemTile> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Rs. ${widget.order.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_more : Icons.expand_less),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              Container(
                padding: const EdgeInsets.all(10),
                height: min(widget.order.products.length * 20 + 100, 100),
                child: ListView(
                    children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'x ${product.quantity} Rs. ${product.price}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                      )
                    ],
                  );
                }).toList()),
              )
          ],
        ),
      ),
    );
  }
}
