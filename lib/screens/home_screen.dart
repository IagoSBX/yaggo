import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/seed_data.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_divider.dart';
import '../widgets/app_icons.dart';
import '../widgets/app_image.dart';
import '../widgets/cart_badge.dart';
import '../widgets/logo_text.dart';
import '../widgets/product_card.dart';
import '../widgets/section_heading.dart';
import 'cart_screen.dart';
import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageCtrl = PageController();
  int _currentSlide = 0;

  // Cada slide aponta para uma imagem real de produto
  static const _slides = [
    _SlideData(
      headline: 'Feito pra\nincomodar\na fome.',
      sub: 'Blend exclusivo e muito molho.',
      imagePath: 'assets/images/smash_classico.png',
      fallback: '🍔',
    ),
    _SlideData(
      headline: 'Combos\nirresistíveis',
      sub: 'Burger + fritas + bebida com preço especial.',
      imagePath: 'assets/images/combo_classico.png',
      fallback: '🍟',
    ),
    _SlideData(
      headline: 'Sobremesas\npra finalizar',
      sub: 'Brownies e sorvetes artesanais.',
      imagePath: 'assets/images/brownie_quente.png',
      fallback: '🍫',
    ),
  ];

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _goToCart() => Navigator.push(
      context, MaterialPageRoute(builder: (_) => const CartScreen()));

  void _goToMenu({String? categoryId}) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => MenuScreen(initialCategoryId: categoryId)));

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const LogoText(size: 26),
        centerTitle: false,
        actions: [
          CartBadge(count: provider.cartCount, onTap: _goToCart),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppDivider(),
            _buildCarousel(),
            const AppDivider(),
            const SizedBox(height: 28),

            // ── Categorias ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeading(label: 'O que temos', title: 'Categorias'),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: kCategories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.6,
                    ),
                    itemBuilder: (_, i) {
                      final cat = kCategories[i];
                      // Usa o primeiro produto da categoria como ícone
                      final rep = kProducts
                          .firstWhere((p) => p.categoryId == cat.id);
                      return _CategoryCard(
                        name: cat.name,
                        subtitle: cat.subtitle,
                        imagePath: rep.imagePath,
                        fallback: rep.emoji,
                        onTap: () => _goToMenu(categoryId: cat.id),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const AppDivider(),
            const SizedBox(height: 28),

            // ── Mais pedidos ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeading(label: 'Destaque', title: 'Mais Pedidos'),
                  const SizedBox(height: 16),
                  ...kProducts.where((p) => p.isPopular).map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ProductCard(
                        product: p,
                        inCart: provider.isInCart(p.id),
                        onAdd: () => provider.addToCart(p),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppButton(
                label: 'Ver Cardápio Completo',
                fullWidth: true,
                onTap: _goToMenu,
              ),
            ),
            const SizedBox(height: 32),
            const _Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageCtrl,
            itemCount: _slides.length,
            onPageChanged: (i) => setState(() => _currentSlide = i),
            itemBuilder: (_, i) =>
                _SlideWidget(data: _slides[i], onCta: _goToMenu),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _slides.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == _currentSlide ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == _currentSlide
                      ? AppColors.yellow
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Slide
// ─────────────────────────────────────────────────────────────────────────────

class _SlideData {
  final String headline;
  final String sub;
  final String imagePath;
  final String fallback;

  const _SlideData({
    required this.headline,
    required this.sub,
    required this.imagePath,
    required this.fallback,
  });
}

class _SlideWidget extends StatelessWidget {
  final _SlideData data;
  final VoidCallback onCta;

  const _SlideWidget({required this.data, required this.onCta});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.yellowDim,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.yellowBorder),
                  ),
                  child: Text('HAMBÚRGUERES ARTESANAIS',
                      style: AppText.body(9,
                          color: AppColors.yellow, letterSpacing: 1.5)),
                ),
                const SizedBox(height: 12),
                Text(data.headline, style: AppText.display(34)),
                const SizedBox(height: 10),
                Text(data.sub,
                    style: AppText.body(13, color: AppColors.gray),
                    maxLines: 2),
                const SizedBox(height: 18),
                AppButton(label: 'Ver Cardápio', onTap: onCta),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Círculo com imagem real do produto
          Container(
            width: 115,
            height: 115,
            decoration: BoxDecoration(
              color: const Color(0xFF0E0E00),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                data.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Center(
                  child: Text(data.fallback,
                      style: const TextStyle(fontSize: 44)),
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
// Category Card
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String? imagePath;
  final String fallback;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.name,
    required this.subtitle,
    required this.imagePath,
    required this.fallback,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.black2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.yellowDim,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.hardEdge,
              child: imagePath != null
                  ? Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(
                        imagePath!,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            Center(child: Text(fallback)),
                      ),
                    )
                  : Center(
                      child: Text(fallback,
                          style: const TextStyle(fontSize: 20))),
            ),
            const SizedBox(height: 8),
            Text(name,
                style: AppText.body(13, weight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(subtitle,
                style: AppText.body(11, color: AppColors.gray),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Footer
// ─────────────────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black2,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          const AppDivider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LogoText(size: 20),
              Row(
                children: [
                  _SocialBtn(const AppIcon.instagram(size: 15, color: AppColors.gray)),
                  const SizedBox(width: 8),
                  _SocialBtn(const AppIcon.whatsapp(size: 15, color: AppColors.gray)),
                  const SizedBox(width: 8),
                  _SocialBtn(const AppIcon.tiktok(size: 15, color: AppColors.gray)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text('© 2025 Yag-go Burgers. Todos os direitos reservados.',
              style: AppText.body(11, color: AppColors.gray2)),
        ],
      ),
    );
  }
}

class _SocialBtn extends StatelessWidget {
  final Widget icon;
  const _SocialBtn(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: icon),
    );
  }
}
