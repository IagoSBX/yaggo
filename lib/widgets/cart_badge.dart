import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'app_icons.dart';

class CartBadge extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const CartBadge({super.key, required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const AppIcon.bagOutlined(size: 22, color: AppColors.yellow),
          onPressed: onTap,
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              width: 17,
              height: 17,
              decoration: const BoxDecoration(
                color: AppColors.yellow,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$count',
                  style: AppText.body(9,
                      color: AppColors.black, weight: FontWeight.w600),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
