import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../data/catalog.dart';
import '../../widgets/net_image.dart';
import '../../widgets/product_card.dart';
import '../../widgets/section_header.dart';
import 'products_screen.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onSeeCategories;
  const HomeTab({super.key, required this.onSeeCategories});

  void _openProducts(BuildContext context, [String? category]) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ProductsScreen(category: category)));
  }

  @override
  Widget build(BuildContext context) {
    final trending = products.where((p) => p.isTrending).take(4).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GestureDetector(
          onTap: () => _openProducts(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/sales.png', fit: BoxFit.cover),
          ),
        ),
        SectionHeader(title: 'Categories', onViewAll: onSeeCategories),
        SizedBox(
          height: 86,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, i) {
              final c = categories[i];
              return GestureDetector(
                onTap: () => _openProducts(context, c.name),
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: AppColors.field,
                          borderRadius: BorderRadius.circular(14)),
                      child: NetImage(c.image),
                    ),
                    const SizedBox(height: 6),
                    Text(c.name, style: const TextStyle(fontSize: 11)),
                  ],
                ),
              );
            },
          ),
        ),
        SectionHeader(
            title: 'Trending Products', onViewAll: () => _openProducts(context)),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: trending.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.82,
          ),
          itemBuilder: (_, i) => ProductCard(product: trending[i]),
        ),
      ],
    );
  }
}
