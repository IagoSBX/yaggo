import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_divider.dart';
import '../widgets/app_icons.dart';
import '../widgets/logo_text.dart';
import '../widgets/section_heading.dart';
import 'orders_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final double subtotal;
  final double deliveryFee;

  const CheckoutScreen({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey    = GlobalKey<FormState>();
  final _nameCtrl   = TextEditingController();
  final _phoneCtrl  = TextEditingController();
  final _addrCtrl   = TextEditingController();
  final _compCtrl   = TextEditingController();

  int  _payIndex = 0;
  bool _loading  = false;

  double get _total => widget.subtotal + widget.deliveryFee;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addrCtrl.dispose();
    _compCtrl.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    final order = context.read<AppProvider>().placeOrder(address: _addrCtrl.text.trim());
    setState(() => _loading = false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => _ConfirmationScreen(orderId: order.id)),
      (r) => r.isFirst,
    );
  }

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
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SectionHeading(label: 'Finalize seu pedido', title: 'Checkout'),
            const SizedBox(height: 24),

            // ── Resumo ────────────────────────────────────────────────────
            _Section(
              title: 'Resumo do Pedido',
              child: Column(
                children: [
                  ...provider.cartItems.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text('${item.product.emoji}  ', style: const TextStyle(fontSize: 14)),
                        Expanded(child: Text('${item.quantity}x ${item.product.name}', style: AppText.body(13))),
                        Text('R\$ ${item.subtotal.toStringAsFixed(2)}', style: AppText.body(13, color: AppColors.gray)),
                      ],
                    ),
                  )),
                  const SizedBox(height: 10),
                  const AppDivider(),
                  const SizedBox(height: 10),
                  _TotalRow('Subtotal', widget.subtotal),
                  const SizedBox(height: 4),
                  _TotalRow('Entrega', widget.deliveryFee),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppText.body(15, weight: FontWeight.w500)),
                      Text('R\$ ${_total.toStringAsFixed(2)}',
                          style: AppText.body(16, color: AppColors.yellow, weight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Dados de entrega ──────────────────────────────────────────
            _Section(
              title: 'Dados de Entrega',
              child: Column(
                children: [
                  _Field(ctrl: _nameCtrl,  label: 'Nome completo',          hint: 'João da Silva',
                      validator: (v) => v == null || v.trim().isEmpty ? 'Informe seu nome' : null),
                  const SizedBox(height: 12),
                  _Field(ctrl: _phoneCtrl, label: 'Telefone', hint: '(11) 9 9999-9999',
                      keyboardType: TextInputType.phone,
                      validator: (v) => v == null || v.trim().isEmpty ? 'Informe seu telefone' : null),
                  const SizedBox(height: 12),
                  _Field(ctrl: _addrCtrl,  label: 'Endereço',  hint: 'Rua, número, bairro',
                      validator: (v) => v == null || v.trim().isEmpty ? 'Informe o endereço' : null),
                  const SizedBox(height: 12),
                  _Field(ctrl: _compCtrl,  label: 'Complemento (opcional)', hint: 'Apto, bloco...'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Pagamento ─────────────────────────────────────────────────
            _Section(
              title: 'Forma de Pagamento',
              child: Column(
                children: [
                  _PayOption(index: 0, selected: _payIndex,
                      icon: const AppIcon.creditCard(size: 20),
                      label: 'Cartão de crédito/débito',
                      onTap: (i) => setState(() => _payIndex = i)),
                  const SizedBox(height: 8),
                  _PayOption(index: 1, selected: _payIndex,
                      icon: const AppIcon.pix(size: 20),
                      label: 'Pix',
                      onTap: (i) => setState(() => _payIndex = i)),
                  const SizedBox(height: 8),
                  _PayOption(index: 2, selected: _payIndex,
                      icon: const AppIcon.cash(size: 20),
                      label: 'Dinheiro na entrega',
                      onTap: (i) => setState(() => _payIndex = i)),
                ],
              ),
            ),

            const SizedBox(height: 28),

            _loading
                ? const Center(child: CircularProgressIndicator(color: AppColors.yellow, strokeWidth: 2))
                : AppButton(
                    label: 'Confirmar Pedido  •  R\$ ${_total.toStringAsFixed(2)}',
                    fullWidth: true,
                    onTap: _confirm,
                  ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Confirmation screen
// ─────────────────────────────────────────────────────────────────────────────

class _ConfirmationScreen extends StatelessWidget {
  final String orderId;
  const _ConfirmationScreen({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── ícone de confirmação ────────────────────────────────────
              Container(
                width: 80, height: 80,
                decoration: const BoxDecoration(color: AppColors.yellowDim, shape: BoxShape.circle),
                child: const Center(
                  child: AppIcon.checkCircleLarge(size: 42, color: AppColors.yellow),
                ),
              ),
              const SizedBox(height: 24),
              Text('Pedido Confirmado!', style: AppText.display(38)),
              const SizedBox(height: 10),
              Text('Seu pedido #$orderId foi recebido e está sendo preparado.',
                  style: AppText.body(14, color: AppColors.gray), textAlign: TextAlign.center),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.yellowDim,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.yellowBorder),
                ),
                child: Text('Previsão: 30–45 minutos',
                    style: AppText.body(13, color: AppColors.yellow)),
              ),
              const SizedBox(height: 40),
              AppButton(
                label: 'Ver Meus Pedidos',
                fullWidth: true,
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const OrdersScreen()),
                  (r) => r.isFirst,
                ),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Voltar ao Início',
                fullWidth: true,
                outlined: true,
                onTap: () => Navigator.popUntil(context, (r) => r.isFirst),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppText.body(12, color: AppColors.yellow, weight: FontWeight.w500, letterSpacing: 0.5)),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label, hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _Field({required this.ctrl, required this.label, required this.hint,
      this.keyboardType, this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.body(12, color: AppColors.gray)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl,
          keyboardType: keyboardType,
          validator: validator,
          style: AppText.body(14),
          cursorColor: AppColors.yellow,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppText.body(14, color: AppColors.gray),
            filled: true,
            fillColor: AppColors.black3,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.yellowBorder)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.redAccent)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.redAccent)),
          ),
        ),
      ],
    );
  }
}

class _PayOption extends StatelessWidget {
  final int index, selected;
  final Widget icon;
  final String label;
  final ValueChanged<int> onTap;

  const _PayOption({required this.index, required this.selected,
      required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final active = index == selected;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: active ? AppColors.yellowDim : AppColors.black3,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: active ? AppColors.yellowBorder : AppColors.border),
        ),
        child: Row(
          children: [
            // colorize icon when active
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  active ? AppColors.yellow : AppColors.gray, BlendMode.srcIn),
              child: icon,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(label, style: AppText.body(14, color: active ? AppColors.yellow : AppColors.white))),
            if (active) const AppIcon.checkCircle(size: 18, color: AppColors.yellow),
          ],
        ),
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final double value;
  const _TotalRow(this.label, this.value);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppText.body(13, color: AppColors.gray)),
          Text('R\$ ${value.toStringAsFixed(2)}', style: AppText.body(13, color: AppColors.gray)),
        ],
      );
}
