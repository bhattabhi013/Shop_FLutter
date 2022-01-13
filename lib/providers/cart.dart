import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get getItemCount {
    return _items.length;
  }

  double get getTotalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void removeItem(String id) {
    print(id);
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id]!.quantity > 1) {
      _items.update(id, (existingItem) {
        return CartItem(
            id: existingItem.id,
            title: existingItem.title,
            quantity: existingItem.quantity - 1,
            price: existingItem.price);
      });
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void addItem(String id, String itemTitle, double price) {
    if (_items.containsKey(id)) {
      _items.update(id, (prod) {
        return CartItem(
            id: id,
            title: itemTitle,
            quantity: prod.quantity + 1,
            price: price);
      });
    } else {
      _items.putIfAbsent(id, () {
        return CartItem(
            id: DateTime.now().toString(),
            title: itemTitle,
            price: price,
            quantity: 1);
      });
    }
    notifyListeners();
  }
}
