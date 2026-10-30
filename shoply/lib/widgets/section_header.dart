import 'package:flutter/material.dart';
import '../core/theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;
  const SectionHeader({super.key, required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          GestureDetector(
            onTap: onViewAll,
            child: const Text('View All',
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
