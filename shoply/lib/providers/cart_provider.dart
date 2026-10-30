import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int qty;
  CartItem(this.product, this.qty);
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get count => _items.fold(0, (s, i) => s + i.qty);
  double get total => _items.fold(0.0, (s, i) => s + i.product.price * i.qty);

  void add(Product p, [int qty = 1]) {
    final i = _items.indexWhere((e) => e.product.id == p.id);
    if (i >= 0) {
      _items[i].qty += qty;
    } else {
      _items.add(CartItem(p, qty));
    }
    notifyListeners();
  }

  void increment(CartItem item) {
    item.qty++;
    notifyListeners();
  }

  void decrement(CartItem item) {
    if (item.qty > 1) {
      item.qty--;
      notifyListeners();
    }
  }

  void remove(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
