import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../data/catalog.dart';
import '../../widgets/net_image.dart';
import 'products_screen.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final c = categories[i];
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ProductsScreen(category: c.name))),
          child: Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.field,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: NetImage(c.image),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(c.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                ),
                const Icon(Icons.chevron_right, color: AppColors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}
