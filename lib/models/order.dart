import 'cart_item.dart';

enum OrderStatus { preparing, onTheWay, delivered }

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime placedAt;
  final String address;
  OrderStatus status;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.placedAt,
    required this.address,
    this.status = OrderStatus.preparing,
  });

  String get statusLabel => switch (status) {
        OrderStatus.preparing => 'Preparando',
        OrderStatus.onTheWay  => 'A caminho',
        OrderStatus.delivered => 'Entregue',
      };
}
