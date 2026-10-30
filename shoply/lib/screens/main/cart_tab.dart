import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../providers/cart_provider.dart';
import '../../services/order_service.dart';
import '../../widgets/net_image.dart';
import '../../widgets/primary_button.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  bool _busy = false;

  Future<void> _checkout() async {
    final cart = context.read<CartProvider>();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || cart.items.isEmpty) return;
    setState(() => _busy = true);
    final err = await OrderService.place(uid, List.of(cart.items), cart.total);
    if (!mounted) return;
    setState(() => _busy = false);
    if (err != null) {
      showMsg(context, err);
      return;
    }
    cart.clear();
    showMsg(context, 'Order placed successfully');
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items;

    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 56, color: AppColors.grey),
            SizedBox(height: 10),
            Text('Your cart is empty', style: TextStyle(color: AppColors.grey)),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final item = items[i];
              final p = item.product;
              return Row(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.field,
                        borderRadius: BorderRadius.circular(12)),
                    child: NetImage(p.thumb),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                        Text(money(p.price),
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _Mini(
                                icon: Icons.remove,
                                onTap: () =>
                                    context.read<CartProvider>().decrement(item)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text('${item.qty}'),
                            ),
                            _Mini(
                                icon: Icons.add,
                                onTap: () =>
                                    context.read<CartProvider>().increment(item)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: AppColors.danger, size: 22),
                    onPressed: () => context.read<CartProvider>().remove(item),
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFEDEFED))),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(money(cart.total),
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                  label: 'Checkout', onPressed: _checkout, loading: _busy),
            ],
          ),
        ),
      ],
    );
  }
}

class _Mini extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _Mini({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
            color: AppColors.field, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 15),
      ),
    );
  }
}
