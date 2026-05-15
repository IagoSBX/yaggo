import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Widget de imagem com fallback para emoji.
/// Usa Image.asset quando imagePath está definido,
/// ou exibe o emoji centralizado caso contrário.
class AppImage extends StatelessWidget {
  final String? imagePath;
  final String fallbackEmoji;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const AppImage({
    super.key,
    this.imagePath,
    required this.fallbackEmoji,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.borderRadius,
  });

  /// Card do cardápio — área de imagem maior
  const AppImage.product({
    super.key,
    required this.imagePath,
    required this.fallbackEmoji,
  })  : width = double.infinity,
        height = 160,
        fit = BoxFit.contain,
        borderRadius = null;

  /// Thumbnail pequeno — carrinho, pedidos, checkout
  const AppImage.thumb({
    super.key,
    required this.imagePath,
    required this.fallbackEmoji,
  })  : width = 62,
        height = 62,
        fit = BoxFit.contain,
        borderRadius = const BorderRadius.all(Radius.circular(10));

  /// Imagem circular no carrossel da home
  const AppImage.hero({
    super.key,
    required this.imagePath,
    required this.fallbackEmoji,
  })  : width = double.infinity,
        height = double.infinity,
        fit = BoxFit.contain,
        borderRadius = null;

  /// Ícone de categoria (grid home)
  const AppImage.category({
    super.key,
    required this.imagePath,
    required this.fallbackEmoji,
  })  : width = 36,
        height = 36,
        fit = BoxFit.contain,
        borderRadius = const BorderRadius.all(Radius.circular(8));

  @override
  Widget build(BuildContext context) {
    Widget img;

    if (imagePath != null) {
      img = Image.asset(
        imagePath!,
        width: width == double.infinity ? null : width,
        height: height == double.infinity ? null : height,
        fit: fit,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    } else {
      img = _placeholder();
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: img);
    }
    return img;
  }

  Widget _placeholder() {
    final isSmall = height != null &&
        height != double.infinity &&
        (height! <= 70);

    return Container(
      width: width == double.infinity ? null : width,
      height: height == double.infinity ? null : height,
      color: const Color(0xFF0E0E00),
      child: Center(
        child: Text(
          fallbackEmoji,
          style: TextStyle(fontSize: isSmall ? 24 : 52),
        ),
      ),
    );
  }
}
