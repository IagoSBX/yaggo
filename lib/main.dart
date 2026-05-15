import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'widgets/app_icons.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const YaggoApp(),
    ),
  );
}

class YaggoApp extends StatelessWidget {
  const YaggoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yag-go Burgers',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const _RootShell(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Root shell com BottomNavigationBar
// ─────────────────────────────────────────────────────────────────────────────

class _RootShell extends StatefulWidget {
  const _RootShell();

  @override
  State<_RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<_RootShell> {
  int _currentIndex = 0;

  static const _screens = <Widget>[
    HomeScreen(),
    MenuScreen(),
    CartScreen(),
    OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<AppProvider>().cartCount;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.black2,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon:       const AppIcon.homeOutlined(size: 22),
                  activeIcon: const AppIcon.home(size: 22),
                  label: 'Início',   index: 0, current: _currentIndex, onTap: _onTap,
                ),
                _NavItem(
                  icon:       const AppIcon.menuOutlined(size: 22),
                  activeIcon: const AppIcon.menu(size: 22),
                  label: 'Cardápio', index: 1, current: _currentIndex, onTap: _onTap,
                ),
                _NavItemCart(
                  index: 2, current: _currentIndex, count: cartCount, onTap: _onTap,
                ),
                _NavItem(
                  icon:       const AppIcon.receiptOutlined(size: 22),
                  activeIcon: const AppIcon.receipt(size: 22),
                  label: 'Pedidos',  index: 3, current: _currentIndex, onTap: _onTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(int i) => setState(() => _currentIndex = i);
}

// ─────────────────────────────────────────────────────────────────────────────
//  Nav item genérico
// ─────────────────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final Widget icon;
  final Widget activeIcon;
  final String label;
  final int index, current;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.yellowDim : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // troca o ícone pela versão colorida quando ativo
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                active ? AppColors.yellow : AppColors.gray,
                BlendMode.srcIn,
              ),
              child: active ? activeIcon : icon,
            ),
            const SizedBox(height: 3),
            Text(label,
                style: AppText.body(10,
                    color: active ? AppColors.yellow : AppColors.gray,
                    weight: active ? FontWeight.w500 : FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Nav item carrinho (com badge)
// ─────────────────────────────────────────────────────────────────────────────

class _NavItemCart extends StatelessWidget {
  final int index, current, count;
  final ValueChanged<int> onTap;

  const _NavItemCart({
    required this.index,
    required this.current,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.yellowDim : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    active ? AppColors.yellow : AppColors.gray,
                    BlendMode.srcIn,
                  ),
                  child: active
                      ? const AppIcon.bag(size: 22)
                      : const AppIcon.bagOutlined(size: 22),
                ),
                if (count > 0)
                  Positioned(
                    top: -5, right: -7,
                    child: Container(
                      width: 16, height: 16,
                      decoration: const BoxDecoration(
                          color: AppColors.yellow, shape: BoxShape.circle),
                      child: Center(
                        child: Text('$count',
                            style: AppText.body(8,
                                color: AppColors.black, weight: FontWeight.w600)),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text('Carrinho',
                style: AppText.body(10,
                    color: active ? AppColors.yellow : AppColors.gray,
                    weight: active ? FontWeight.w500 : FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
