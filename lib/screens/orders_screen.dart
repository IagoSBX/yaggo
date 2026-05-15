import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../models/cart_item.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_divider.dart';
import '../widgets/app_icons.dart';
import '../widgets/logo_text.dart';
import '../widgets/section_heading.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<AppProvider>().orders;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const LogoText(size: 24),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppDivider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: SectionHeading(label: 'Histórico', title: 'Meus Pedidos'),
          ),
          Expanded(
            child: orders.isEmpty
                ? _EmptyOrders()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: orders.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => _OrderCard(order: orders[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.receiptOutlined(size: 52, color: AppColors.gray),
          const SizedBox(height: 16),
          Text('Nenhum pedido ainda', style: AppText.body(17, weight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text('Faça seu primeiro pedido!', style: AppText.body(13, color: AppColors.gray)),
          const SizedBox(height: 24),
          AppButton(label: 'Ir ao Cardápio', onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  const _OrderCard({required this.order});

  Color get _statusColor => switch (order.status) {
        OrderStatus.preparing => AppColors.yellow,
        OrderStatus.onTheWay  => AppColors.info,
        OrderStatus.delivered => AppColors.success,
      };

  Color get _statusBg => switch (order.status) {
        OrderStatus.preparing => AppColors.yellowDim,
        OrderStatus.onTheWay  => AppColors.infoDim,
        OrderStatus.delivered => AppColors.successDim,
      };

  Widget get _statusIcon => switch (order.status) {
        OrderStatus.preparing => AppIcon.restaurant(size: 13, color: _statusColor),
        OrderStatus.onTheWay  => AppIcon.delivery(size: 13, color: _statusColor),
        OrderStatus.delivered => AppIcon.check(size: 13, color: _statusColor),
      };

  String get _dateLabel {
    final d   = order.placedAt;
    final now = DateTime.now();
    if (d.day == now.day && d.month == now.month) {
      return 'Hoje às ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    }
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // ── cabeçalho ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pedido #${order.id}', style: AppText.body(14, weight: FontWeight.w500)),
                      const SizedBox(height: 3),
                      Text(_dateLabel, style: AppText.body(12, color: AppColors.gray)),
                      const SizedBox(height: 2),
                      Text(order.address, style: AppText.body(12, color: AppColors.gray),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _statusIcon,
                      const SizedBox(width: 4),
                      Text(order.statusLabel,
                          style: AppText.body(11, color: _statusColor, weight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const AppDivider(),

          // ── itens ────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: order.items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Text('${item.product.emoji}  ', style: const TextStyle(fontSize: 14)),
                    Expanded(child: Text('${item.quantity}x ${item.product.name}', style: AppText.body(13))),
                    Text('R\$ ${item.subtotal.toStringAsFixed(2)}', style: AppText.body(13, color: AppColors.gray)),
                  ],
                ),
              )).toList(),
            ),
          ),

          const AppDivider(),

          // ── total + progresso ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: AppText.body(13, color: AppColors.gray)),
                    Text('R\$ ${order.total.toStringAsFixed(2)}',
                        style: AppText.body(15, color: AppColors.yellow, weight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 16),
                _StatusProgress(status: order.status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusProgress extends StatelessWidget {
  final OrderStatus status;
  const _StatusProgress({required this.status});

  int get _step => switch (status) {
        OrderStatus.preparing => 0,
        OrderStatus.onTheWay  => 1,
        OrderStatus.delivered => 2,
      };

  @override
  Widget build(BuildContext context) {
    const labels     = ['Preparando', 'A caminho', 'Entregue'];
    final stepColors = [AppColors.yellow, AppColors.info, AppColors.success];

    return Row(
      children: List.generate(labels.length * 2 - 1, (i) {
        if (i.isOdd) {
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 2,
              color: _step > i ~/ 2 ? AppColors.yellow : AppColors.border,
            ),
          );
        }
        final ci    = i ~/ 2;
        final done  = _step >= ci;
        final color = done ? stepColors[ci] : AppColors.border;

        return Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: done ? color.withAlpha(40) : AppColors.black3,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 1.5),
              ),
              child: Center(
                child: done
                    ? AppIcon.check(size: 14, color: color)
                    : AppIcon.dot(size: 6, color: AppColors.border),
              ),
            ),
            const SizedBox(height: 4),
            Text(labels[ci], style: AppText.body(9, color: done ? color : AppColors.gray)),
          ],
        );
      }),
    );
  }
}
