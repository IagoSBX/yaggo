import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_divider.dart';
import '../widgets/app_icons.dart';
import '../widgets/app_image.dart';
import '../widgets/logo_text.dart';
import '../widgets/section_heading.dart';
import 'checkout_screen.dart';

const double kDeliveryFee = 5.99;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final items    = provider.cartItems;
    final subtotal = provider.cartSubtotal;
    final total    = subtotal + kDeliveryFee;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const LogoText(size: 24),
        centerTitle: false,
        leading: IconButton(
          icon: const AppIcon.back(size: 18, color: AppColors.yellow),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const AppDivider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: SectionHeading(label: 'Seus itens', title: 'Carrinho'),
          ),
          Expanded(
            child: items.isEmpty
                ? _EmptyCart()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final item = items[i];
                      return _CartTile(
                        item: item,
                        onIncrement: () => provider.increment(item.product.id),
                        onDecrement: () => provider.decrement(item.product.id),
                        onRemove:    () => provider.removeFromCart(item.product.id),
                      );
                    },
                  ),
          ),
          if (items.isNotEmpty)
            _CartSummary(
              subtotal: subtotal,
              delivery: kDeliveryFee,
              total:    total,
              onCheckout: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CheckoutScreen(
                    subtotal:    subtotal,
                    deliveryFee: kDeliveryFee,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty state
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.bagOutlined(size: 56, color: AppColors.gray),
          const SizedBox(height: 16),
          Text('Carrinho vazio', style: AppText.body(17, weight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text('Adicione itens do cardápio', style: AppText.body(13, color: AppColors.gray)),
          const SizedBox(height: 24),
          AppButton(label: 'Ver Cardápio', onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Cart item tile
// ─────────────────────────────────────────────────────────────────────────────

class _CartTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const _CartTile({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // ── THUMBNAIL DO PRODUTO ───────────────────────────────────────────
          // Para exibir imagem real, passe assetPath:
          //   AppImage.thumb(
          //     assetPath: 'assets/images/${item.product.id}.jpg',
          //     fallbackEmoji: item.product.emoji,
          //   )
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AppImage.thumb(
              imagePath: item.product.imagePath,
              fallbackEmoji: item.product.emoji,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name,
                    style: AppText.body(14, weight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text('R\$ ${item.product.price.toStringAsFixed(2)} / un.',
                    style: AppText.body(12, color: AppColors.gray)),
              ],
            ),
          ),

          _QtyControl(qty: item.quantity, onInc: onIncrement, onDec: onDecrement),
          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('R\$ ${item.subtotal.toStringAsFixed(2)}',
                  style: AppText.body(14, color: AppColors.yellow, weight: FontWeight.w500)),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: onRemove,
                child: const AppIcon.delete(size: 18, color: AppColors.gray),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Qty control
// ─────────────────────────────────────────────────────────────────────────────

class _QtyControl extends StatelessWidget {
  final int qty;
  final VoidCallback onInc;
  final VoidCallback onDec;

  const _QtyControl({required this.qty, required this.onInc, required this.onDec});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _QtyBtn(icon: const AppIcon.minus(size: 16, color: AppColors.yellow), onTap: onDec),
          SizedBox(
            width: 28,
            child: Text('$qty',
                textAlign: TextAlign.center,
                style: AppText.body(14, weight: FontWeight.w500)),
          ),
          _QtyBtn(icon: const AppIcon.plus(size: 16, color: AppColors.yellow), onTap: onInc),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: icon,
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Cart summary
// ─────────────────────────────────────────────────────────────────────────────

class _CartSummary extends StatelessWidget {
  final double subtotal, delivery, total;
  final VoidCallback onCheckout;

  const _CartSummary({
    required this.subtotal,
    required this.delivery,
    required this.total,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: const BoxDecoration(
        color: AppColors.black2,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          _Row('Subtotal', subtotal),
          const SizedBox(height: 6),
          _Row('Entrega', delivery),
          const SizedBox(height: 10),
          const AppDivider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppText.body(15, weight: FontWeight.w500)),
              Text('R\$ ${total.toStringAsFixed(2)}',
                  style: AppText.body(16, color: AppColors.yellow, weight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 16),
          AppButton(label: 'Finalizar Pedido', fullWidth: true, onTap: onCheckout),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final double value;
  const _Row(this.label, this.value);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppText.body(13, color: AppColors.gray)),
          Text('R\$ ${value.toStringAsFixed(2)}',
              style: AppText.body(13, color: AppColors.gray)),
        ],
      );
}
