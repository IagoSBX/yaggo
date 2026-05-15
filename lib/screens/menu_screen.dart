import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/seed_data.dart';
import '../models/product.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_divider.dart';
import '../widgets/app_icons.dart';
import '../widgets/cart_badge.dart';
import '../widgets/logo_text.dart';
import '../widgets/product_card.dart';
import '../widgets/section_heading.dart';
import 'cart_screen.dart';

class MenuScreen extends StatefulWidget {
  final String? initialCategoryId;
  const MenuScreen({super.key, this.initialCategoryId});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late String _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialCategoryId ?? kCategories.first.id;
  }

  List<Product> get _filtered =>
      kProducts.where((p) => p.categoryId == _selectedId).toList();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const LogoText(size: 24),
        centerTitle: false,
        leading: IconButton(
          icon: const AppIcon.back(size: 18, color: AppColors.yellow),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          CartBadge(
            count: provider.cartCount,
            onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const CartScreen())),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppDivider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: SectionHeading(label: 'Escolha seu favorito', title: 'Cardápio'),
          ),
          const SizedBox(height: 20),

          // filtros por categoria
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: kCategories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final cat    = kCategories[i];
                final active = cat.id == _selectedId;
                return GestureDetector(
                  onTap: () => setState(() => _selectedId = cat.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: active ? AppColors.yellow : AppColors.black2,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: active ? AppColors.yellow : AppColors.border),
                    ),
                    child: Text(cat.name,
                        style: AppText.body(13,
                            color: active ? AppColors.black : AppColors.gray,
                            weight: active ? FontWeight.w500 : FontWeight.w400)),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),
          const AppDivider(),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final p = _filtered[i];
                return ProductCard(
                  product: p,
                  inCart:  provider.isInCart(p.id),
                  onAdd: () {
                    provider.addToCart(p);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${p.name} adicionado!'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
