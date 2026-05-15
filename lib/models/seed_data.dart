import 'category.dart';
import 'product.dart';

const List<Category> kCategories = [
  Category(id: 'burgers',  name: 'Hambúrgueres', subtitle: 'Clássicos, smash e especiais'),
  Category(id: 'combos',   name: 'Combos',        subtitle: 'Burger + fritas + bebida'),
  Category(id: 'drinks',   name: 'Bebidas',        subtitle: 'Sucos e milkshakes'),
  Category(id: 'desserts', name: 'Sobremesas',     subtitle: 'Brownies e sorvetes'),
];

// Caminho base dos assets
const _img = 'assets/images/';

const List<Product> kProducts = [
  // ── Hambúrgueres ──────────────────────────────────────────────────────────
  Product(
    id: 'p1',
    name: 'Smash Clássico',
    description: 'Blend 180g, queijo cheddar, alface, tomate e molho especial da casa.',
    price: 28.90,
    categoryId: 'burgers',
    emoji: '🍔',
    imagePath: '${_img}smash_classico.png',
    isPopular: true,
  ),
  Product(
    id: 'p2',
    name: 'Double Smash',
    description: 'Dois blends 120g, bacon crocante, duplo cheddar e cebola crispy.',
    price: 38.90,
    categoryId: 'burgers',
    emoji: '🍔',
    imagePath: '${_img}double_smash.png',
  ),
  Product(
    id: 'p3',
    name: 'Urban Supremo',
    description: 'Blend 200g, queijo brie, geleia de pimenta, rúcula e maionese trufada.',
    price: 45.90,
    categoryId: 'burgers',
    emoji: '🍔',
    imagePath: '${_img}urban_supremo.png',
    isPopular: true,
  ),
  Product(
    id: 'p4',
    name: 'Chicken Crispy',
    description: 'Frango empanado crocante, cheddar, picles e molho buffalo.',
    price: 32.90,
    categoryId: 'burgers',
    emoji: '🍗',
    imagePath: '${_img}chicken_crispy.png',
  ),
  // ── Combos ────────────────────────────────────────────────────────────────
  Product(
    id: 'p5',
    name: 'Combo Clássico',
    description: 'Smash Clássico + fritas M + refrigerante 350ml.',
    price: 44.90,
    categoryId: 'combos',
    emoji: '🍟',
    imagePath: '${_img}combo_classico.png',
    isPopular: true,
  ),
  Product(
    id: 'p6',
    name: 'Combo Double',
    description: 'Double Smash + fritas G + refrigerante 350ml.',
    price: 54.90,
    categoryId: 'combos',
    emoji: '🍟',
    imagePath: '${_img}combo_double.png',
  ),
  Product(
    id: 'p7',
    name: 'Combo Supremo',
    description: 'Urban Supremo + fritas G + suco natural 300ml.',
    price: 62.90,
    categoryId: 'combos',
    emoji: '🍟',
    imagePath: '${_img}combo_supremo.png',
  ),
  // ── Bebidas ───────────────────────────────────────────────────────────────
  Product(
    id: 'p8',
    name: 'Milkshake Baunilha',
    description: 'Milkshake cremoso de baunilha com chantilly e calda.',
    price: 18.90,
    categoryId: 'drinks',
    emoji: '🥤',
    imagePath: '${_img}milkshake_baunilha.png',
  ),
  Product(
    id: 'p9',
    name: 'Suco de Laranja',
    description: 'Suco natural de laranja espremido na hora, 400ml.',
    price: 12.90,
    categoryId: 'drinks',
    emoji: '🍊',
    imagePath: '${_img}laranja.png',
  ),
  Product(
    id: 'p10',
    name: 'Refrigerante Lata',
    description: 'Lata 350ml — Coca-Cola, Guaraná ou Sprite.',
    price: 8.90,
    categoryId: 'drinks',
    emoji: '🥫',
    imagePath: '${_img}refrigerante_lata.png',
  ),
  // ── Sobremesas ────────────────────────────────────────────────────────────
  Product(
    id: 'p11',
    name: 'Brownie Quente',
    description: 'Brownie de chocolate belga com sorvete de creme e calda.',
    price: 16.90,
    categoryId: 'desserts',
    emoji: '🍫',
    imagePath: '${_img}brownie_quente.png',
    isPopular: true,
  ),
  Product(
    id: 'p12',
    name: 'Sorvete Artesanal',
    description: '2 bolas — sabores: chocolate, morango ou creme.',
    price: 14.90,
    categoryId: 'desserts',
    emoji: '🍨',
    imagePath: '${_img}sorvete_artesanal.png',
  ),
];
