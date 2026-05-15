import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import 'app_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool inCart;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.product,
    required this.inCart,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Imagem do produto ─────────────────────────────────────────
          Stack(
            children: [
              Container(
                color: const Color(0xFF0E0E00),
                child: AppImage.product(
                  imagePath: product.imagePath,
                  fallbackEmoji: product.emoji,
                ),
              ),
              if (product.isPopular)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Popular',
                        style: AppText.body(10,
                            color: AppColors.black, weight: FontWeight.w500)),
                  ),
                ),
            ],
          ),

          // ── Info ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: AppText.body(15, weight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(product.description,
                    style: AppText.body(12, color: AppColors.gray),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('R\$ ${product.price.toStringAsFixed(2)}',
                        style: AppText.body(17,
                            color: AppColors.yellow, weight: FontWeight.w500)),
                    GestureDetector(
                      onTap: onAdd,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: inCart ? AppColors.yellowDim : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.yellowBorder),
                        ),
                        child: Text(
                          inCart ? '✓ Adicionado' : '+ Adicionar',
                          style: AppText.body(12, color: AppColors.yellow),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
