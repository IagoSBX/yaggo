import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import '../models/product.dart';

class AppProvider extends ChangeNotifier {
  // ─── Cart ──────────────────────────────────────────────────────────────────
  final List<CartItem> _cart = [];

  List<CartItem> get cartItems => List.unmodifiable(_cart);

  int get cartCount => _cart.fold(0, (sum, item) => sum + item.quantity);

  double get cartSubtotal => _cart.fold(0, (sum, item) => sum + item.subtotal);

  bool isInCart(String productId) =>
      _cart.any((i) => i.product.id == productId);

  int quantityOf(String productId) {
    final idx = _cart.indexWhere((i) => i.product.id == productId);
    return idx >= 0 ? _cart[idx].quantity : 0;
  }

  void addToCart(Product product) {
    final idx = _cart.indexWhere((i) => i.product.id == product.id);
    if (idx >= 0) {
      _cart[idx].quantity++;
    } else {
      _cart.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void increment(String productId) {
    final idx = _cart.indexWhere((i) => i.product.id == productId);
    if (idx >= 0) {
      _cart[idx].quantity++;
      notifyListeners();
    }
  }

  void decrement(String productId) {
    final idx = _cart.indexWhere((i) => i.product.id == productId);
    if (idx < 0) return;
    if (_cart[idx].quantity <= 1) {
      _cart.removeAt(idx);
    } else {
      _cart[idx].quantity--;
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cart.removeWhere((i) => i.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // ─── Orders ────────────────────────────────────────────────────────────────
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders.reversed.toList());

  Order placeOrder({required String address}) {
    final order = Order(
      id: 'YG${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}',
      items: _cart
          .map((i) => CartItem(product: i.product, quantity: i.quantity))
          .toList(),
      total: cartSubtotal + 5.99,
      placedAt: DateTime.now(),
      address: address,
    );

    _orders.add(order);
    clearCart();

    // simula progressão automática do pedido
    Future.delayed(const Duration(seconds: 10), () {
      order.status = OrderStatus.onTheWay;
      notifyListeners();
    });
    Future.delayed(const Duration(seconds: 25), () {
      order.status = OrderStatus.delivered;
      notifyListeners();
    });

    return order;
  }
}
