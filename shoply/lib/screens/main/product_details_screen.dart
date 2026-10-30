import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../widgets/net_image.dart';
import '../../widgets/primary_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _qty = 1;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final fav = context.watch<FavoritesProvider>().isFav(p.id);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(fav ? Icons.favorite : Icons.favorite_border,
                color: fav ? AppColors.primary : AppColors.text),
            onPressed: () => context.read<FavoritesProvider>().toggle(p.id),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: AppColors.field,
                        borderRadius: BorderRadius.circular(24)),
                    child: PageView.builder(
                      itemCount: p.images.length,
                      onPageChanged: (i) => setState(() => _page = i),
                      itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.all(12),
                        child: NetImage(p.images[i]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      p.images.length,
                      (i) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _page
                              ? AppColors.primary
                              : const Color(0xFFD5D9D6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(p.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(money(p.price),
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text('${p.rating} (${p.reviews})',
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(p.description,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.grey, height: 1.5)),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Text('Quantity',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const Spacer(),
                      _QtyButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (_qty > 1) setState(() => _qty--);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text('$_qty',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                      _QtyButton(
                          icon: Icons.add, onTap: () => setState(() => _qty++)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PrimaryButton(
                label: 'Add to Cart',
                onPressed: () {
                  context.read<CartProvider>().add(p, _qty);
                  showMsg(context, '${p.name} added to cart');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
            color: AppColors.field, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
