import 'package:flutter/material.dart';
import '../../data/catalog.dart';
import '../../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  final String? category;
  const ProductsScreen({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final list = category == null
        ? products
        : products.where((p) => p.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category ?? 'All Products'),
        actions: [IconButton(icon: const Icon(Icons.tune), onPressed: () {})],
      ),
      body: list.isEmpty
          ? const Center(child: Text('No products found'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (_, i) => ProductCard(product: list[i]),
            ),
    );
  }
}
