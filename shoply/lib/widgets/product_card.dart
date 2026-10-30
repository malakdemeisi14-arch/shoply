import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../core/utils.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../screens/main/product_details_screen.dart';
import 'net_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool showAddButton;
  const ProductCard({super.key, required this.product, this.showAddButton = false});

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavoritesProvider>().isFav(product.id);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.field,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.all(8),
                    child: NetImage(product.thumb),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () =>
                        context.read<FavoritesProvider>().toggle(product.id),
                    child: Icon(
                      fav ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: fav ? AppColors.primary : AppColors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(money(product.price),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          if (showAddButton) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 34,
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartProvider>().add(product);
                  showMsg(context, '${product.name} added to cart');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Add to Cart', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
