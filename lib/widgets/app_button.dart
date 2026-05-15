import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool fullWidth;
  final bool outlined;
  final double fontSize;
  final EdgeInsets? padding;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.fullWidth = false,
    this.outlined = false,
    this.fontSize = 15,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 28, vertical: 14);

    final child = Text(
      label,
      style: AppText.body(
        fontSize,
        color: outlined ? AppColors.yellow : AppColors.black,
        weight: FontWeight.w500,
      ),
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: outlined
          ? const BorderSide(color: AppColors.yellowBorder)
          : BorderSide.none,
    );

    final btn = outlined
        ? OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.yellow,
              side: const BorderSide(color: AppColors.yellowBorder),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: effectivePadding,
            ),
            child: child,
          )
        : ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.yellow,
              foregroundColor: AppColors.black,
              elevation: 0,
              shape: shape,
              padding: effectivePadding,
            ),
            child: child,
          );

    return fullWidth ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}
