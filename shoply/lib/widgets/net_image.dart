import 'package:flutter/material.dart';
import '../core/theme.dart';

class NetImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  const NetImage(this.url, {super.key, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
                strokeWidth: 2, color: AppColors.primary),
          ),
        );
      },
      errorBuilder: (_, __, ___) => const Center(
        child: Icon(Icons.image_not_supported_outlined, color: AppColors.grey),
      ),
    );
  }
}
