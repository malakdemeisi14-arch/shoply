import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../data/catalog.dart';
import '../../providers/favorites_provider.dart';
import '../../widgets/product_card.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ids = context.watch<FavoritesProvider>().ids;
    final list = products.where((p) => ids.contains(p.id)).toList();

    if (list.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 56, color: AppColors.grey),
            SizedBox(height: 10),
            Text('No favorites yet', style: TextStyle(color: AppColors.grey)),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (_, i) => ProductCard(product: list[i], showAddButton: true),
    );
  }
}
