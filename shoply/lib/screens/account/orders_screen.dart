import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../data/catalog.dart';
import '../../models/order_model.dart';
import '../../services/order_service.dart';
import '../../widgets/net_image.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _filter = 0; // 0 All, 1 Active, 2 Completed
  static const _labels = ['All', 'Active', 'Completed'];

  Color _statusColor(String s) {
    switch (s) {
      case 'Approved':
        return AppColors.primary;
      case 'Delivered':
        return const Color(0xFF2E7D32);
      default:
        return const Color(0xFFE59A1B);
    }
  }

  void _details(OrderModel o) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order #${o.number}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            ...o.items.map((it) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${it['name']}  x${it['qty']}'),
                      Text(money(((it['price'] as num?) ?? 0).toDouble() *
                          ((it['qty'] as num?) ?? 1).toDouble())),
                    ],
                  ),
                )),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                Text(money(o.total),
                    style: const TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: uid == null
          ? const Center(child: Text('Please log in'))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: List.generate(3, (i) {
                      final sel = _filter == i;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _filter = i),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              color: sel ? AppColors.primary : AppColors.field,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(_labels[i],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: sel ? Colors.white : AppColors.text)),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<OrderModel>>(
                    stream: OrderService.stream(uid),
                    builder: (context, snap) {
                      if (snap.hasError) {
                        return const Center(child: Text('Could not load orders'));
                      }
                      if (!snap.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      var list = snap.data!;
                      if (_filter == 1) {
                        list = list.where((o) => !o.isCompleted).toList();
                      } else if (_filter == 2) {
                        list = list.where((o) => o.isCompleted).toList();
                      }
                      if (list.isEmpty) {
                        return const Center(
                            child: Text('No orders yet',
                                style: TextStyle(color: AppColors.grey)));
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (_, i) => _card(list[i]),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _card(OrderModel o) {
    final first = o.items.isNotEmpty ? o.items.first : null;
    final product = first == null ? null : productById('${first['productId']}');
    final color = _statusColor(o.status);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8EAE8)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order #${o.number}',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700)),
                  Text(DateFormat('MMM dd, yyyy').format(o.date),
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.grey)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(o.status,
                    style: TextStyle(
                        fontSize: 11,
                        color: color,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.field,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: product == null
                    ? const Icon(Icons.shopping_bag, color: AppColors.primary)
                    : NetImage(product.thumb),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${first?['name'] ?? 'Order'}',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                    Text(
                        '${o.items.length} item${o.items.length == 1 ? '' : 's'}',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.grey)),
                    Text(money(o.total),
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: OutlinedButton(
              onPressed: () => _details(o),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('View Details',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
